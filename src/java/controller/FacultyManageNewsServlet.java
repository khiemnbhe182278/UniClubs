package controller;

import dal.FacultyDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/faculty/news")
public class FacultyManageNewsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        FacultyDAO facultyDAO = new FacultyDAO();
        int facultyID = user.getUserID();

        String status = request.getParameter("status");
        request.setAttribute("newsList", facultyDAO.getNewsByFaculty(facultyID, status));
        request.setAttribute("currentStatus", status);

        request.getRequestDispatcher("/faculty/manage-news.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int newsID = Integer.parseInt(request.getParameter("newsID"));

        FacultyDAO facultyDAO = new FacultyDAO();
        boolean success = false;
        String message = "";

        if ("approve".equals(action)) {
            success = facultyDAO.updateNewsStatus(newsID, "Approved");
            message = success ? "News approved successfully!" : "Failed to approve news.";
        } else if ("reject".equals(action)) {
            success = facultyDAO.updateNewsStatus(newsID, "Rejected");
            message = success ? "News rejected successfully!" : "Failed to reject news.";
        }

        session.setAttribute("message", message);
        session.setAttribute("messageType", success ? "success" : "error");
        response.sendRedirect(request.getContextPath() + "/faculty/news?status=Pending");
    }
}
