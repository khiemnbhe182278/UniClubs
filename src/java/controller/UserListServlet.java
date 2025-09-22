package controller;

import dal.UserDAO;
import model.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/listAccounts")
public class UserListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String roleFilter = request.getParameter("role");
        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        UserDAO dao = new UserDAO();
        List<UserDTO> users = dao.getUsers(page, pageSize, search, roleFilter);
        int totalRecords = dao.countUsers(search, roleFilter);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("roleFilter", roleFilter);

        request.getRequestDispatcher("/admin/listAccounts.jsp").forward(request, response);
    }
}
