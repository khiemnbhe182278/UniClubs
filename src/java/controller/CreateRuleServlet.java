package controller;

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

@WebServlet(name = "CreateRuleServlet", urlPatterns = {"/leader/create-rule"})
public class CreateRuleServlet extends HttpServlet {

    /* 
     * RuleDAO: Đối tượng giúp thêm/sửa/xóa/truy vấn các quy định của câu lạc bộ trong cơ sở dữ liệu
     * Ví dụ: Thêm quy định mới, lấy danh sách quy định của một CLB
     */
    private RuleDAO ruleDAO;

    /*
     * ClubDAO: Đối tượng giúp truy vấn thông tin của các câu lạc bộ từ cơ sở dữ liệu
     * Ví dụ: Kiểm tra một CLB có tồn tại không, lấy thông tin chi tiết của CLB
     */
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        try {
            // Khởi tạo các đối tượng để làm việc với cơ sở dữ liệu
            ruleDAO = new RuleDAO();
            clubDAO = new ClubDAO();
        } catch (Exception e) {
            // Nếu không khởi tạo được -> thông báo lỗi
            throw new ServletException("Không thể kết nối tới cơ sở dữ liệu", e);
        }
    }

    /* 
     * Xử lý khi người dùng gửi yêu cầu tạo quy định mới (submit form)
     * 
     * Quy trình xử lý:
     * 1. Kiểm tra người dùng đã đăng nhập chưa
     * 2. Lấy thông tin quy định mới từ form
     * 3. Kiểm tra dữ liệu hợp lệ
     * 4. Lưu quy định mới vào cơ sở dữ liệu
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Bước 1: Kiểm tra phiên làm việc của người dùng
        if (session == null) {
            // Nếu chưa đăng nhập -> chuyển về trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin người dùng đã đăng nhập
        User user = (User) session.getAttribute("user");

        // Kiểm tra thông tin đăng nhập
        if (user == null) {
            // Nếu không có thông tin -> chuyển về trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Bước 2: Lấy thông tin quy định mới từ form người dùng đã gửi lên
            // - clubId: mã số của câu lạc bộ
            // - title: tiêu đề của quy định
            // - ruleText: nội dung chi tiết của quy định
            int clubId = Integer.parseInt(request.getParameter("clubId")); 
            String title = request.getParameter("title");
            String ruleText = request.getParameter("ruleText");

            // Bước 3: Kiểm tra các thông tin có đầy đủ và hợp lệ không
            if (title == null || title.trim().isEmpty()
                    || ruleText == null || ruleText.trim().isEmpty()) {
                // Nếu thiếu thông tin -> thông báo lỗi và quay lại trang quy định
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=invalid");
                return;
            }

            // Kiểm tra câu lạc bộ có tồn tại không
            Club club = clubDAO.getClubById(clubId);

            if (club == null) {
                // Nếu không tìm thấy CLB -> thông báo lỗi
                response.sendRedirect(request.getContextPath()
                        + "/leader/dashboard?error=clubnotfound");
                return;
            }

            // Bước 4: Tạo đối tượng quy định mới với các thông tin đã kiểm tra
            Rule rule = new Rule();
            rule.setClubID(clubId);             // Gán mã CLB
            rule.setTitle(title.trim());        // Gán tiêu đề (đã cắt khoảng trắng thừa)
            rule.setRuleText(ruleText.trim());  // Gán nội dung (đã cắt khoảng trắng thừa)

            // Bước 5: Lưu quy định mới vào cơ sở dữ liệu
            boolean success = ruleDAO.createRule(rule);  // Trả về true nếu lưu thành công

            // Bước 6: Kiểm tra kết quả và chuyển hướng người dùng
            if (success) {
                // Nếu lưu thành công -> chuyển về trang danh sách với thông báo thành công
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&success=created");
            } else {
                // Nếu lưu thất bại -> chuyển về trang danh sách với thông báo lỗi
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=failed");
            }

        } catch (NumberFormatException e) {
            // Xử lý khi mã số CLB không phải là số hợp lệ
            // Ví dụ: clubId = "abc" thay vì một con số
            response.sendRedirect(request.getContextPath()
                    + "/leader/dashboard?error=invalid");
        } catch (Exception e) {
            // Xử lý các lỗi không mong muốn khác
            // Ghi log lỗi để kiểm tra sau
            e.printStackTrace();
            // Thông báo cho người dùng
            response.sendRedirect(request.getContextPath()
                    + "/leader/dashboard?error=unexpected");
        }
    }

    /* 
     * Phương thức này được gọi khi hệ thống dừng hoạt động
     * Mục đích: Dọn dẹp bộ nhớ, đóng các kết nối để tránh rò rỉ tài nguyên
     */
    @Override
    public void destroy() {
        // Xóa các đối tượng truy cập CSDL khỏi bộ nhớ
        ruleDAO = null;    // Xóa đối tượng quản lý quy định
        clubDAO = null;    // Xóa đối tượng quản lý CLB
    }
}
