package controller;

import dal.EventRegistrationDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "MarkAttendanceServlet", urlPatterns = {"/leader/mark-attendance"})
public class MarkAttendanceServlet extends HttpServlet {

    private EventRegistrationDAO registrationDAO;

    @Override
    public void init() throws ServletException {
        registrationDAO = new EventRegistrationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
            // Get parameters
            String participantIdParam = request.getParameter("participantId");
            String eventIdParam = request.getParameter("eventId");
            String status = request.getParameter("status");

            if (participantIdParam == null || eventIdParam == null || status == null) {
                response.sendRedirect(request.getContextPath() + "/leader/event-participants?eventId="
                        + eventIdParam + "&error=missingparams");
                return;
            }

            int participantId = Integer.parseInt(participantIdParam);
            int eventId = Integer.parseInt(eventIdParam);

            // Validate status
            if (!status.equals("Attended") && !status.equals("Absent")) {
                response.sendRedirect(request.getContextPath() + "/leader/event-participants?eventId="
                        + eventId + "&error=invalidstatus");
                return;
            }

            // Update attendance status
            boolean updated = registrationDAO.updateAttendanceStatus(participantId, status);

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/leader/event-participants?eventId="
                        + eventId + "&success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/leader/event-participants?eventId="
                        + eventId + "&error=updatefailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidparams");
        } catch (Exception e) {
            System.err.println("Error in MarkAttendanceServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=unexpected");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to dashboard if accessed via GET
        response.sendRedirect(request.getContextPath() + "/leader/dashboard");
    }
}
