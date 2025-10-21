package controller;

import dal.RuleDAO;
import model.Rule;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/rule/view")
public class RuleViewServlet extends HttpServlet {

    private RuleDAO ruleDAO = new RuleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int ruleID = Integer.parseInt(request.getParameter("id"));

        Rule rule = ruleDAO.getRule(ruleID);
        if (rule == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Rule not found");
            return;
        }

        request.setAttribute("rule", rule);
        RequestDispatcher dispatcher = request.getRequestDispatcher("rule-view.jsp");
        dispatcher.forward(request, response);
    }
}
