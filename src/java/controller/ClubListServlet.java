package controller;

/**
 * ClubListServlet: Servlet xử lý hiển thị danh sách câu lạc bộ
 * - Hiển thị tất cả CLB đang hoạt động
 * - Hỗ trợ tìm kiếm CLB theo tên
 */

import dal.ClubDAO;    // Import lớp truy cập dữ liệu CLB
import model.Club;     // Import model CLB
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý danh sách câu lạc bộ
 * URL pattern: /clubs
 * 
 * Chức năng chính:
 * 1. Hiển thị danh sách tất cả CLB đang hoạt động
 * 2. Tìm kiếm CLB theo từ khóa người dùng nhập
 * 3. Chuyển hướng dữ liệu tới trang clubs.jsp để hiển thị
 */
@WebServlet(name = "ClubListServlet", urlPatterns = {"/clubs"})
public class ClubListServlet extends HttpServlet {

    // Đối tượng DAO để truy cập dữ liệu CLB
    private ClubDAO clubDAO;

    /**
     * Khởi tạo Servlet
     * Khởi tạo đối tượng ClubDAO để thao tác với database
     */
    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
    }

    /**
     * Xử lý request GET - Hiển thị danh sách CLB
     * Các bước xử lý:
     * 1. Kiểm tra có từ khóa tìm kiếm không
     * 2. Lấy danh sách CLB phù hợp
     * 3. Chuyển dữ liệu tới JSP
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Lấy tham số tìm kiếm từ request (nếu có)
        String search = request.getParameter("search");
        List<Club> clubs;

        // Bước 2: Xử lý tìm kiếm CLB
        if (search != null && !search.trim().isEmpty()) {
            // Nếu có từ khóa tìm kiếm:
            // - Tìm các CLB có tên chứa từ khóa
            // - Lưu từ khóa để hiển thị lại trên form tìm kiếm
            clubs = clubDAO.searchClubs(search);
            request.setAttribute("searchKeyword", search);
        } else {
            // Nếu không có từ khóa:
            // - Lấy tất cả CLB đang hoạt động
            clubs = clubDAO.getAllActiveClubs();
        }

        // Bước 3: Chuyển dữ liệu tới JSP
        // - Đặt danh sách CLB vào request attribute
        // - Chuyển hướng tới trang clubs.jsp để hiển thị
        request.setAttribute("clubs", clubs);
        request.getRequestDispatcher("clubs.jsp").forward(request, response);
    }
}
