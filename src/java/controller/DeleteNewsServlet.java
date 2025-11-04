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

    /*
     * DeleteNewsServlet
     * Mục đích: Xóa một bài tin (news) thuộc về một câu lạc bộ do leader quản lý.
     * Đường dẫn: /leader/delete-news
     *
     * Giải thích đơn giản cho người không biết code:
     * - Khi leader nhấn nút xóa trên giao diện quản lý tin, trang web gửi một yêu cầu POST đến đường dẫn này.
     * - Servlet sẽ: kiểm tra người dùng đã đăng nhập, kiểm tra mã tin và mã CLB gửi lên,
     *   kiểm tra tin có tồn tại và thuộc về CLB hay không, rồi gọi hàm xóa trong cơ sở dữ liệu.
     * - Sau đó servlet chuyển hướng người dùng về trang danh sách tin kèm thông báo thành/không thành công.
     */
    // DAO để thao tác với bảng tin tức trong cơ sở dữ liệu
    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo đối tượng DAO khi servlet được nạp
        newsDAO = new NewsDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Bước 1: Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // Nếu chưa đăng nhập, chuyển tới trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Bước 2: Lấy tham số từ form
            String newsIdParam = request.getParameter("newsId");
            String clubIdParam = request.getParameter("clubId");

            // Nếu thiếu tham số -> thông báo lỗi
            if (newsIdParam == null || clubIdParam == null) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=missingparams");
                return;
            }

            // Bước 3: Chuyển tham số sang số
            int newsId = Integer.parseInt(newsIdParam);
            int clubId = Integer.parseInt(clubIdParam);

            // Bước 4: Kiểm tra tin tồn tại và thuộc về CLB
            // Lấy tin từ CSDL
            News news = newsDAO.getNewsById(newsId);
            if (news == null) {
                // Nếu không tìm thấy tin -> quay lại danh sách với lỗi
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=notfound");
                return;
            }

            // Kiểm tra chủ sở hữu (tránh xóa tin của CLB khác)
            if (news.getClubID() != clubId) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=unauthorized");
                return;
            }

            // Bước 5: Gọi DAO để xóa
            boolean deleted = newsDAO.deleteNews(newsId);

            // Bước 6: Chuyển hướng kèm thông báo kết quả
            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/leader/news?clubId=" + clubId + "&error=deletefailed");
            }

        } catch (NumberFormatException e) {
            // Nếu tham số không phải số
            response.sendRedirect(request.getContextPath() + "/leader/dashboard?error=invalidparams");
        } catch (Exception e) {
            // Các lỗi bất ngờ
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
