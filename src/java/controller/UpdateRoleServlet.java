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

@WebServlet(name = "UpdateRoleServlet", urlPatterns = {"/admin/update-role"})
public class UpdateRoleServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
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
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        int newRoleId = Integer.parseInt(request.getParameter("roleId"));
        
        // Prevent admin from changing their own role
        if (userId == adminUser.getUserID()) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=cannot_change_own_role");
            return;
        }
        
        boolean success = userDAO.updateUserRole(userId, newRoleId);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/users?success=role_updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=update_failed");
        }
    }
}