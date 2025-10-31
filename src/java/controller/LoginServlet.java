package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet là gì?
 * =============
 * - Servlet là một lớp Java đóng vai trò như "người tiếp viên" trong website
 * - Khi người dùng gửi yêu cầu (VD: đăng nhập), Servlet sẽ:
 *   1. Nhận thông tin từ form đăng nhập (email, password)
 *   2. Kiểm tra thông tin với cơ sở dữ liệu thông qua DAO
 *   3. Trả về trang web phù hợp (dashboard nếu thành công, form login nếu thất bại)
 *
 * DAO là gì?
 * =========
 * - DAO (Data Access Object) là lớp Java chuyên xử lý việc tương tác với cơ sở dữ liệu
 * - Giống như "thủ thư" trong thư viện:
 *   + Thủ thư (DAO) biết chính xác sách (dữ liệu) để ở đâu
 *   + Khách (Servlet) chỉ cần nói cần gì, thủ thư sẽ tìm và lấy cho
 * - Trong trường hợp này, UserDAO giúp:
 *   + Kiểm tra thông tin đăng nhập
 *   + Lưu thông tin người dùng mới
 *   + Cập nhật thông tin người dùng
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    /*
     * LoginServlet
     * ----------
     * VN: Servlet xử lý việc đăng nhập người dùng.
     * - init(): khởi tạo DAO dùng để truy vấn người dùng
     * - doGet(): hiển thị trang đăng nhập, hoặc chuyển hướng nếu đã đăng nhập
     * - doPost(): nhận email/password, xác thực, tạo session và chuyển hướng theo vai trò
     *
     * EN: Handles user login.
     * - init(): initialize UserDAO used to verify credentials.
     * - doGet(): show login page or redirect already-logged-in users to dashboard.
     * - doPost(): validate input, attempt authentication, create session attributes and redirect by role.
     *
     * Important notes / Lưu ý:
     * - Session attributes created: "user", "userId", "userName", "userRole".
     * - No password hashing is performed here; the DAO should verify securely (hash+salt).
     * - Redirect destinations depend on role names returned by the DAO.
     */

    /**
     * DAO đối tượng để tương tác với bảng Users trong cơ sở dữ liệu.
     * UserDAO cung cấp các phương thức:
     * - login(email, password): Xác thực thông tin đăng nhập
     * - getUserByEmail(email): Lấy thông tin user từ email
     * - updateUser(user): Cập nhật thông tin user
     */
    private UserDAO userDAO;

    /**
     * Khởi tạo UserDAO khi servlet được tạo.
     * Phương thức này được gọi một lần duy nhất khi servlet được khởi tạo.
     * 
     * @throws ServletException nếu có lỗi xảy ra trong quá trình khởi tạo DAO
     */
    @Override
    public void init() throws ServletException {
        // Khởi tạo đối tượng UserDAO để tương tác với bảng Users trong CSDL
        userDAO = new UserDAO();
    }

    /**
     * Xử lý yêu cầu GET để hiển thị trang đăng nhập
     * 
     * Quy trình xử lý:
     * 1. Kiểm tra xem người dùng đã đăng nhập chưa (thông qua session)
     * 2. Nếu đã đăng nhập -> chuyển hướng về trang dashboard
     * 3. Nếu chưa đăng nhập -> hiển thị form đăng nhập
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra session hiện tại
        HttpSession session = request.getSession(false);
        
        // Bước 2: Nếu đã đăng nhập (có session và có thông tin user) -> chuyển về dashboard
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Bước 3: Nếu chưa đăng nhập -> hiển thị form đăng nhập
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    /**
     * Xử lý yêu cầu POST để thực hiện đăng nhập
     * 
     * Quy trình xử lý:
     * 1. Lấy thông tin đăng nhập từ form (email, password)
     * 2. Kiểm tra tính hợp lệ của dữ liệu
     * 3. Xác thực thông tin đăng nhập qua UserDAO
     * 4. Tạo session và lưu thông tin người dùng
     * 5. Chuyển hướng tới trang tương ứng theo vai trò
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Lấy thông tin đăng nhập từ form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Bước 2: Kiểm tra tính hợp lệ của dữ liệu
        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email và mật khẩu không được để trống");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Bước 3: Xác thực thông tin đăng nhập thông qua UserDAO
        // UserDAO sẽ xử lý việc mã hóa và kiểm tra mật khẩu
        User user = userDAO.login(email.trim(), password);

        // Bước 4 & 5: Xử lý kết quả đăng nhập và chuyển hướng
        if (user != null) {
            // Đăng nhập thành công: tạo session và lưu thông tin người dùng
            HttpSession session = request.getSession();
            // Lưu đối tượng user hoàn chỉnh (cần cẩn thận với thông tin nhạy cảm)
            session.setAttribute("user", user);
            // Lưu các thông tin cần thiết cho việc kiểm tra sau này
            session.setAttribute("userId", user.getUserID());
            session.setAttribute("userName", user.getUserName());
            session.setAttribute("userRole", user.getRoleName());
            // Đặt thời gian tồn tại của session (1 giờ)
            session.setMaxInactiveInterval(3600);

            // Chuyển hướng người dùng tới trang tương ứng với vai trò
            switch (user.getRoleName()) {
                case "Admin":
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    break;
                case "ClubLeader":
                    response.sendRedirect(request.getContextPath() + "/leader/dashboard");
                    break;
                case "Faculty":
                    response.sendRedirect(request.getContextPath() + "/faculty/dashboard");
                    break;
                case "CLB Manager":
                    response.sendRedirect(request.getContextPath() + "/manager/dashboard");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } else {
            // Đăng nhập thất bại: trở lại trang login với thông báo lỗi
            request.setAttribute("error", "Email hoặc mật khẩu không đúng");
            request.setAttribute("email", email); // Giữ lại email đã nhập
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
