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

    private MemberDAO memberDAO;
    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo các DAO cần thiết để truy vấn dữ liệu cho dashboard
        memberDAO = new MemberDAO();
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra session: chỉ cho phép truy cập khi đã đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Lấy danh sách CLB mà user thuộc về để hiển thị trong phần 'My Clubs'
        List<Member> myClubs = memberDAO.getUserClubs(user.getUserID());
        request.setAttribute("myClubs", myClubs);

        // Lấy các sự kiện sắp tới để hiển thị
        List<Event> upcomingEvents = eventDAO.getUpcomingEvents();
        request.setAttribute("upcomingEvents", upcomingEvents);

        // Forward tới JSP chịu trách nhiệm render giao diện
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
