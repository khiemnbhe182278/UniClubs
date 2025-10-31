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

@WebServlet(name = "DeleteEventServlet", urlPatterns = {"/leader/delete-event"})
public class DeleteEventServlet extends HttpServlet {

    private EventDAO eventDAO;
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        clubDAO = new ClubDAO();
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
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Verify ownership
        Event event = eventDAO.getEventById(eventId);
        if (event == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }



        boolean success = eventDAO.deleteEvent(eventId);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?success=event_deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=delete_failed");
        }
    }
}
