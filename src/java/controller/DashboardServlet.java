package controller;

import dal.MemberDAO;
import dal.EventDAO;
import model.User;
import model.Member;
import model.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Mô hình hoạt động của Servlet và DAO trong Dashboard
 * ================================================
 * 
 * 1. Servlet - Người phục vụ (DashboardServlet)
 *    - Nhiệm vụ: Hiển thị trang Dashboard cho người dùng
 *    - Quy trình làm việc:
 *      + Kiểm tra người dùng đã đăng nhập chưa
 *      + Yêu cầu DAO lấy thông tin cần thiết
 *      + Gửi thông tin đến trang JSP để hiển thị
 * 
 * 2. DAO - Người quản lý dữ liệu (MemberDAO và EventDAO)
 *    - MemberDAO: Chuyên xử lý thông tin thành viên
 *      + Lấy danh sách thành viên
 *      + Kiểm tra tư cách thành viên
 *      + Cập nhật thông tin thành viên
 *    
 *    - EventDAO: Chuyên xử lý thông tin sự kiện
 *      + Lấy danh sách sự kiện
 *      + Thêm sự kiện mới
 *      + Cập nhật thông tin sự kiện
 * 
 * Ví dụ thực tế:
 * - Giống như nhà hàng:
 *   + Servlet = Nhân viên phục vụ: tiếp nhận yêu cầu, mang món ăn
 *   + DAO = Đầu bếp: nấu món ăn theo yêu cầu
 *   + Database = Nhà bếp: nơi lưu trữ nguyên liệu
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    /*
     * DashboardServlet
     * (Tiếng Việt)
     * Mục đích: Hiển thị trang Dashboard chung cho người dùng đã đăng nhập.
     * - Input: Session phải chứa đối tượng "user" (User) để biết người dùng hiện tại.
     * - Xử lý chính:
     *   + Lấy danh sách CLB mà người dùng đã tham gia (myClubs) thông qua MemberDAO.
     *   + Lấy danh sách sự kiện sắp diễn ra (upcomingEvents) thông qua EventDAO.
     * - Output: Đặt các attribute request: "myClubs", "upcomingEvents" rồi forward tới `dashboard.jsp`.
     * - Lỗi/điều kiện: Nếu chưa đăng nhập -> redirect tới `/login`.
     *
     * Ghi chú:
     * - Đây là servlet trình hiện (presentation controller): không sửa đổi dữ liệu,
     *   chỉ thu thập thông tin và chuyển cho JSP hiển thị.
     */

    /**
     * DAO đối tượng để tương tác với bảng Member trong cơ sở dữ liệu.
     * Dùng để lấy thông tin về các câu lạc bộ mà người dùng tham gia.
     */
    private MemberDAO memberDAO;

    /**
     * DAO đối tượng để tương tác với bảng Event trong cơ sở dữ liệu.
     * Dùng để lấy danh sách các sự kiện sắp diễn ra.
     */
    private EventDAO eventDAO;

    /**
     * Khởi tạo các DAO khi servlet được tạo.
     * Phương thức này được gọi một lần khi servlet được khởi tạo.
     * 
     * @throws ServletException nếu có lỗi xảy ra trong quá trình khởi tạo các DAO
     */
    @Override
    public void init() throws ServletException {
        // Khởi tạo các DAO cần thiết để truy vấn dữ liệu cho dashboard
        memberDAO = new MemberDAO();
        eventDAO = new EventDAO();
    }

    /**
     * Xử lý yêu cầu GET để hiển thị trang dashboard cho người dùng đã đăng nhập
     * 
     * Quy trình xử lý:
     * 1. Kiểm tra session và xác thực người dùng
     * 2. Lấy thông tin các câu lạc bộ mà người dùng tham gia
     * 3. Lấy danh sách các sự kiện sắp diễn ra
     * 4. Hiển thị thông tin trên trang dashboard
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra session và xác thực người dùng
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin người dùng từ session
        User user = (User) session.getAttribute("user");

        // Bước 2: Lấy danh sách CLB mà người dùng tham gia
        List<Member> myClubs = memberDAO.getUserClubs(user.getUserID());
        request.setAttribute("myClubs", myClubs);

        // Bước 3: Lấy danh sách các sự kiện sắp diễn ra
        List<Event> upcomingEvents = eventDAO.getUpcomingEvents();
        request.setAttribute("upcomingEvents", upcomingEvents);

        // Bước 4: Chuyển hướng đến trang JSP để hiển thị dashboard
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
