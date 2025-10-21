package controller;

import dal.RuleDAO;
import model.Rule;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/rule/update")
public class RuleUpdateServlet extends HttpServlet {

    private RuleDAO ruleDAO = new RuleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Rule existing = ruleDAO.getRule(id);
        request.setAttribute("rule", existing);
        RequestDispatcher dispatcher = request.getRequestDispatcher("rule-form.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int clubID = Integer.parseInt(request.getParameter("clubID"));
        String ruleText = request.getParameter("ruleText");

        Rule rule = new Rule();
        rule.setRuleID(id);
        rule.setClubID(clubID);
        rule.setRuleText(ruleText);

        ruleDAO.updateRule(rule);
        response.sendRedirect(request.getContextPath() + "/rule/view?id=" + id);
    }
}
