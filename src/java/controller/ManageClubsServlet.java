package controller;

import dal.AdminDAO;
import model.Club;
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
 * Quản Lý Câu Lạc Bộ - Giao Diện Admin
 * ===================================
 * 
 * 1. Vai Trò của ManageClubsServlet
 *    - Như "Ban Quản Lý" của trường:
 *      + Xem xét các CLB mới đăng ký thành lập
 *      + Phê duyệt hoặc từ chối yêu cầu thành lập CLB
 *      + Giám sát hoạt động của các CLB
 * 
 * 2. Quy Trình Xử Lý
 *    a. Hiển Thị Danh Sách:
 *       - Lấy danh sách CLB đang chờ phê duyệt
 *       - Hiển thị thông tin chi tiết từng CLB
 * 
 *    b. Xử Lý Phê Duyệt:
 *       - Kiểm tra quyền Admin
 *       - Xác nhận hoặc từ chối CLB
 *       - Cập nhật trạng thái trong database
 * 
 * 3. Ví Dụ Thực Tế
 *    - Giống như quy trình thẩm định hồ sơ:
 *      + Tiếp nhận hồ sơ xin thành lập CLB
 *      + Xem xét tính khả thi và phù hợp
 *      + Đưa ra quyết định phê duyệt
 */
@WebServlet(name = "ManageClubsServlet", urlPatterns = {"/admin/clubs"})
public class ManageClubsServlet extends HttpServlet {
    
    /**
     * DAO đối tượng để tương tác với chức năng quản trị
     * AdminDAO cung cấp các phương thức:
     * - getPendingClubs(): Lấy danh sách CLB chờ duyệt
     * - approveClub(): Phê duyệt CLB
     * - rejectClub(): Từ chối CLB
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
     * Xử lý yêu cầu GET để hiển thị trang quản lý CLB
     * 
     * Quy trình xử lý:
     * 1. Kiểm tra quyền truy cập Admin
     * 2. Lấy danh sách CLB đang chờ phê duyệt
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
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Bước 2: Lấy danh sách CLB chờ phê duyệt
        List<Club> pendingClubs = adminDAO.getPendingClubs();
        request.setAttribute("pendingClubs", pendingClubs);
        
        // Bước 3: Chuyển đến trang giao diện quản lý
        request.getRequestDispatcher("/admin-clubs.jsp").forward(request, response);
    }
    
    /**
     * Xử lý yêu cầu POST để phê duyệt hoặc từ chối CLB
     * 
     * Quy trình xử lý:
     * 1. Nhận thông tin hành động (phê duyệt/từ chối) và ID của CLB
     * 2. Thực hiện hành động tương ứng thông qua AdminDAO
     * 3. Chuyển hướng với thông báo kết quả
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Bước 1: Nhận thông tin từ form
        String action = request.getParameter("action");
        int clubId = Integer.parseInt(request.getParameter("clubId"));
        
        // Bước 2: Thực hiện hành động phê duyệt/từ chối
        boolean success = false;
        if ("approve".equals(action)) {
            // Phê duyệt CLB - CLB sẽ được kích hoạt và có thể hoạt động
            success = adminDAO.approveClub(clubId);
        } else if ("reject".equals(action)) {
            // Từ chối CLB - CLB sẽ bị xóa hoặc đánh dấu là bị từ chối
            success = adminDAO.rejectClub(clubId);
        }
        
        // Bước 3: Chuyển hướng với thông báo phù hợp
        if (success) {
            // Thành công: Quay lại trang quản lý với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/admin/clubs?success=true");
        } else {
            // Thất bại: Quay lại trang quản lý với thông báo lỗi
            response.sendRedirect(request.getContextPath() + "/admin/clubs?error=true");
        }
    }
}