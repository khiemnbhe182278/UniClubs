package controller;

import dal.FacultyDAO;
import jakarta.servlet.annotation.WebServlet;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/faculty/events")
public class FacultyManageEventsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        FacultyDAO facultyDAO = new FacultyDAO();
        int facultyID = user.getUserID();

        String eventIDParam = request.getParameter("eventID");

        if (eventIDParam != null) {
            // View event participants
            int eventID = Integer.parseInt(eventIDParam);
            request.setAttribute("participants", facultyDAO.getEventParticipants(eventID));
            request.setAttribute("eventID", eventID);
            request.getRequestDispatcher("/faculty/event-participants.jsp").forward(request, response);
        } else {
            // List all events
            request.setAttribute("events", facultyDAO.getEventsByFaculty(facultyID));
            request.getRequestDispatcher("/faculty/manage-events.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        FacultyDAO facultyDAO = new FacultyDAO();
        boolean success = false;
        String message = "";

        if ("approveEvent".equals(action) || "rejectEvent".equals(action)) {
            int eventID = Integer.parseInt(request.getParameter("eventID"));
            String status = "approveEvent".equals(action) ? "Approved" : "Rejected";
            success = facultyDAO.updateEventStatus(eventID, status);
            message = success ? "Event " + status.toLowerCase() + " successfully!" : "Failed to update event.";
            response.sendRedirect(request.getContextPath() + "/faculty/events");
        } else if ("updateAttendance".equals(action)) {
            int participantID = Integer.parseInt(request.getParameter("participantID"));
            String status = request.getParameter("status");
            int eventID = Integer.parseInt(request.getParameter("eventID"));
            success = facultyDAO.updateAttendanceStatus(participantID, status);
            message = success ? "Attendance updated successfully!" : "Failed to update attendance.";
            response.sendRedirect(request.getContextPath() + "/faculty/events?eventID=" + eventID);
        }

        session.setAttribute("message", message);
        session.setAttribute("messageType", success ? "success" : "error");
    }
}
