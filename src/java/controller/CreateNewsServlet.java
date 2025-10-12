package controller;

import dal.NewsDAO;
import model.News;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet("/createNews")
public class CreateNewsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/news/createNews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String clubIDParam = request.getParameter("clubID");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // Server-side validation
        if (clubIDParam == null || title == null || title.trim().isEmpty()
                || content == null || content.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required. Please fill in all information.");

            // Retain user input
            request.setAttribute("title", title);
            request.setAttribute("content", content);

            request.getRequestDispatcher("/news/createNews.jsp").forward(request, response);
            return;
        }

        try {
            int clubID = Integer.parseInt(clubIDParam);

            News n = new News();
            n.setClubID(clubID);
            n.setTitle(title);
            n.setContent(content);
            n.setStatus("Published"); // Tin tức thường được công bố ngay lập tức
            n.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

            NewsDAO dao = new NewsDAO();
            boolean success = dao.createNews(n);

            if (success) {
                request.getSession().setAttribute("successMessage", "News created successfully!");
                response.sendRedirect("listNews?clubID=" + clubID); // Chuyển hướng đến trang danh sách tin tức
            } else {
                request.setAttribute("errorMessage", "Failed to create news. Please try again.");
                request.setAttribute("title", title);
                request.setAttribute("content", content);
                request.getRequestDispatcher("/news/createNews.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Club ID. Please contact support.");
            request.getRequestDispatcher("/news/createNews.jsp").forward(request, response);
        }
    }
}
