package controller;

import dal.AdminDAO;
import model.AdminStats;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AdminDashboardServlet - Servlet xử lý trang dashboard của Admin
 * ============================================================
 * Chức năng chính:
 * - Hiển thị thống kê tổng quan về hệ thống cho Admin
 * - Kiểm tra quyền truy cập (chỉ Admin mới được phép vào trang này)
 * - Lấy dữ liệu thống kê từ AdminDAO và truyền cho trang JSP
 * 
 * URL Pattern: /admin/dashboard
 * 
 * Quy trình xử lý:
 * 1. Kiểm tra session và quyền truy cập
 * 2. Lấy thống kê từ AdminDAO
 * 3. Chuyển dữ liệu đến trang admin-dashboard.jsp
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    
    /**
     * AdminDAO - Đối tượng thực hiện các thao tác với cơ sở dữ liệu liên quan đến Admin
     * Được khởi tạo trong phương thức init()
     */
    private AdminDAO adminDAO;
    
    /**
     * Phương thức init() - Khởi tạo Servlet
     * ====================================
     * Được gọi một lần duy nhất khi Servlet được tạo
     * Nhiệm vụ: Khởi tạo đối tượng AdminDAO để thao tác với database
     */
    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }
    
    /**
     * Phương thức doGet() - Xử lý yêu cầu GET
     * ======================================
     * Được gọi khi admin truy cập trang dashboard
     * 
     * Các bước xử lý:
     * 1. Kiểm tra session:
     *    - Nếu chưa đăng nhập: Chuyển về trang login
     * 
     * 2. Kiểm tra quyền:
     *    - Phải là Admin mới được phép truy cập
     *    - Nếu không phải Admin: Trả về lỗi 403
     * 
     * 3. Lấy thống kê:
     *    - Gọi adminDAO.getAdminStats() để lấy các số liệu
     *    - Đặt kết quả vào request attribute
     * 
     * 4. Hiển thị trang:
     *    - Forward đến trang admin-dashboard.jsp
     * 
     * Input:
     * - request: Chứa thông tin yêu cầu từ client
     * - response: Đối tượng dùng để trả về kết quả
     * 
     * Output: 
     * - Chuyển hướng về trang login nếu chưa đăng nhập
     * - Hiển thị lỗi 403 nếu không có quyền
     * - Hiển thị trang dashboard với thống kê nếu hợp lệ
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // BƯỚC 1: Kiểm tra phiên đăng nhập
        // =================================
        // - Lấy session hiện tại (false = không tạo mới nếu chưa có)
        // - Kiểm tra session và thông tin user trong session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Chưa đăng nhập -> Chuyển về trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // BƯỚC 2: Kiểm tra quyền Admin
        // =============================
        // - Lấy thông tin user từ session
        // - Kiểm tra role có phải là Admin không
        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getRoleName())) {
            // Không phải Admin -> Trả về lỗi 403 Forbidden
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        // BƯỚC 3: Lấy thống kê từ AdminDAO
        // ================================
        // - Gọi getAdminStats() để lấy các số liệu:
        //   + Tổng số câu lạc bộ
        //   + Số câu lạc bộ đang hoạt động
        //   + Tổng số thành viên
        //   + Số thành viên mới trong tháng
        //   + Tổng số sự kiện
        //   + Số sự kiện đã tổ chức
        AdminStats stats = adminDAO.getAdminStats();
        
        // BƯỚC 4: Truyền dữ liệu cho JSP
        // ==============================
        // - Đặt đối tượng AdminStats vào request với tên "stats"
        // - JSP sẽ dùng ${stats.xxx} để hiển thị các số liệu
        request.setAttribute("stats", stats);
        
        // BƯỚC 5: Chuyển đến trang JSP
        // ============================
        // - Forward request đến trang admin-dashboard.jsp
        // - Giữ nguyên request và response để JSP có thể truy cập dữ liệu
        request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
    }
}