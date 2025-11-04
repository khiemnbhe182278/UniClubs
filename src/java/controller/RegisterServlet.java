package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Quy Trình Đăng Ký Tài Khoản
 * ==========================
 * 
 * 1. Vai Trò của RegisterServlet
 *    - Như "nhân viên tư vấn" tại quầy đăng ký:
 *      + Nhận thông tin từ người đăng ký
 *      + Kiểm tra tính hợp lệ của thông tin
 *      + Chuyển thông tin cho UserDAO xử lý
 *      + Thông báo kết quả cho người dùng
 * 
 * 2. Quy Trình Xử Lý
 *    a. Nhận Thông Tin:
 *       - Họ tên, email, mật khẩu,...
 *       - Như điền form đăng ký thành viên
 * 
 *    b. Kiểm Tra Hợp Lệ:
 *       - Email có đúng định dạng?
 *       - Mật khẩu đủ độ phức tạp?
 *       - Thông tin bắt buộc đã điền đủ?
 * 
 *    c. Xử Lý Đăng Ký:
 *       - UserDAO kiểm tra email đã tồn tại chưa
 *       - Mã hóa mật khẩu để bảo mật
 *       - Lưu thông tin vào cơ sở dữ liệu
 * 
 * 3. Ví Dụ Thực Tế
 *    - Giống như đăng ký thẻ thành viên:
 *      + Điền form thông tin
 *      + Nhân viên kiểm tra giấy tờ
 *      + Hệ thống xử lý và tạo thẻ
 *      + Thông báo kết quả cho khách
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    
    /**
     * DAO đối tượng để tương tác với bảng Users trong cơ sở dữ liệu.
     * UserDAO cung cấp các phương thức:
     * - register(user, password): Đăng ký tài khoản mới
     * - emailExists(email): Kiểm tra email đã tồn tại chưa
     * - hashPassword(password): Mã hóa mật khẩu
     */
    private UserDAO userDAO;
    
    /**
     * Khởi tạo UserDAO khi servlet được tạo.
     * Chỉ được gọi một lần khi servlet được khởi tạo.
     * 
     * @throws ServletException nếu có lỗi xảy ra trong quá trình khởi tạo
     */
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    /**
     * Xử lý yêu cầu GET để hiển thị form đăng ký
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form đăng ký cho người dùng
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
    
    /**
     * Xử lý yêu cầu POST để đăng ký tài khoản mới
     * 
     * Quy trình xử lý:
     * 1. Thu thập thông tin từ form đăng ký
     * 2. Kiểm tra tính hợp lệ của dữ liệu
     * 3. Kiểm tra email đã tồn tại chưa
     * 4. Tạo tài khoản mới nếu mọi thứ hợp lệ
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Bước 1: Thu thập thông tin từ form
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Bước 2: Kiểm tra tính hợp lệ của dữ liệu
        // Kiểm tra các trường bắt buộc
        if (userName == null || userName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra mật khẩu xác nhận
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra độ dài mật khẩu
        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Bước 3: Kiểm tra email đã tồn tại chưa
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email này đã được đăng ký");
            request.setAttribute("userName", userName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Bước 4: Tạo tài khoản mới
        // Khởi tạo đối tượng User với thông tin đã xác thực
        User user = new User();
        user.setUserName(userName.trim()); // Loại bỏ khoảng trắng thừa
        user.setEmail(email.trim().toLowerCase()); // Chuẩn hóa email: viết thường và loại bỏ khoảng trắng
        user.setRoleID(5); // Vai trò mặc định: Member
        
        // Đăng ký tài khoản qua UserDAO (mật khẩu sẽ được mã hóa trong DAO)
        boolean success = userDAO.register(user, password);
        
        // Kiểm tra kết quả đăng ký
        if (success) { // Nếu đăng ký thành công
            // Gửi thông báo thành công và chuyển đến trang đăng nhập
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Gửi thông báo lỗi và giữ lại thông tin đã nhập để người dùng sửa
            request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}