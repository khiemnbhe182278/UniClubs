package controller;

import dal.RuleDAO;
import dal.ClubDAO;
import model.User;
import model.Club;
import model.Rule;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DeleteRuleServlet", urlPatterns = {"/leader/delete-rule"})
public class DeleteRuleServlet extends HttpServlet {

    private RuleDAO ruleDAO;
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        try {
            ruleDAO = new RuleDAO();
            clubDAO = new ClubDAO();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize DAOs", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int ruleId = Integer.parseInt(request.getParameter("ruleId"));
            int clubId = Integer.parseInt(request.getParameter("clubId"));

            // Verify ownership
            Club club = clubDAO.getClubById(clubId);

            if (club == null) {
                response.sendRedirect(request.getContextPath()
                        + "/leader/dashboard?error=clubnotfound");
                return;
            }

            // Get rule to verify it belongs to this club
            Rule rule = ruleDAO.getRuleById(ruleId);

            if (rule == null || rule.getClubID() != clubId) {
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=notfound");
                return;
            }

            // Delete rule
            boolean success = ruleDAO.deleteRule(ruleId);

            if (success) {
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&success=deleted");
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/leader/dashboard?error=invalid");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()
                    + "/leader/dashboard?error=unexpected");
        }
    }

    @Override
    public void destroy() {
        ruleDAO = null;
        clubDAO = null;
    }
}
