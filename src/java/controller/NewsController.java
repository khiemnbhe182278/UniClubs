package controller;

import dal.NewsDAO;
import model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/news")
public class NewsController extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "view":
                    showNewsDetail(request, response);
                    break;

                case "new":
                    showNewsForm(request, response);
                    break;

                case "edit":
                    showEditForm(request, response);
                    break;

                case "delete":
                    deleteNews(request, response);
                    break;

                default: // list
                    showNewsList(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("news?error=server_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {
            if ("create".equals(action) || "update".equals(action)) {
                handleNewsSubmit(request, response, action);
            } else {
                response.sendRedirect("news?error=invalid_action");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("news?error=server_error");
        }
    }

    // === PRIVATE HELPER METHODS ===

    private void showNewsList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<News> newsList = newsDAO.getAllNews();
        request.setAttribute("newsList", newsList);
        request.getRequestDispatcher("/HomePage/News.jsp").forward(request, response);
    }

    private void showNewsDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int newsId = Integer.parseInt(request.getParameter("id"));
            News news = newsDAO.getNewsById(newsId);
            
            if (news != null) {
                request.setAttribute("news", news);
                // SỬA ĐƯỜNG DẪN NÀY
                request.getRequestDispatcher("/news-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("news?error=notfound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("news?error=invalid_id");
        }
    }

    private void showNewsForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        Integer authorId = (Integer) session.getAttribute("userId");
        
        if (authorId == null) {
            response.sendRedirect("login.jsp?error=please_login");
            return;
        }
        
        request.getRequestDispatcher("/news-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Kiểm tra đăng nhập
            HttpSession session = request.getSession();
            Integer authorId = (Integer) session.getAttribute("userId");
            
            if (authorId == null) {
                response.sendRedirect("login.jsp?error=please_login");
                return;
            }

            int editId = Integer.parseInt(request.getParameter("id"));
            News editNews = newsDAO.getNewsById(editId);
            
            if (editNews != null) {
                // Kiểm tra quyền
                if (editNews.getAuthorId() != authorId.intValue()) {
                    response.sendRedirect("news?error=unauthorized");
                    return;
                }
                
                request.setAttribute("news", editNews);
                request.getRequestDispatcher("/news-form.jsp").forward(request, response);
            } else {
                response.sendRedirect("news?error=notfound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("news?error=invalid_id");
        }
    }

    private void deleteNews(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            HttpSession session = request.getSession();
            Integer authorId = (Integer) session.getAttribute("userId");
            
            if (authorId == null) {
                response.sendRedirect("login.jsp?error=please_login");
                return;
            }

            int deleteId = Integer.parseInt(request.getParameter("id"));
            News newsToDelete = newsDAO.getNewsById(deleteId);
            
            if (newsToDelete != null && newsToDelete.getAuthorId() != authorId.intValue()) {
                response.sendRedirect("news?error=unauthorized");
                return;
            }
            
            boolean deleted = newsDAO.deleteNews(deleteId);
            response.sendRedirect("news" + (deleted ? "?success=deleted" : "?error=delete_failed"));
            
        } catch (NumberFormatException e) {
            response.sendRedirect("news?error=invalid_id");
        }
    }

    private void handleNewsSubmit(HttpServletRequest request, HttpServletResponse response, String action) 
            throws IOException {
        HttpSession session = request.getSession();
        Integer authorId = (Integer) session.getAttribute("userId");
        
        if (authorId == null) {
            response.sendRedirect("login.jsp?error=please_login");
            return;
        }

        try {
            News news = new News();
            
            if ("update".equals(action)) {
                news.setId(Integer.parseInt(request.getParameter("id")));
            }
            
            news.setTitle(request.getParameter("title"));
            news.setContent(request.getParameter("content"));
            news.setImageUrl(request.getParameter("imageUrl"));
            news.setAuthorId(authorId);
            news.setPublishDate(LocalDate.parse(request.getParameter("publishDate")));
            news.setStatus(request.getParameter("status") != null ? request.getParameter("status") : "published");

            boolean success;
            if ("create".equals(action)) {
                success = newsDAO.insertNews(news);
            } else {
                // Kiểm tra quyền trước khi update
                News existingNews = newsDAO.getNewsById(news.getId());
                if (existingNews != null && existingNews.getAuthorId() != authorId.intValue()) {
                    response.sendRedirect("news?error=unauthorized");
                    return;
                }
                success = newsDAO.updateNews(news);
            }

            response.sendRedirect("news?success=" + ("create".equals(action) ? "created" : "updated"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("news?error=invalid_data");
        }
    }
}