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
import java.util.List;

@WebServlet(name = "ManageRulesServlet", urlPatterns = {"/leader/rules"})
public class ManageRulesServlet extends HttpServlet {

    private RuleDAO ruleDAO;
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        ruleDAO = new RuleDAO();
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check session
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Check authentication
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get clubId parameter
            String clubIdParam = request.getParameter("clubId");

            if (clubIdParam == null || clubIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=noclubid");
                return;
            }

            int clubId = Integer.parseInt(clubIdParam);

            // Get club details
            Club club = clubDAO.getClubById(clubId);

            if (club == null) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=clubnotfound");
                return;
            }

            // Get all rules for this club
            List<Rule> rules = ruleDAO.getRulesByClubId(clubId);

            // Set attributes
            request.setAttribute("club", club);
            request.setAttribute("rules", rules);

            // Forward to JSP
            request.getRequestDispatcher("/leader-rules.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidclubid");
        } catch (Exception e) {
            System.err.println("Error in ManageRulesServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=unexpected");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
