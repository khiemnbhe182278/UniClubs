package controller;

import dal.RuleDAO;
import dal.ClubDAO;
import model.Rule;
import model.User;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UpdateRuleServlet", urlPatterns = {"/leader/update-rule"})
public class UpdateRuleServlet extends HttpServlet {

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
            String title = request.getParameter("title");
            String ruleText = request.getParameter("ruleText");

            // Validate inputs
            if (title == null || title.trim().isEmpty()
                    || ruleText == null || ruleText.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=invalid");
                return;
            }

            // Verify ownership
            Club club = clubDAO.getClubById(clubId);

            if (club == null) {
                response.sendRedirect(request.getContextPath()
                        + "/leader/dashboard?error=clubnotfound");
                return;
            }

            // Update rule
            Rule rule = new Rule();
            rule.setRuleID(ruleId);
            rule.setClubID(clubId);
            rule.setTitle(title.trim());
            rule.setRuleText(ruleText.trim());

            boolean success = ruleDAO.updateRule(rule);

            if (success) {
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&success=updated");
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
