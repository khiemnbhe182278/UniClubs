package controller;

/**
 * Đây là package chứa các servlet điều khiển (controllers) trong mô hình MVC
 */

import dal.ClubDAO;    // Import lớp truy cập dữ liệu câu lạc bộ
import dal.NewsDAO;    // Import lớp truy cập dữ liệu tin tức
import model.Club;     // Import model câu lạc bộ
import model.Stats;    // Import model thống kê
import model.News;     // Import model tin tức
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * HomeServlet: Servlet xử lý trang chủ của ứng dụng
 * - URL pattern: /home
 * - Chức năng: Hiển thị các CLB nổi bật, thống kê và tin tức mới nhất
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    // Khai báo các đối tượng DAO để truy cập dữ liệu
    private ClubDAO clubDAO;    // Đối tượng truy cập dữ liệu câu lạc bộ
    private NewsDAO newsDAO;     // Đối tượng truy cập dữ liệu tin tức

    /**
     * Phương thức khởi tạo Servlet
     * Được gọi một lần khi servlet được tạo
     * Khởi tạo các đối tượng DAO cần thiết
     */
    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();    // Khởi tạo đối tượng truy cập dữ liệu CLB
        newsDAO = new NewsDAO();     // Khởi tạo đối tượng truy cập dữ liệu tin tức
    }

    /**
     * Xử lý request GET tới trang chủ
     * Lấy dữ liệu và hiển thị trang chủ với:
     * - 4 CLB nổi bật nhất
     * - Các thống kê tổng quan
     * - 3 tin tức mới nhất
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Lấy danh sách 4 CLB nổi bật nhất
            List<Club> featuredClubs = clubDAO.getFeaturedClubs(4);
            // Lưu vào request để JSP có thể truy cập
            request.setAttribute("featuredClubs", featuredClubs);

            // 2. Lấy các số liệu thống kê tổng quan
            Stats stats = clubDAO.getStats();
            // Lưu thống kê vào request
            request.setAttribute("stats", stats);

            // 3. Lấy 3 tin tức mới nhất
            List<News> latestNews = newsDAO.getLatestNews(3);
            // Lưu tin tức vào request
            request.setAttribute("latestNews", latestNews);

            // 4. Chuyển hướng sang trang home.jsp để hiển thị
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception e) {
            // Xử lý lỗi: in stack trace để debug và trả về lỗi 500
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error loading homepage data");
        }
    }

    /**
     * Xử lý request POST
     * Trong trường hợp này, chỉ cần chuyển tiếp sang phương thức GET
     * vì trang chủ chỉ cần hiển thị dữ liệu
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
