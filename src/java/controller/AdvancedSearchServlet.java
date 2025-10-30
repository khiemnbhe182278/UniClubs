package controller;

import dal.ClubDAO;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdvancedSearchServlet", urlPatterns = {"/clubs/search"})
public class AdvancedSearchServlet extends HttpServlet {

    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String memberCountStr = request.getParameter("memberCount");
        String sortBy = request.getParameter("sort");

        int minMembers = 0;
        if (memberCountStr != null && !memberCountStr.isEmpty()) {
            try {
                minMembers = Integer.parseInt(memberCountStr);
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        List<Club> clubs = clubDAO.advancedSearch(keyword, category, minMembers, sortBy);

        request.setAttribute("clubs", clubs);
        request.getRequestDispatcher("/clubs-advanced.jsp").forward(request, response);
    }
}
