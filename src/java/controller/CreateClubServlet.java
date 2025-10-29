package controller;

import dal.ClubDAO;
import model.Club;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CreateClubServlet", urlPatterns = {"/create-club"})
public class CreateClubServlet extends HttpServlet {

    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("create-club.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String clubName = request.getParameter("clubName");
        String description = request.getParameter("description");

        // Validation
        if (clubName == null || clubName.trim().isEmpty()
                || description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("create-club.jsp").forward(request, response);
            return;
        }

        Club club = new Club();
        club.setClubName(clubName.trim());
        club.setDescription(description.trim());
        club.setLeaderID(user.getUserID());
        club.setFacultyID(user.getUserID()); // Temporary, should select faculty
        club.setStatus("Pending");

        boolean success = clubDAO.createClub(club);

        if (success) {
            request.setAttribute("success", "Club created successfully! Waiting for admin approval.");
            request.getRequestDispatcher("create-club.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to create club. Please try again.");
            request.getRequestDispatcher("create-club.jsp").forward(request, response);
        }
    }
}
