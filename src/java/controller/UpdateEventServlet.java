package controller;

import dal.EventDAO;
import model.Event;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;

@WebServlet("/updateEvent")
public class UpdateEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIDParam = request.getParameter("eventID");
        if (eventIDParam == null || eventIDParam.isEmpty()) {
            response.sendRedirect("listEvents?error=Missing+event+ID");
            return;
        }

        try {
            int eventID = Integer.parseInt(eventIDParam);
            EventDAO dao = new EventDAO();
            Event event = dao.getEventByID(eventID); 

            if (event == null) {
                response.sendRedirect("listEvents?error=Event+not+found");
                return;
            }

            request.setAttribute("event", event);
            request.getRequestDispatcher("/event/updateEvent.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("listEvents?error=Invalid+event+ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIDParam = request.getParameter("eventID");
        String eventName = request.getParameter("eventName");
        String description = request.getParameter("description");
        String eventDateStr = request.getParameter("eventDate");

        // Server-side validation
        if (eventIDParam == null || eventIDParam.isEmpty() ||
            eventName == null || eventName.trim().isEmpty() || 
            description == null || description.trim().isEmpty() || 
            eventDateStr == null || eventDateStr.isEmpty()) {
            
            // Re-fetch event to retain existing data and forward with an error message
            try {
                int eventID = Integer.parseInt(eventIDParam);
                EventDAO dao = new EventDAO();
                Event event = dao.getEventByID(eventID);
                request.setAttribute("event", event);
                request.setAttribute("errorMessage", "All fields are required. Please fill in all information.");
                request.getRequestDispatcher("/event/updateEvent.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect("listEvents?error=Invalid+event+ID");
                return;
            }
        }
        
        try {
            int eventID = Integer.parseInt(eventIDParam);
            LocalDate eventDate = LocalDate.parse(eventDateStr);
            
            // Validate date: must be today or in the future
            if (eventDate.isBefore(LocalDate.now())) {
                EventDAO dao = new EventDAO();
                Event event = dao.getEventByID(eventID);
                request.setAttribute("event", event);
                request.setAttribute("errorMessage", "The event date cannot be in the past.");
                request.getRequestDispatcher("/event/updateEvent.jsp").forward(request, response);
                return;
            }

            Timestamp eventTimestamp = Timestamp.valueOf(eventDate.atStartOfDay());

            Event e = new Event();
            e.setEventID(eventID);
            e.setEventName(eventName);
            e.setDescription(description);
            e.setEventDate(eventTimestamp);
            // Không gán trường status từ request, giữ nguyên trạng thái cũ

            EventDAO dao = new EventDAO();
            boolean success = dao.updateEvent(e, eventID); // Gọi phương thức DAO đã được sửa

            if (success) {
                request.getSession().setAttribute("successMessage", "Event updated successfully!");
                response.sendRedirect("listEvents");
            } else {
                request.setAttribute("errorMessage", "Failed to update event. Please try again.");
                request.getRequestDispatcher("/event/updateEvent.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("listEvents?error=Invalid+event+ID");
        }
    }
}