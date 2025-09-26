package controller;

import dal.ClubDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Club;
import model.Event;
import model.News;
import java.util.List;

@WebServlet("/clubDetail")
public class ClubDetailServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int clubID = Integer.parseInt(request.getParameter("id"));
            ClubDAO dao = new ClubDAO();
            
            // Get club details
            Club club = dao.getClubDetail(clubID);
            
            if (club != null) {
                // Get statistics
                int memberCount = dao.countMembers(clubID);
                int eventCount = dao.countEvents(clubID);
                int newsCount = dao.countNews(clubID);
                
                // Get lists
                List<Event> events = dao.getEventsByClub(clubID);
                List<News> newsList = dao.getNewsByClub(clubID);
                
                // Get featured items for overview
                Event upcomingEvent = dao.getUpcomingEvent(clubID);
                News latestNews = dao.getLatestNews(clubID);
                
                // Set attributes for JSP
                request.setAttribute("club", club);
                request.setAttribute("memberCount", memberCount);
                request.setAttribute("eventCount", eventCount);
                request.setAttribute("newsCount", newsCount);
                request.setAttribute("members", dao.getMembers(clubID));
                request.setAttribute("events", events);
                request.setAttribute("newsList", newsList);
                request.setAttribute("upcomingEvent", upcomingEvent);
                request.setAttribute("latestNews", latestNews);
            }
            
            request.getRequestDispatcher("/club-manager/clubDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Invalid club ID
            response.sendRedirect("clubs");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}