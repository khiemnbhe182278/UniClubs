package controller;

/*
 * ManageRulesServlet
 * Mục đích: Hiển thị và quản lý danh sách "quy định" (rules) của một câu lạc bộ dành cho Leader.
 * Đường dẫn truy cập: /leader/rules
 *
 * Giải thích dễ hiểu cho người không biết code:
 * - "Servlet" là một thành phần chạy trên server, xử lý yêu cầu từ trình duyệt (web).
 * - Khi leader muốn xem danh sách quy định của CLB, trình duyệt sẽ gọi đường dẫn ở trên.
 * - Servlet này sẽ: kiểm tra người dùng đã đăng nhập, lấy mã CLB từ yêu cầu,
 *   kiểm tra CLB có tồn tại, lấy danh sách quy định từ cơ sở dữ liệu và hiển thị qua trang JSP.
 * - "Forward" (chuyển tiếp) có nghĩa là server đưa dữ liệu sang tệp JSP để tạo trang HTML trả về cho người dùng.
 */
import dal.RuleDAO;
import dal.ClubDAO;
import model.Rule;
import model.User;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageRulesServlet", urlPatterns = {"/leader/rules"})
public class ManageRulesServlet extends HttpServlet {

    // Khai báo DAO (Data Access Object) để làm việc với dữ liệu trong cơ sở dữ liệu
    // RuleDAO: chức năng liên quan tới "quy định" (rules) - truy vấn, thêm, sửa, xóa
    private RuleDAO ruleDAO;      
    // ClubDAO: chức năng lấy thông tin câu lạc bộ (dùng để kiểm tra CLB tồn tại, quyền sở hữu...)
    private ClubDAO clubDAO;      

    /*
     * Khởi tạo các DAO khi servlet được nạp lần đầu.
     * Giải thích cho người không biết code:
     * - Đây là bước chuẩn bị tài nguyên để chúng ta có thể lấy/ghi dữ liệu vào cơ sở dữ liệu.
     * - Nếu bước này thất bại, servlet sẽ báo lỗi và không phục vụ được yêu cầu.
     */
    @Override
    public void init() throws ServletException {
        ruleDAO = new RuleDAO();
        clubDAO = new ClubDAO();
    }

    /*
     * Xử lý hiển thị danh sách quy định của một CLB
     * Mô tả bước-đơn-giản cho người không biết code:
     * - Kiểm tra người dùng đã đăng nhập hay chưa (nếu chưa -> yêu cầu đăng nhập).
     * - Lấy mã CLB từ yêu cầu (URL hoặc form). Nếu không có mã CLB -> báo lỗi.
     * - Chuyển mã CLB sang số, kiểm tra CLB có tồn tại.
     * - Nếu CLB tồn tại -> lấy danh sách quy định của CLB từ CSDL và gửi sang JSP để hiển thị.
     * - Nếu có lỗi (mã CLB không phải số, CSDL lỗi, ...) -> hiển thị thông báo lỗi hợp lý.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy session hiện tại (nếu có). Session là nơi lưu thông tin đăng nhập của người dùng.
        HttpSession session = request.getSession(false);

        // Nếu không có session thì người dùng chưa đăng nhập -> chuyển tới trang login
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin user trong session để kiểm tra quyền
        User user = (User) session.getAttribute("user");

        // Nếu không có thông tin user thì cũng chuyển về login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Lấy tham số 'clubId' từ URL hoặc form
            String clubIdParam = request.getParameter("clubId");

            // Nếu không có clubId -> không biết lấy quy định của CLB nào -> báo lỗi
            if (clubIdParam == null || clubIdParam.trim().isEmpty()) {
                // Đặt thông báo lỗi để JSP hiển thị
                request.setAttribute("error", "Vui lòng chọn câu lạc bộ");
                request.getRequestDispatcher("/WEB-INF/views/leader-rules.jsp").forward(request, response);
                return;
            }

            // Chuyển clubId từ chuỗi sang số nguyên
            int clubId = Integer.parseInt(clubIdParam);

            // Từ clubId, lấy thông tin CLB để kiểm tra CLB có tồn tại hay không
            Club club = clubDAO.getClubById(clubId);

            // Nếu không tìm thấy CLB -> báo lỗi cho người dùng
            if (club == null) {
                request.setAttribute("error", "Không tìm thấy câu lạc bộ");
                request.getRequestDispatcher("/WEB-INF/views/leader-rules.jsp").forward(request, response);
                return;
            }

            // Lấy danh sách quy định của CLB từ CSDL thông qua RuleDAO
            // rules là một danh sách các đối tượng Rule (mỗi Rule có id, tiêu đề, nội dung...)
            List<Rule> rules = ruleDAO.getRulesByClubId(clubId);

            // Đặt dữ liệu vào request để JSP có thể truy cập và hiển thị
            // - 'club' để hiển thị tên/chi tiết CLB
            // - 'rules' để hiển thị danh sách quy định
            request.setAttribute("club", club);
            request.setAttribute("rules", rules);

            // Forward (chuyển tiếp) tới trang JSP chịu trách nhiệm hiển thị danh sách
            request.getRequestDispatcher("/WEB-INF/views/leader-rules.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Nếu clubId không phải là số hợp lệ, hiển thị thông báo lỗi
            request.setAttribute("error", "ID câu lạc bộ không hợp lệ");
            request.getRequestDispatcher("/WEB-INF/views/leader-rules.jsp").forward(request, response);
        } catch (Exception e) {
            // Bắt mọi lỗi khác để tránh crash và trả về thông báo thân thiện
            System.err.println("Lỗi trong ManageRulesServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/views/leader-rules.jsp").forward(request, response);
        }
    }

    /* Chuyển các POST request sang GET */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
