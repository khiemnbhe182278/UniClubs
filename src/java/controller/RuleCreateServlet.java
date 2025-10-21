package controller;

import dal.RuleDAO;
import model.Rule;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/rule/create")
public class RuleCreateServlet extends HttpServlet {
    private RuleDAO ruleDAO = new RuleDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String clubID = request.getParameter("clubID");
        if (clubID == null) {
            response.sendError(400, "Missing clubID");
            return;
        }
        request.setAttribute("clubID", clubID);
        request.getRequestDispatcher("/rule/create-rule.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            request.setCharacterEncoding("UTF-8");
            
            int clubID = Integer.parseInt(request.getParameter("clubID"));
            String title = request.getParameter("title");
            String ruleText = request.getParameter("ruleText");
            
            System.out.println("clubID: " + clubID);
            System.out.println("title: " + title);
            System.out.println("ruleText: " + (ruleText != null ? ruleText.substring(0, Math.min(50, ruleText.length())) : "null"));
            
            Rule newRule = new Rule();
            newRule.setClubID(clubID);
            newRule.setTitle(title);
            newRule.setRuleText(ruleText);
            
            boolean success = ruleDAO.insertRule(newRule);
            System.out.println("Insert success: " + success);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/clubRules?clubID=" + clubID);
            } else {
                response.sendError(500, "Failed to insert rule");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error: " + e.getMessage());
        }
    }
}