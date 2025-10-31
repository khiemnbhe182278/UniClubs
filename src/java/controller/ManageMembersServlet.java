package controller;

import dal.AdminDAO;
import dal.MemberDAO;
import model.Member;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageMembersServlet", urlPatterns = {"/admin/members"})
public class ManageMembersServlet extends HttpServlet {
    
    private AdminDAO adminDAO;
    private MemberDAO memberDAO;
    
    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
        memberDAO = new MemberDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        List<Member> pendingMembers = adminDAO.getPendingMembers();
        request.setAttribute("pendingMembers", pendingMembers);
        
        request.getRequestDispatcher("/admin-members.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int memberId = Integer.parseInt(request.getParameter("memberId"));
        
        boolean success = false;
        if ("approve".equals(action)) {
            success = memberDAO.approveMember(memberId);
        } else if ("reject".equals(action)) {
            success = memberDAO.rejectMember(memberId);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/members");
    }
}