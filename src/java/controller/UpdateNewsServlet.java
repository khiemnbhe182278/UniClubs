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

@WebServlet(name = "UpdateNewsServlet", urlPatterns = {"/leader/update-news"})
public class UpdateNewsServlet extends HttpServlet {

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
            request.getRequestDispatcher("/update-news.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidparams");
        }
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
            int newsId = Integer.parseInt(request.getParameter("newsId"));
            int clubId = Integer.parseInt(request.getParameter("clubId"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String status = request.getParameter("status");

            // Validation
            if (title == null || title.trim().isEmpty()
                    || content == null || content.trim().isEmpty()
                    || status == null || status.trim().isEmpty()) {
                request.setAttribute("error", "All fields are required");
                doGet(request, response);
                return;
            }

            News news = newsDAO.getNewsById(newsId);
            if (news == null || news.getClubID() != clubId) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=unauthorized");
                return;
            }

            news.setTitle(title.trim());
            news.setContent(content.trim());
            news.setStatus(status);

            boolean updated = newsDAO.updateNews(news);

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&success=updated");
            } else {
                request.setAttribute("error", "Failed to update news");
                doGet(request, response);
            }

        } catch (Exception e) {
            System.err.println("Error updating news: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/leader/news?error=unexpected");
        }
    }
}
