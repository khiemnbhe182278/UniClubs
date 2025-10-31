package controller;

import dal.EventDAO;
import dal.ClubDAO;
import model.Event;
import model.User;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet( urlPatterns = {"/leader/events"})
public class LeaderEventsServlet extends HttpServlet {

    private EventDAO eventDAO;
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check session
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Check authentication
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get clubId parameter
            String clubIdParam = request.getParameter("clubId");
            if (clubIdParam == null || clubIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=noclubid");
                return;
            }

            int clubId = Integer.parseInt(clubIdParam);

            // Get club details
            Club club = clubDAO.getClubById(clubId);
            if (club == null) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=clubnotfound");
                return;
            }

            // Get all events for this club
            List<Event> events = eventDAO.getEventsByClub(clubId);

            // Set attributes
            request.setAttribute("club", club);
            request.setAttribute("events", events);

            // Forward to JSP
            request.getRequestDispatcher("/leader-events.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidclubid");
        } catch (Exception e) {
            System.err.println("Error in LeaderEventsServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=unexpected");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
