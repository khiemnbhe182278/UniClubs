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

@WebServlet(name = "UpdateClubServlet", urlPatterns = {"/leader/update-club"})
public class UpdateClubServlet extends HttpServlet {

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

        User user = (User) session.getAttribute("user");
        int clubId = Integer.parseInt(request.getParameter("clubId"));

        Club club = clubDAO.getClubById(clubId);
        if (club == null || club.getLeaderID() != user.getUserID()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        request.setAttribute("club", club);
        request.getRequestDispatcher("/leader-update-club.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        int clubId = Integer.parseInt(request.getParameter("clubId"));
        String clubName = request.getParameter("clubName");
        String description = request.getParameter("description");
        String categoryIdStr = request.getParameter("categoryId");

        // Validation
        if (clubName == null || clubName.trim().isEmpty()
                || description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            doGet(request, response);
            return;
        }

        Club club = clubDAO.getClubById(clubId);
        if (club.getLeaderID() != user.getUserID()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        club.setClubName(clubName.trim());
        club.setDescription(description.trim());
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            club.setCategoryID(Integer.parseInt(categoryIdStr));
        }

        boolean success = clubDAO.updateClub(club);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?success=club_updated");
        } else {
            request.setAttribute("error", "Failed to update club");
            doGet(request, response);
        }
    }
}
