package controller;

import dal.EventDAO;
import dal.ClubDAO;
import model.Event;
import model.User;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Đánh dấu đây là một servlet (bộ xử lý yêu cầu web) với tên "DeleteEventServlet"
// Servlet này sẽ xử lý các yêu cầu đến địa chỉ "/leader/delete-event"
@WebServlet(name = "DeleteEventServlet", urlPatterns = { "/leader/delete-event" })
public class DeleteEventServlet extends HttpServlet {

    // Khai báo đối tượng để tương tác với database cho bảng Event
    private EventDAO eventDAO;

    // Khai báo đối tượng để tương tác với database cho bảng Club
    private ClubDAO clubDAO;

    // Phương thức khởi tạo - chạy một lần khi servlet được tạo lần đầu
    @Override
    public void init() throws ServletException {
        // Tạo mới các đối tượng DAO để sử dụng trong suốt vòng đời của servlet
        eventDAO = new EventDAO();
        clubDAO = new ClubDAO();
    }

    // Phương thức xử lý yêu cầu POST (khi người dùng gửi form xóa sự kiện)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // BƯỚC 1: KIỂM TRA ĐĂNG NHẬP
        // Lấy phiên làm việc hiện tại của người dùng (nếu có)
        // false = không tạo phiên mới nếu chưa có
        HttpSession session = request.getSession(false);

        // Kiểm tra xem người dùng đã đăng nhập chưa
        // Nếu chưa có phiên hoặc không có thông tin user trong phiên
        if (session == null || session.getAttribute("user") == null) {
            // Chuyển hướng người dùng về trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/login");
            return; // Dừng xử lý, không làm gì thêm
        }

        // BƯỚC 2: LẤY THÔNG TIN NGƯỜI DÙNG VÀ SỰ KIỆN CẦN XÓA
        // Lấy thông tin người dùng đã đăng nhập từ phiên
        User user = (User) session.getAttribute("user");

        // Lấy ID của sự kiện cần xóa từ form (đổi từ chuỗi sang số nguyên)
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // BƯỚC 3: XÁC MINH QUYỀN SỞ HỮU
        // Tìm sự kiện trong database dựa trên ID
        Event event = eventDAO.getEventById(eventId);

        // Nếu không tìm thấy sự kiện (có thể đã bị xóa hoặc không tồn tại)
        if (event == null) {
            // Trả về lỗi 404 (Not Found - Không tìm thấy)
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return; // Dừng xử lý
        }

        // LƯU Ý: Code thiếu phần kiểm tra quyền sở hữu thực sự
        // Cần thêm: kiểm tra xem user có phải là leader của club tổ chức sự kiện này
        // không
        // Ví dụ: if (event.getClubId() != user.getClubId()) { ... }

        // BƯỚC 4: THỰC HIỆN XÓA SỰ KIỆN
        // Gọi phương thức xóa sự kiện trong database
        // Kết quả trả về: true (xóa thành công) hoặc false (xóa thất bại)
        boolean success = eventDAO.deleteEvent(eventId);

        // BƯỚC 5: CHUYỂN HƯỚNG VÀ THÔNG BÁO KẾT QUẢ
        if (success) {
            // Nếu xóa thành công: chuyển về trang dashboard với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?success=event_deleted");
        } else {
            // Nếu xóa thất bại: chuyển về trang dashboard với thông báo lỗi
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=delete_failed");
        }
    }
}