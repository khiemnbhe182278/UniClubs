package controller;

import dal.ClubDAO;
import dal.NewsDAO;
import dal.RuleDAO;
import dal.EventDAO;
import dal.MemberDAO;
import model.Club;
import model.News;
import model.Rule;
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

@WebServlet(name = "MemberClubDetailServlet", urlPatterns = {"/member-club-detail"})
public class MemberClubDetailServlet extends HttpServlet {
    
    private ClubDAO clubDAO;
    private NewsDAO newsDAO;
    private RuleDAO ruleDAO;
    private EventDAO eventDAO;
    private MemberDAO memberDAO;
    
    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
        newsDAO = new NewsDAO();
        ruleDAO = new RuleDAO();
        eventDAO = new EventDAO();
        memberDAO = new MemberDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check session (optional for viewing, but needed for join functionality)
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        
        try {
            // Get clubId parameter
            String clubIdParam = request.getParameter("id");
            if (clubIdParam == null || clubIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/dashboard?error=noclubid");
                return;
            }
            
            int clubId = Integer.parseInt(clubIdParam);
            
            // Get club details
            Club club = clubDAO.getClubById(clubId);
            if (club == null) {
                response.sendRedirect(request.getContextPath() + "/dashboard?error=clubnotfound");
                return;
            }
            
            // Get club leader information
            User leader = clubDAO.getClubLeader(clubId);
            
            // Get faculty information
            User faculty = clubDAO.getClubFaculty(clubId);
            
            // Get published news
            List<News> newsList = newsDAO.getPublishedNewsByClubId(clubId);
            
            // Get club rules
            List<Rule> rules = ruleDAO.getRulesByClubId(clubId);
            
            // Get upcoming events (only approved/published)
            List<Event> events = eventDAO.getUpcomingEventsByClubId(clubId);
            
            // Get member count
            int memberCount = memberDAO.getMemberCountByClubId(clubId);
            
            // Check if current user is already a member
            boolean isMember = false;
            boolean isPendingMember = false;
            if (user != null) {
                isMember = memberDAO.checkMember(clubId, user.getUserID());
                isPendingMember = memberDAO.isPendingMember(clubId, user.getUserID());
            }
            
            // Set attributes
            request.setAttribute("club", club);
            request.setAttribute("leader", leader);
            request.setAttribute("faculty", faculty);
            request.setAttribute("newsList", newsList);
            request.setAttribute("rules", rules);
            request.setAttribute("events", events);
            request.setAttribute("memberCount", memberCount);
            request.setAttribute("isMember", isMember);
            request.setAttribute("isPendingMember", isPendingMember);
            
            // Forward to JSP
            request.getRequestDispatcher("/member-club-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dashboard?error=invalidclubid");
        } catch (Exception e) {
            System.err.println("Error in ClubDetailServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard?error=unexpected");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}