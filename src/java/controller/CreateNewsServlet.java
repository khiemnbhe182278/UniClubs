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

/*
 * Servlet xử lý việc tạo tin tức mới cho câu lạc bộ
 * Đường dẫn: /leader/create-news
 * 
 * Chức năng chính:
 * 1. Hiển thị form tạo tin tức (GET)
 * 2. Xử lý lưu tin tức mới (POST) 
 */
@WebServlet(name = "CreateNewsServlet", urlPatterns = {"/leader/create-news"})
public class CreateNewsServlet extends HttpServlet {

    /*
     * NewsDAO: Đối tượng để thao tác với bảng tin tức trong CSDL
     * Ví dụ: Thêm tin mới, cập nhật tin, lấy danh sách tin
     */
    private NewsDAO newsDAO;

    /*
     * ClubDAO: Đối tượng để truy vấn thông tin CLB từ CSDL
     * Ví dụ: Lấy tên CLB, kiểm tra quyền quản lý của người dùng
     */
    private ClubDAO clubDAO;

    /*
     * Khởi tạo các đối tượng cần thiết khi servlet bắt đầu chạy
     */
    @Override
    public void init() throws ServletException {
        // Tạo đối tượng để làm việc với CSDL
        newsDAO = new NewsDAO();
        clubDAO = new ClubDAO();
    }

    /*
     * Xử lý hiển thị trang tạo tin tức mới
     * 
     * Quy trình:
     * 1. Kiểm tra đăng nhập
     * 2. Lấy và xác thực thông tin CLB
     * 3. Hiển thị form tạo tin
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Bước 1: Kiểm tra trạng thái đăng nhập
        HttpSession session = request.getSession(false);

        // Nếu chưa đăng nhập hoặc hết phiên làm việc -> chuyển đến trang đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Bước 2: Lấy mã CLB từ URL
            String clubIdParam = request.getParameter("clubId");
            // Kiểm tra xem có mã CLB được cung cấp không
            if (clubIdParam == null || clubIdParam.trim().isEmpty()) {
                // Nếu không có mã CLB -> thông báo lỗi và quay về trang chủ
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=noclubid");
                return;
            }

            // Chuyển mã CLB từ chuỗi sang số và tìm thông tin CLB
            int clubId = Integer.parseInt(clubIdParam);
            Club club = clubDAO.getClubById(clubId);

            // Kiểm tra CLB có tồn tại không
            if (club == null) {
                // Nếu không tìm thấy CLB -> thông báo lỗi
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=clubnotfound");
                return;
            }

            // Bước 3: Chuẩn bị dữ liệu và hiển thị form
            // Đưa thông tin CLB vào request để JSP có thể hiển thị
            request.setAttribute("club", club);
            // Chuyển người dùng đến trang tạo tin tức
            request.getRequestDispatcher("/create-news.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidclubid");
        }
    }

    /*
     * Xử lý khi người dùng gửi form tạo tin tức mới (nhấn nút Submit)
     * 
     * Quy trình:
     * 1. Kiểm tra đăng nhập
     * 2. Thu thập thông tin từ form
     * 3. Kiểm tra dữ liệu hợp lệ
     * 4. Lưu tin tức mới vào CSDL
     * 5. Thông báo kết quả cho người dùng
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Bước 1: Kiểm tra trạng thái đăng nhập
        HttpSession session = request.getSession(false);

        // Nếu chưa đăng nhập -> chuyển đến trang đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Bước 2: Thu thập thông tin từ form người dùng đã gửi
            int clubId = Integer.parseInt(request.getParameter("clubId"));    // Mã CLB
            String title = request.getParameter("title");      // Tiêu đề tin tức
            String content = request.getParameter("content");  // Nội dung chi tiết
            String status = request.getParameter("status");    // Trạng thái (draft/published)

            // Bước 3: Kiểm tra tính hợp lệ của dữ liệu
            // - Tiêu đề không được trống
            // - Nội dung không được trống
            // - Trạng thái phải là giá trị cho phép
            if (title == null || title.trim().isEmpty()
                    || content == null || content.trim().isEmpty()
                    || status == null || status.trim().isEmpty()) {
                // Nếu thiếu thông tin -> thông báo lỗi và quay lại form
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
                doGet(request, response);
                return;
            }

            // Bước 4: Tạo đối tượng tin tức mới
            News news = new News();
            news.setClubID(clubId);                  // Gán mã CLB
            news.setTitle(title.trim());             // Gán tiêu đề (đã cắt khoảng trắng)
            news.setContent(content.trim());         // Gán nội dung (đã cắt khoảng trắng)
            news.setStatus(status);                  // Gán trạng thái

            // Lưu tin tức vào CSDL
            boolean created = newsDAO.createNews(news);

            // Bước 5: Kiểm tra kết quả và thông báo
            if (created) {
                // Thành công -> chuyển đến trang danh sách tin với thông báo
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&success=created");
            } else {
                // Thất bại -> quay lại form với thông báo lỗi
                request.setAttribute("error", "Không thể tạo tin tức. Vui lòng thử lại");
                doGet(request, response);
            }

        } catch (Exception e) {
            // Ghi log lỗi để kiểm tra và sửa chữa
            System.err.println("Lỗi khi tạo tin tức: " + e.getMessage());
            e.printStackTrace();
            // Thông báo lỗi cho người dùng
            response.sendRedirect(request.getContextPath() + "/leader/news?error=unexpected");
        }
    }
}
