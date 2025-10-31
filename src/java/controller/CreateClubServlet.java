package controller;

import dal.ClubDAO;
import model.Club;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CreateClubServlet", urlPatterns = {"/create-club"})
public class CreateClubServlet extends HttpServlet {
    /*
     * CreateClubServlet
     * (Tiếng Việt)
     * Mục đích: Cho phép người dùng đã đăng nhập tạo một CLB mới. CLB mới ban đầu có trạng thái "Pending"
     * để chờ admin duyệt.
     * - Input (doPost): form fields - "clubName", "description". Session chứa "user".
     * - Xử lý:
     *   + Kiểm tra đã đăng nhập, validate các trường bắt buộc.
     *   + Tạo đối tượng Club, gán leaderID = userID hiện tại, facultyID tạm thời cũng gán userID.
     *   + Gọi ClubDAO.createClub(club) để lưu vào DB.
     * - Output: Hiển thị thông báo thành công (chờ duyệt) hoặc lỗi nếu tạo thất bại.
     * - Ghi chú: Việc gán FacultyID = userID là tạm thời trong mã nguồn này và nên thay bằng lựa chọn chính xác.
     */

    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Chỉ cho phép truy cập trang tạo CLB khi đã đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("create-club.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String clubName = request.getParameter("clubName");
        String description = request.getParameter("description");

        // Validate các trường bắt buộc
        if (clubName == null || clubName.trim().isEmpty()
                || description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("create-club.jsp").forward(request, response);
            return;
        }

        Club club = new Club();
        club.setClubName(clubName.trim());
        club.setDescription(description.trim());
        club.setLeaderID(user.getUserID());
        club.setFacultyID(user.getUserID()); // Tạm gán, nên có lựa chọn faculty thực tế
        club.setStatus("Pending");

        boolean success = clubDAO.createClub(club);

        if (success) {
            request.setAttribute("success", "Club created successfully! Waiting for admin approval.");
            request.getRequestDispatcher("create-club.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to create club. Please try again.");
            request.getRequestDispatcher("create-club.jsp").forward(request, response);
        }
    }
}
