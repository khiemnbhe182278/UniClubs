package controller;

import dal.ClubDAO;
import dal.NewsDAO;
import model.Club;
import model.Stats;
import model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private ClubDAO clubDAO;
    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
        newsDAO = new NewsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get featured clubs (top 4)
            List<Club> featuredClubs = clubDAO.getFeaturedClubs(4);
            request.setAttribute("featuredClubs", featuredClubs);

            // Get statistics
            Stats stats = clubDAO.getStats();
            request.setAttribute("stats", stats);

            // Get latest news (top 3)
            List<News> latestNews = newsDAO.getLatestNews(3);
            request.setAttribute("latestNews", latestNews);

            // Forward to homepage JSP
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error loading homepage data");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
