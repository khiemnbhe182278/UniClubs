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
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "UpdateEventServlet", urlPatterns = {"/leader/update-event"})
public class UpdateEventServlet extends HttpServlet {

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
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        Event event = eventDAO.getEventById(eventId);
        if (event == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Verify user is leader of the club
        Club club = clubDAO.getClubById(event.getClubID());
        if (club.getLeaderID() != user.getUserID()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        request.setAttribute("event", event);
        request.getRequestDispatcher("/leader-update-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String eventName = request.getParameter("eventName");
            String description = request.getParameter("description");
            String eventDateStr = request.getParameter("eventDate");
            String eventTimeStr = request.getParameter("eventTime");
            String location = request.getParameter("location");
            String maxParticipantsStr = request.getParameter("maxParticipants");

            // Validation
            if (eventName == null || eventName.trim().isEmpty()
                    || description == null || description.trim().isEmpty()) {
                request.setAttribute("error", "Required fields must be filled");
                doGet(request, response);
                return;
            }

            // Parse date and time
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String dateTimeStr = eventDateStr + " " + eventTimeStr;
            Date eventDate = sdf.parse(dateTimeStr);
            Timestamp eventTimestamp = new Timestamp(eventDate.getTime());

            Event event = eventDAO.getEventById(eventId);
            event.setEventName(eventName.trim());
            event.setDescription(description.trim());
            event.setEventDate(eventTimestamp);
            event.setLocation(location);

            if (maxParticipantsStr != null && !maxParticipantsStr.isEmpty()) {
                event.setMaxParticipants(Integer.parseInt(maxParticipantsStr));
            }

            boolean success = eventDAO.updateEvent(event);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?success=event_updated");
            } else {
                request.setAttribute("error", "Failed to update event");
                doGet(request, response);
            }

        } catch (NumberFormatException | ParseException e) {
            request.setAttribute("error", "Invalid input data");
            doGet(request, response);
        }
    }
}
