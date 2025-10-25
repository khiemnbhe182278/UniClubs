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

@WebServlet(name = "ClubListServlet", urlPatterns = {"/clubs"})
public class ClubListServlet extends HttpServlet {

    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        List<Club> clubs;

        if (search != null && !search.trim().isEmpty()) {
            clubs = clubDAO.searchClubs(search);
            request.setAttribute("searchKeyword", search);
        } else {
            clubs = clubDAO.getAllActiveClubs();
        }

        request.setAttribute("clubs", clubs);
        request.getRequestDispatcher("clubs.jsp").forward(request, response);
    }
}
