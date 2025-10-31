package controller;

import dal.EventParticipantDAO;
import dal.EventDAO;
import dal.NotificationDAO;
import model.User;
import model.Event;
import model.Notification;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "RegisterEventServlet", urlPatterns = {"/register-event"})
public class RegisterEventServlet extends HttpServlet {

    private EventParticipantDAO participantDAO;
    private EventDAO eventDAO;
    private NotificationDAO notificationDAO;

    @Override
    public void init() throws ServletException {
        participantDAO = new EventParticipantDAO();
        eventDAO = new EventDAO();
        notificationDAO = new NotificationDAO();
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

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));

            // Check if already registered
            if (participantDAO.isRegistered(eventId, user.getUserID())) {
                session.setAttribute("error", "You are already registered for this event");
                response.sendRedirect(request.getContextPath() + "/event-detail?id=" + eventId);
                return;
            }

            // Register for event
            boolean success = participantDAO.registerForEvent(eventId, user.getUserID());

            if (success) {
                // Create notification
                Event event = eventDAO.getEventById(eventId);
                Notification notif = new Notification();
                notif.setUserID(user.getUserID());
                notif.setTitle("Event Registration Confirmed");
                notif.setContent("You have successfully registered for " + event.getEventName());
                notif.setNotificationType("Event");
                notif.setRelatedID(eventId);
                notificationDAO.createNotification(notif);

                session.setAttribute("success", "Successfully registered for event!");
            } else {
                session.setAttribute("error", "Failed to register. Please try again.");
            }

            response.sendRedirect(request.getContextPath() + "/event-detail?id=" + eventId);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID");
        }
    }
}
