package controller;

import dal.MemberDAO;
import dal.EventDAO;
import model.User;
import model.Member;
import model.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {
    
    private MemberDAO memberDAO;
    private EventDAO eventDAO;
    
    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
        eventDAO = new EventDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get user's clubs
        List<Member> myClubs = memberDAO.getUserClubs(user.getUserID());
        request.setAttribute("myClubs", myClubs);
        
        // Get upcoming events
        List<Event> upcomingEvents = eventDAO.getUpcomingEvents();
        request.setAttribute("upcomingEvents", upcomingEvents);
        
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
