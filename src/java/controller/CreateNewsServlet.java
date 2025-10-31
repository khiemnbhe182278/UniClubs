package controller;

import dal.NewsDAO;
import dal.UserDAO;
import dal.ClubDAO;
import model.News;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(urlPatterns = {"/createNews", "/leader/create-news"})
public class CreateNewsServlet extends HttpServlet {

    private UserDAO userDAO;
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user != null) {
            // Truyền clubId vào request
            if (user.getRoleID() == 2) { // Leader
                Integer clubId = userDAO.getLeaderPrimaryClubId(user.getUserID());
                List<Integer> clubIds = userDAO.getLeaderClubIds(user.getUserID());
                request.setAttribute("userClubId", clubId);
                request.setAttribute("userClubIds", clubIds);
            } else if (user.getRoleID() == 3) { // Faculty
                Integer clubId = userDAO.getFacultyPrimaryClubId(user.getUserID());
                List<Integer> clubIds = userDAO.getFacultyClubIds(user.getUserID());
                request.setAttribute("userClubId", clubId);
                request.setAttribute("userClubIds", clubIds);
            }
        }

        if (request.getServletPath() != null && request.getServletPath().startsWith("/leader")) {
            request.getRequestDispatcher("/leader-create-news.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/news/createNews.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String clubIDParam = request.getParameter("clubID");
        if (clubIDParam == null) {
            clubIDParam = request.getParameter("clubId");
        }
        // fallback to session-stored currentClubId if available
        if (clubIDParam == null && session != null && session.getAttribute("currentClubId") != null) {
            clubIDParam = String.valueOf(session.getAttribute("currentClubId"));
        }
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (clubIDParam == null || title == null || title.trim().isEmpty()
                || content == null || content.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.setAttribute("title", title);
            request.setAttribute("content", content);
            doGet(request, response);
            return;
        }

        try {
            int clubID = Integer.parseInt(clubIDParam);



            News n = new News();
            n.setClubID(clubID);
            n.setTitle(title);
            n.setContent(content);
            n.setStatus("Published");
            n.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

            NewsDAO dao = new NewsDAO();
            boolean success = dao.createNews(n);

            if (success) {
                request.getSession().setAttribute("successMessage", "News created successfully!");
                if (request.getServletPath() != null && request.getServletPath().startsWith("/leader")) {
                    response.sendRedirect(request.getContextPath() + "/leader/dashboard?success=news_created");
                } else {
                    response.sendRedirect("listNews?clubID=" + clubID);
                }
            } else {
                request.setAttribute("errorMessage", "Failed to create news. Please try again.");
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Club ID.");
            doGet(request, response);
        }
    }
}
