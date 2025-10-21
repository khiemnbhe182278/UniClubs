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
        request.setAttribute("clubID", request.getParameter("clubID"));
        RequestDispatcher dispatcher = request.getRequestDispatcher("create-rule.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int clubID = Integer.parseInt(request.getParameter("clubID"));
        String ruleText = request.getParameter("ruleText");

        Rule newRule = new Rule();
        newRule.setClubID(clubID);
        newRule.setRuleText(ruleText);

        ruleDAO.insertRule(newRule);
        response.sendRedirect(request.getContextPath() + "/rule/create?clubID=" + clubID);
    }
}
