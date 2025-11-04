package controller;

import dal.AdminDAO;
import model.Event;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Quản Lý Sự Kiện - Giao Diện Admin
 * ================================
 * 
 * 1. Vai Trò của ManageEventsServlet
 *    - Như "Ban Tổ Chức" của trường:
 *      + Xem xét các sự kiện được đề xuất
 *      + Phê duyệt hoặc từ chối sự kiện
 *      + Đảm bảo sự kiện phù hợp với quy định
 * 
 * 2. Quy Trình Xử Lý
 *    a. Hiển Thị Danh Sách:
 *       - Lấy danh sách sự kiện chờ duyệt
 *       - Hiển thị chi tiết từng sự kiện
 * 
 *    b. Xử Lý Phê Duyệt:
 *       - Kiểm tra quyền Admin
 *       - Xác nhận hoặc từ chối sự kiện
 *       - Cập nhật trạng thái trong database
 * 
 * 3. Ví Dụ Thực Tế
 *    - Giống như quy trình duyệt tổ chức sự kiện:
 *      + Các CLB nộp đề xuất tổ chức
 *      + Ban quản lý xem xét tính khả thi
 *      + Đưa ra quyết định cho phép hay không
 */
@WebServlet(name = "ManageEventsServlet", urlPatterns = {"/admin/events"})
public class ManageEventsServlet extends HttpServlet {

    /**
     * DAO đối tượng để tương tác với chức năng quản trị
     * AdminDAO cung cấp các phương thức:
     * - getPendingEvents(): Lấy danh sách sự kiện chờ duyệt
     * - approveEvent(): Phê duyệt sự kiện
     * - rejectEvent(): Từ chối sự kiện
     */
    private AdminDAO adminDAO;

    /**
     * Khởi tạo AdminDAO khi servlet được tạo
     * @throws ServletException nếu có lỗi xảy ra trong quá trình khởi tạo
     */
    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }

    /**
     * Xử lý yêu cầu GET để hiển thị trang quản lý sự kiện
     * 
     * Quy trình xử lý:
     * 1. Kiểm tra quyền truy cập Admin
     * 2. Lấy danh sách sự kiện đang chờ phê duyệt
     * 3. Chuyển hướng đến trang giao diện quản lý
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra quyền truy cập Admin
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getRoleName())) {
            // Nếu không phải Admin, trả về lỗi 403 Forbidden
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Bước 2: Lấy danh sách sự kiện chờ duyệt
        List<Event> pendingEvents = adminDAO.getPendingEvents();
        request.setAttribute("pendingEvents", pendingEvents);

        // Bước 3: Chuyển đến trang giao diện quản lý
        request.getRequestDispatcher("/admin-events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        boolean success = false;
        if ("approve".equals(action)) {
            success = adminDAO.approveEvent(eventId);
        } else if ("reject".equals(action)) {
            success = adminDAO.rejectEvent(eventId);
        }

        response.sendRedirect(request.getContextPath() + "/admin/events");
    }
}
