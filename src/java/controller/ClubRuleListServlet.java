package controller;

import dal.RuleDAO;
import model.Rule;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/club-rules")
public class ClubRuleListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clubIdRaw = request.getParameter("clubID");
        int clubID = Integer.parseInt(clubIdRaw);

        RuleDAO dao = new RuleDAO();
        List<Rule> rules = dao.getRulesByClubWithName(clubID);

        request.setAttribute("rules", rules);
        request.getRequestDispatcher("clubRules.jsp").forward(request, response);
    }
}
