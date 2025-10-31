package controller;

import dal.ClubDAO;
import dal.MemberDAO;
import dal.EventDAO;
import dal.PaymentDAO;
import model.User;
import model.Club;
import model.Member;
import model.Event;
import model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClubLeaderDashboardServlet", urlPatterns = {"/leader/dashboard"})
public class ClubLeaderDashboardServlet extends HttpServlet {

    private ClubDAO clubDAO;
    private MemberDAO memberDAO;
    private EventDAO eventDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
        memberDAO = new MemberDAO();
        eventDAO = new EventDAO();
        paymentDAO = new PaymentDAO();
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

        // Check if user has permission (Leader, Admin, or specific role)
        if (user.getRoleID() != 2 && user.getRoleID() != 4 && user.getRoleID() != 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Get clubs where user is leader
        List<Club> myClubs = clubDAO.getUserLeadClubs(user.getUserID());

        if (myClubs.isEmpty()) {
            // User is not a leader of any club
            request.setAttribute("errorMessage",
                    "You are not assigned as a leader of any club. Please contact the administrator.");
            request.getRequestDispatcher("/error-no-club.jsp").forward(request, response);
            return;
        }

        // Get clubId from parameter or use first club
        String clubIdParam = request.getParameter("clubId");
        int clubId = 0;
        Club club = null;

        if (clubIdParam != null && !clubIdParam.trim().isEmpty()) {
            try {
                clubId = Integer.parseInt(clubIdParam);
                club = clubDAO.getClubById(clubId);

                // Verify user is leader of this club
                boolean isLeaderOfClub = false;
                for (Club c : myClubs) {
                    if (c.getClubID() == clubId) {
                        isLeaderOfClub = true;
                        club = c;
                        break;
                    }
                }

                if (!isLeaderOfClub && user.getRoleID() != 1) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN,
                            "You don't have permission to access this club");
                    return;
                }
            } catch (NumberFormatException e) {
                clubId = myClubs.get(0).getClubID();
                club = myClubs.get(0);
            }
        } else {
            // Check if clubId exists in session
            Integer sessionClubId = (Integer) session.getAttribute("currentClubId");
            if (sessionClubId != null) {
                // Verify this clubId is still valid for this user
                boolean found = false;
                for (Club c : myClubs) {
                    if (c.getClubID() == sessionClubId) {
                        clubId = sessionClubId;
                        club = c;
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    clubId = myClubs.get(0).getClubID();
                    club = myClubs.get(0);
                }
            } else {
                // Use first club
                club = myClubs.get(0);
                clubId = club.getClubID();
            }
        }

        // SAVE CLUB ID TO SESSION - THIS IS IMPORTANT!
        session.setAttribute("currentClubId", clubId);
        session.setAttribute("currentClub", club);

        try {
            // Get club statistics
            List<Member> members = memberDAO.getClubMembers(clubId);
            List<Event> events = eventDAO.getEventsByClub(clubId);
            List<Payment> payments = paymentDAO.getClubPayments(clubId);
            double totalRevenue = paymentDAO.getTotalRevenue(clubId);

            // Get pending members
            List<Member> pendingMembers = memberDAO.getPendingMembersByClub(clubId);

            // Set attributes
            request.setAttribute("club", club);
            request.setAttribute("myClubs", myClubs);
            request.setAttribute("members", members);
            request.setAttribute("events", events);
            request.setAttribute("payments", payments);
            request.setAttribute("pendingMembers", pendingMembers);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("clubId", clubId);

            // Additional statistics
            request.setAttribute("totalMembers", members.size());
            request.setAttribute("pendingMembersCount", pendingMembers.size());
            request.setAttribute("upcomingEvents", events.size());

            request.getRequestDispatcher("/leader-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while loading dashboard data.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
