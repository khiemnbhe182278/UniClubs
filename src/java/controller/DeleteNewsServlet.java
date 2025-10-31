package controller;

import dal.NewsDAO;
import model.News;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DeleteNewsServlet", urlPatterns = {"/leader/delete-news"})
public class DeleteNewsServlet extends HttpServlet {

    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        newsDAO = new NewsDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String newsIdParam = request.getParameter("newsId");
            String clubIdParam = request.getParameter("clubId");

            if (newsIdParam == null || clubIdParam == null) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=missingparams");
                return;
            }

            int newsId = Integer.parseInt(newsIdParam);
            int clubId = Integer.parseInt(clubIdParam);

            // Verify news exists and belongs to club
            News news = newsDAO.getNewsById(newsId);
            if (news == null) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=notfound");
                return;
            }

            if (news.getClubID() != clubId) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=unauthorized");
                return;
            }

            // Delete news
            boolean deleted = newsDAO.deleteNews(newsId);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=deletefailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidparams");
        } catch (Exception e) {
            System.err.println("Error deleting news: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/leader/news?error=unexpected");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/leader/dashboard");
    }
}
