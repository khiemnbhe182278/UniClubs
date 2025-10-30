package controller;

import dal.MemberDAO;
import dal.NotificationDAO;
import model.User;
import model.Member;
import model.Notification;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ApproveMemberServlet", urlPatterns = {"/leader/approve-member"})
public class ApproveMemberServlet extends HttpServlet {

    private MemberDAO memberDAO;
    private NotificationDAO notificationDAO;

    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
        notificationDAO = new NotificationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int memberId = Integer.parseInt(request.getParameter("memberId"));

        boolean success = false;
        String message = "";

        if ("approve".equals(action)) {
            success = memberDAO.approveMember(memberId);
            message = "Member approved successfully!";

            // Get member details to send notification
            Member member = memberDAO.getMemberById(memberId);
            if (member != null) {
                Notification notif = new Notification();
                notif.setUserID(member.getUserID());
                notif.setTitle("Membership Approved");
                notif.setContent("Your request to join " + member.getClubName() + " has been approved!");
                notif.setNotificationType("Membership");
                notif.setRelatedID(member.getClubID());
                notificationDAO.createNotification(notif);
            }

        } else if ("reject".equals(action)) {
            success = memberDAO.rejectMember(memberId);
            message = "Member request rejected.";
        }

        if (success) {
            session.setAttribute("success", message);
        } else {
            session.setAttribute("error", "Action failed. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/leader/dashboard");
    }
}
