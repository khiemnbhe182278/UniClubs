package controller;

import dal.MemberDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Member;

@WebServlet(name = "ClubMemberServlet", urlPatterns = {"/club/members"})
public class ClubMemberServlet extends HttpServlet {

    private MemberDAO memberDAO = new MemberDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy clubId từ URL
        String clubIdParam = request.getParameter("clubID");
        if (clubIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing clubId");
            return;
        }

        int clubId = Integer.parseInt(clubIdParam);

        // Lấy danh sách
        List<Member> approvedMembers = memberDAO.getClubMembers(clubId);
        List<Member> pendingMembers = memberDAO.getPendingMembersByClub(clubId);

        // Gửi sang JSP
        request.setAttribute("approvedMembers", approvedMembers);
        request.setAttribute("pendingMembers", pendingMembers);
        request.setAttribute("clubId", clubId);

        request.getRequestDispatcher("/club-members.jsp").forward(request, response);
    }

    // Xử lý duyệt / từ chối
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int memberId = Integer.parseInt(request.getParameter("memberId"));
        int clubId = Integer.parseInt(request.getParameter("clubID"));

        boolean result = false;
        if ("approve".equals(action)) {
            result = memberDAO.approveMember(memberId);
        } else if ("reject".equals(action)) {
            result = memberDAO.rejectMember(memberId);
        }

        response.sendRedirect("members?clubId=" + clubId);
    }
}
