package controller;

import dal.EventDAO;
import model.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EventDetailServlet", urlPatterns = {"/event-detail"})
public class EventDetailServlet extends HttpServlet {
    
    private EventDAO eventDAO;
    
    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int eventId = Integer.parseInt(request.getParameter("id"));
            Event event = eventDAO.getEventById(eventId);
            
            if (event != null) {
                request.setAttribute("event", event);
                request.getRequestDispatcher("event-detail.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID");
        }
    }
}