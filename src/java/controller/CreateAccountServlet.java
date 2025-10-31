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

@WebServlet(name = "CreateAccountServlet", urlPatterns = {"/admin/create-account"})
public class CreateAccountServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getRoleName())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        request.getRequestDispatcher("/admin-create-account.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User adminUser = (User) session.getAttribute("user");
        if (adminUser == null || !"Admin".equals(adminUser.getRoleName())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleIdStr = request.getParameter("roleId");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        // Validation
        if (userName == null || userName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || roleIdStr == null) {
            request.setAttribute("error", "All required fields must be filled");
            doGet(request, response);
            return;
        }

        int roleId = Integer.parseInt(roleIdStr);

        // Check if email exists
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already exists");
            doGet(request, response);
            return;
        }

        User newUser = new User();
        newUser.setUserName(userName.trim());
        newUser.setEmail(email.trim().toLowerCase());
        newUser.setRoleID(roleId);
        newUser.setFullName(fullName);
        newUser.setPhone(phone);
        newUser.setStatus(true);

        boolean success = userDAO.createUserByAdmin(newUser, password);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/users?success=created");
        } else {
            request.setAttribute("error", "Failed to create account");
            doGet(request, response);
        }
    }
}
