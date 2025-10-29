package controller;

import dal.AdminDAO;
import model.Event;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageEventsServlet", urlPatterns = {"/admin/events"})
public class ManageEventsServlet extends HttpServlet {

    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getRoleName())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        List<Event> pendingEvents = adminDAO.getPendingEvents();
        request.setAttribute("pendingEvents", pendingEvents);

        request.getRequestDispatcher("/admin-events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        boolean success = false;
        if ("approve".equals(action)) {
            success = adminDAO.approveEvent(eventId);
        } else if ("reject".equals(action)) {
            success = adminDAO.rejectEvent(eventId);
        }

        response.sendRedirect(request.getContextPath() + "/admin/events");
    }
}
