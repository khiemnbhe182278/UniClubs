package controller;

import dal.NewsDAO;
import dal.ClubDAO;
import model.News;
import model.User;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "NewsDetailServlet", urlPatterns = {"/leader/news-detail"})
public class NewsDetailServlet extends HttpServlet {

    private NewsDAO newsDAO;
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        newsDAO = new NewsDAO();
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String newsIdParam = request.getParameter("id");
            String clubIdParam = request.getParameter("clubId");

            if (newsIdParam == null || clubIdParam == null) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=missingparams");
                return;
            }

            int newsId = Integer.parseInt(newsIdParam);
            int clubId = Integer.parseInt(clubIdParam);

            News news = newsDAO.getNewsById(newsId);
            Club club = clubDAO.getClubById(clubId);

            if (news == null || club == null) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=notfound");
                return;
            }

            // Verify news belongs to club
            if (news.getClubID() != clubId) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=unauthorized");
                return;
            }

            request.setAttribute("news", news);
            request.setAttribute("club", club);
            request.getRequestDispatcher("/news-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidparams");
        } catch (Exception e) {
            System.err.println("Error viewing news detail: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/leader/news?error=unexpected");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
