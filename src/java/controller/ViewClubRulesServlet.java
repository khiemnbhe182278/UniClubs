package controller;

import dal.RuleDAO;
import model.Rule;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/clubRules")
public class ViewClubRulesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int clubID = Integer.parseInt(request.getParameter("clubID"));

        try {
            RuleDAO dao = new RuleDAO();
            List<Rule> rules = dao.getRulesByClub(clubID);

            request.setAttribute("rules", rules);
            RequestDispatcher rd = request.getRequestDispatcher("club_rules.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
