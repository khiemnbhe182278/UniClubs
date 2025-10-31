package controller;

import dal.MemberDAO;
import model.Member;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/club/members")
public class ClubMembersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer clubId = (Integer) session.getAttribute("currentClubId");

        if (clubId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        MemberDAO dao = new MemberDAO();
        List<Member> members = dao.getClubMembers(clubId);

        request.setAttribute("members", members);
        RequestDispatcher rd = request.getRequestDispatcher("/clubMembers.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int memberId = Integer.parseInt(request.getParameter("memberId"));
        MemberDAO dao = new MemberDAO();

        if ("approve".equalsIgnoreCase(action)) {
            dao.approveMember(memberId);
        } else if ("reject".equalsIgnoreCase(action)) {
            dao.rejectMember(memberId);
        }

        response.sendRedirect(request.getContextPath() + "/club/members");
    }
}
