package controller;

import dal.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/changeRole")
public class ChangeRoleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userID = Integer.parseInt(request.getParameter("userID"));
        int roleID = Integer.parseInt(request.getParameter("roleID"));

        UserDAO dao = new UserDAO();
        boolean success = dao.changeRole(userID, roleID);

        if (success) {
            request.getSession().setAttribute("message", "User role updated successfully!");
        } else {
            request.getSession().setAttribute("error", "Failed to update user role.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/listAccounts");
    }
}
