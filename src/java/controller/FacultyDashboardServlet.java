package controller;

import dal.FacultyDAO;
import jakarta.servlet.annotation.WebServlet;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;

@WebServlet("/faculty/dashboard")
public class FacultyDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() != 3) { // RoleID 3 = Faculty
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        FacultyDAO facultyDAO = new FacultyDAO();
        int facultyID = user.getUserID();

        // Get statistics
        Map<String, Integer> stats = facultyDAO.getFacultyStatistics(facultyID);
        request.setAttribute("stats", stats);

        // Get clubs
        request.setAttribute("clubs", facultyDAO.getClubsByFaculty(facultyID));

        // Get pending members
        request.setAttribute("pendingMembers", facultyDAO.getPendingMembersByFaculty(facultyID));

        // Get events
        request.setAttribute("events", facultyDAO.getEventsByFaculty(facultyID));

        request.getRequestDispatcher("/faculty/dashboard.jsp").forward(request, response);
    }
}
