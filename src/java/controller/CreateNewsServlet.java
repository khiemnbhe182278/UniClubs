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

@WebServlet(name = "CreateNewsServlet", urlPatterns = {"/leader/create-news"})
public class CreateNewsServlet extends HttpServlet {

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
            String clubIdParam = request.getParameter("clubId");
            if (clubIdParam == null || clubIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=noclubid");
                return;
            }

            int clubId = Integer.parseInt(clubIdParam);
            Club club = clubDAO.getClubById(clubId);

            if (club == null) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=clubnotfound");
                return;
            }

            request.setAttribute("club", club);
            request.getRequestDispatcher("/create-news.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidclubid");
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

            News news = new News();
            news.setClubID(clubId);
            news.setTitle(title.trim());
            news.setContent(content.trim());
            news.setStatus(status);

            boolean created = newsDAO.createNews(news);

            if (created) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&success=created");
            } else {
                request.setAttribute("error", "Failed to create news");
                doGet(request, response);
            }

        } catch (Exception e) {
            System.err.println("Error creating news: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/leader/news?error=unexpected");
        }
    }
}
