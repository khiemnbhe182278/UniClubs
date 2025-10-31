package controller;

import dal.ClubDAO;
import dal.EventDAO;
import dal.PaymentDAO;
import dal.EventParticipantDAO;
import model.User;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ClubStatisticsServlet", urlPatterns = {"/leader/statistics"})
public class ClubStatisticsServlet extends HttpServlet {

    private ClubDAO clubDAO;
    private EventDAO eventDAO;
    private PaymentDAO paymentDAO;
    private EventParticipantDAO participantDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
        eventDAO = new EventDAO();
        paymentDAO = new PaymentDAO();
        participantDAO = new EventParticipantDAO();
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
        int clubId = Integer.parseInt(request.getParameter("clubId"));

        // Verify user is leader of this club
        Club club = clubDAO.getClubById(clubId);
        if (club == null || club.getLeaderID() != user.getUserID()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Get comprehensive statistics
        Map<String, Object> stats = new HashMap<>();

        // Member statistics
        stats.put("totalMembers", clubDAO.getMemberCount(clubId));
        stats.put("newMembersThisMonth", clubDAO.getNewMembersCount(clubId, 30));
        stats.put("pendingRequests", clubDAO.getPendingMembersCount(clubId));

        // Event statistics
        stats.put("totalEvents", eventDAO.getClubEventCount(clubId));
        stats.put("upcomingEvents", eventDAO.getUpcomingEventCount(clubId));
        stats.put("totalParticipants", participantDAO.getTotalParticipants(clubId));

        // Financial statistics
        stats.put("totalRevenue", paymentDAO.getTotalRevenue(clubId));
        stats.put("pendingPayments", paymentDAO.getPendingPaymentsCount(clubId));
        stats.put("revenueThisMonth", paymentDAO.getMonthlyRevenue(clubId));

        // Engagement metrics
        stats.put("averageEventAttendance", participantDAO.getAverageAttendance(clubId));
        stats.put("memberEngagementRate", calculateEngagementRate(clubId));

        request.setAttribute("club", club);
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/leader-statistics.jsp").forward(request, response);
    }

    private double calculateEngagementRate(int clubId) {
        // Implementation: Calculate based on event participation
        return 0.0; // Placeholder
    }
}
