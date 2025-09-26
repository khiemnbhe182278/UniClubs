package controller;

import dal.EventDAO;
import model.Event;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

@WebServlet("/createEvent")
public class CreateEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the JSP page
        request.getRequestDispatcher("/event/createEvent.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String clubIDParam = request.getParameter("clubID");
        String eventName = request.getParameter("eventName");
        String description = request.getParameter("description");
        String eventDateStr = request.getParameter("eventDate");

        // Server-side validation
        if (clubIDParam == null || eventName == null || eventName.trim().isEmpty()
                || description == null || description.trim().isEmpty()
                || eventDateStr == null || eventDateStr.isEmpty()) {

            // Set error message and forward back to form
            request.setAttribute("errorMessage", "All fields are required. Please fill in all information.");

            // Retain user input
            request.setAttribute("eventName", eventName);
            request.setAttribute("description", description);
            request.setAttribute("eventDate", eventDateStr);

            request.getRequestDispatcher("/event/createEvent.jsp").forward(request, response);
            return;
        }

        try {
            int clubID = Integer.parseInt(clubIDParam);
            LocalDate eventDate = LocalDate.parse(eventDateStr);

            // Validate date: must be today or in the future
            if (eventDate.isBefore(LocalDate.now())) {
                request.setAttribute("errorMessage", "The event date cannot be in the past.");
                request.setAttribute("eventName", eventName);
                request.setAttribute("description", description);
                request.setAttribute("eventDate", eventDateStr);
                request.getRequestDispatcher("/event/createEvent.jsp").forward(request, response);
                return;
            }

            Timestamp eventTimestamp = Timestamp.valueOf(eventDate.atStartOfDay());

            Event e = new Event();
            e.setClubID(clubID);
            e.setEventName(eventName);
            e.setDescription(description);
            e.setEventDate(eventTimestamp);
            e.setStatus("Pending");
            e.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

            EventDAO dao = new EventDAO();
            boolean success = dao.createEvent(e);

            if (success) {
                // Set success message and redirect
                request.getSession().setAttribute("successMessage", "Event created successfully!");
                response.sendRedirect("listEvents");
            } else {
                // Set failure message and forward back to form
                request.setAttribute("errorMessage", "Failed to create event. Please try again.");
                request.setAttribute("eventName", eventName);
                request.setAttribute("description", description);
                request.setAttribute("eventDate", eventDateStr);
                request.getRequestDispatcher("/event/createEvent.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Club ID. Please contact support.");
            request.getRequestDispatcher("/event/createEvent.jsp").forward(request, response);
        }
    }
}
