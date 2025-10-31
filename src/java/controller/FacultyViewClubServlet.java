package controller;

import dal.FacultyDAO;
import model.User;
import model.Club;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/faculty/club")
public class FacultyViewClubServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int clubID = Integer.parseInt(request.getParameter("clubID"));
        FacultyDAO facultyDAO = new FacultyDAO();

        // Get club details
        Club club = facultyDAO.getClubById(clubID);

        // Verify this club belongs to this faculty
        if (club == null || club.getFacultyID() != user.getUserID()) {
            response.sendRedirect(request.getContextPath() + "/faculty/dashboard");
            return;
        }

        // Get club rules
        request.setAttribute("club", club);
        request.setAttribute("rules", facultyDAO.getClubRules(clubID));
        request.setAttribute("clubID", clubID);

        request.getRequestDispatcher("/faculty/club-details.jsp").forward(request, response);
    }
}
