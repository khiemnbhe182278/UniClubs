package controller;

import dal.MemberDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "JoinClubServlet", urlPatterns = {"/join-club"})
public class JoinClubServlet extends HttpServlet {

    private MemberDAO memberDAO;

    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Store the intended URL to redirect back after login
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", request.getRequestURI() + "?" + request.getQueryString());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            // Lấy clubId từ parameter (hỗ trợ cả "id" và "clubId")
            String clubIdParam = request.getParameter("id");
            if (clubIdParam == null) {
                clubIdParam = request.getParameter("clubId");
            }

            if (clubIdParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing club ID");
                return;
            }

            int clubId = Integer.parseInt(clubIdParam);

            // Check if already a member
            if (memberDAO.isMember(user.getUserID(), clubId)) {
                session.setAttribute("error", "You have already joined or requested to join this club");
                response.sendRedirect(request.getContextPath() + "/club-detail?id=" + clubId);
                return;
            }

            // Join club
            boolean success = memberDAO.joinClub(user.getUserID(), clubId);

            if (success) {
                session.setAttribute("success", "Join request sent successfully! Waiting for approval.");
            } else {
                session.setAttribute("error", "Failed to send join request. Please try again.");
            }

            response.sendRedirect(request.getContextPath() + "/club-detail?id=" + clubId);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid club ID");
        }
    }
}
