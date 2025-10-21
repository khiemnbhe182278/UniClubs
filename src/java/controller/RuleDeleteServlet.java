package controller;

import dal.RuleDAO;
import model.Rule;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/rule/delete")
public class RuleDeleteServlet extends HttpServlet {

    private RuleDAO ruleDAO = new RuleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Rule r = ruleDAO.getRule(id);
        if (r != null) {
            ruleDAO.deleteRule(id);
            response.sendRedirect(request.getContextPath() + "/rule/create?clubID=" + r.getClubID());
        } else {
            response.sendRedirect(request.getContextPath() + "/rules");
        }
    }
}
