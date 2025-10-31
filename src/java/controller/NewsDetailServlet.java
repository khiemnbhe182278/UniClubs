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

/**
 * Servlet xử lý hiển thị chi tiết tin tức cho người dùng là leader của câu lạc bộ
 * URL Pattern: /leader/news-detail
 * Phương thức: GET, POST
 * 
 * Servlet này cho phép leader của câu lạc bộ xem chi tiết một tin tức cụ thể.
 * Kiểm tra quyền truy cập và xác thực rằng tin tức thuộc về câu lạc bộ của leader.
 */
@WebServlet(name = "NewsDetailServlet", urlPatterns = {"/leader/news-detail"})
public class NewsDetailServlet extends HttpServlet {

    /**
     * DAO đối tượng để tương tác với bảng News trong cơ sở dữ liệu
     */
    private NewsDAO newsDAO;
    
    /**
     * DAO đối tượng để tương tác với bảng Club trong cơ sở dữ liệu
     */
    private ClubDAO clubDAO;

    /**
     * Khởi tạo các DAO khi servlet được tạo
     * @throws ServletException nếu có lỗi xảy ra trong quá trình khởi tạo
     */
    @Override
    public void init() throws ServletException {
        newsDAO = new NewsDAO();
        clubDAO = new ClubDAO();
    }

    /**
     * Xử lý yêu cầu GET để hiển thị chi tiết tin tức
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra session và xác thực người dùng
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Lấy ID tin tức và ID câu lạc bộ từ parameters
            String newsIdParam = request.getParameter("id");
            String clubIdParam = request.getParameter("clubId");

            // Kiểm tra xem có đủ tham số không
            if (newsIdParam == null || clubIdParam == null) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=missingparams");
                return;
            }

            // Chuyển đổi ID từ String sang int
            int newsId = Integer.parseInt(newsIdParam);
            int clubId = Integer.parseInt(clubIdParam);

            // Lấy thông tin tin tức và câu lạc bộ từ database
            News news = newsDAO.getNewsById(newsId);
            Club club = clubDAO.getClubById(clubId);

            // Kiểm tra xem tin tức và câu lạc bộ có tồn tại không
            if (news == null || club == null) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=notfound");
                return;
            }

            // Xác thực xem tin tức có thuộc về câu lạc bộ không
            if (news.getClubID() != clubId) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=unauthorized");
                return;
            }

            // Đặt thuộc tính và chuyển hướng đến trang JSP
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

    /**
     * Chuyển hướng yêu cầu POST sang phương thức GET
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
