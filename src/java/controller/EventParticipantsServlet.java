package controller;

import dal.EventDAO;
import dal.EventRegistrationDAO;
import model.Event;
import model.EventRegistration;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "EventParticipantsServlet", urlPatterns = {"/leader/event-participants"})
public class EventParticipantsServlet extends HttpServlet {

    private EventDAO eventDAO;
    private EventRegistrationDAO registrationDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        registrationDAO = new EventRegistrationDAO();
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
            // Get eventId parameter
            String eventIdParam = request.getParameter("eventId");
            if (eventIdParam == null || eventIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=noeventid");
                return;
            }

            int eventId = Integer.parseInt(eventIdParam);

            // Get event details
            Event event = eventDAO.getEventById(eventId);
            if (event == null) {
                response.sendRedirect(request.getContextPath() + "/leader/events?error=eventnotfound");
                return;
            }

            // Get all participants for this event
            List<EventRegistration> participants = registrationDAO.getParticipantsByEventId(eventId);

            // Calculate statistics
            int totalParticipants = participants.size();
            int attended = 0;
            int registered = 0;

            for (EventRegistration participant : participants) {
                if ("Attended".equals(participant.getAttendanceStatus())) {
                    attended++;
                } else if ("Registered".equals(participant.getAttendanceStatus())
                        || "Approved".equals(participant.getStatus())) {
                    registered++;
                }
            }

            // Set attributes
            request.setAttribute("event", event);
            request.setAttribute("participants", participants);
            request.setAttribute("totalParticipants", totalParticipants);
            request.setAttribute("attended", attended);
            request.setAttribute("registered", registered);

            // Forward to JSP
            request.getRequestDispatcher("/event-participants.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalideventid");
        } catch (Exception e) {
            System.err.println("Error in EventParticipantsServlet: " + e.getMessage());
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
