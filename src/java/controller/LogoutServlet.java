package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý việc đăng xuất người dùng khỏi hệ thống
 * URL Pattern: /logout
 * Phương thức: GET
 * 
 * Quy trình đăng xuất:
 * 1. Kiểm tra session hiện tại
 * 2. Nếu session tồn tại:
 *    - Hủy session và các thuộc tính liên quan (invalidate)
 *    - Xóa toàn bộ thông tin người dùng khỏi bộ nhớ
 * 3. Chuyển hướng người dùng về trang chủ
 * 
 * Lưu ý: Không cần kiểm tra người dùng đã đăng nhập hay chưa,
 * vì nếu chưa đăng nhập thì không có session để hủy.
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    
    /**
     * Xử lý yêu cầu GET để đăng xuất người dùng
     * 
     * Quy trình xử lý:
     * 1. Lấy session hiện tại (nếu có)
     * 2. Hủy session để đăng xuất
     * 3. Chuyển hướng về trang chủ
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Bước 1: Lấy session hiện tại (getSession(false) để không tạo session mới nếu chưa có)
        HttpSession session = request.getSession(false);
        
        // Bước 2: Nếu session tồn tại thì hủy nó
        if (session != null) {
            session.invalidate(); // Hủy session và xóa mọi thuộc tính liên quan
        }
        
        // Bước 3: Chuyển hướng người dùng về trang chủ
        response.sendRedirect(request.getContextPath() + "/home");
    }
}