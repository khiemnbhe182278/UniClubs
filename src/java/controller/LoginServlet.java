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

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        // Initialize data access object.
        // VN: Tạo đối tượng UserDAO để tương tác với bảng Users trong CSDL.
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Show login page, but if user already has a session -> redirect to dashboard.
        // VN: Nếu session tồn tại và đã có attribute "user" thì chuyển về dashboard.
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Forward to JSP that contains the login form.
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Basic input validation - return to form with error if missing
        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Attempt login using the DAO. The DAO should encapsulate password verification.
        User user = userDAO.login(email.trim(), password);

        if (user != null) {
            // Successful login: create session and store minimal user info for later checks
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // whole user object (use with caution)
            session.setAttribute("userId", user.getUserID());
            session.setAttribute("userName", user.getUserName());
            session.setAttribute("userRole", user.getRoleName());
            session.setMaxInactiveInterval(3600); // session lifetime in seconds (1 hour)

            // Redirect depending on role name. These paths are application-specific.
            if ("Admin".equals(user.getRoleName())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else if ("ClubLeader".equals(user.getRoleName())) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard");
            } else if ("Faculty".equals(user.getRoleName())) {
                response.sendRedirect(request.getContextPath() + "/faculty/dashboard");
            } else if ("CLB Manager".equals(user.getRoleName())) {
                response.sendRedirect(request.getContextPath() + "/manager/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } else {
            // Authentication failed: return to login page with error message and prefilled email
            request.setAttribute("error", "Invalid email or password");
            request.setAttribute("email", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
