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

@WebServlet(name = "CreateRuleServlet", urlPatterns = {"/leader/create-rule"})
public class CreateRuleServlet extends HttpServlet {

    private RuleDAO ruleDAO;
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        try {
            // Initialize DAOs with proper error handling
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

        // Check if session exists
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
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

            // Create new rule
            Rule rule = new Rule();
            rule.setClubID(clubId);
            rule.setTitle(title.trim());
            rule.setRuleText(ruleText.trim());

            boolean success = ruleDAO.createRule(rule);

            if (success) {
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&success=created");
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
        // Clean up resources if needed
        ruleDAO = null;
        clubDAO = null;
    }
}
