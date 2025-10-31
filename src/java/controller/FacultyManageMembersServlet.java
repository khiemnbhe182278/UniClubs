package controller;

import dal.FacultyDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/faculty/members")
public class FacultyManageMembersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        FacultyDAO facultyDAO = new FacultyDAO();
        int facultyID = user.getUserID();

        request.setAttribute("pendingMembers", facultyDAO.getPendingMembersByFaculty(facultyID));
        request.getRequestDispatcher("/faculty/members.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int memberID = Integer.parseInt(request.getParameter("memberID"));

        FacultyDAO facultyDAO = new FacultyDAO();
        boolean success = false;
        String message = "";

        if ("approve".equals(action)) {
            success = facultyDAO.updateMemberStatus(memberID, "Approved");
            message = success ? "Member approved successfully!" : "Failed to approve member.";
        } else if ("reject".equals(action)) {
            success = facultyDAO.updateMemberStatus(memberID, "Rejected");
            message = success ? "Member rejected successfully!" : "Failed to reject member.";
        }

        session.setAttribute("message", message);
        session.setAttribute("messageType", success ? "success" : "error");
        response.sendRedirect(request.getContextPath() + "/faculty/members");
    }
}
