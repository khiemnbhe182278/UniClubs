package controller;

/**
 * Servlet xử lý chức năng đăng ký tham gia câu lạc bộ
 */

import dal.MemberDAO;    // Import lớp truy cập dữ liệu thành viên
import model.User;       // Import model người dùng
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * JoinClubServlet: Xử lý yêu cầu tham gia CLB của người dùng
 * URL pattern: /join-club
 * Phương thức hỗ trợ: GET và POST
 */
@WebServlet(name = "JoinClubServlet", urlPatterns = {"/join-club"})
public class JoinClubServlet extends HttpServlet {

    // Đối tượng DAO để thao tác với dữ liệu thành viên
    private MemberDAO memberDAO;

    /**
     * Khởi tạo Servlet
     * Khởi tạo đối tượng MemberDAO để thao tác với database
     */
    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
    }

    /**
     * Xử lý request GET - Chuyển tiếp tới processRequest
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Xử lý request POST - Chuyển tiếp tới processRequest
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Xử lý chính cho cả request GET và POST
     * Các bước xử lý:
     * 1. Kiểm tra đăng nhập
     * 2. Lấy thông tin CLB cần tham gia
     * 3. Kiểm tra điều kiện và thực hiện đăng ký
     */
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra trạng thái đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Nếu chưa đăng nhập:
            // - Lưu URL hiện tại để redirect sau khi đăng nhập
            // - Chuyển hướng tới trang đăng nhập
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", request.getRequestURI() + "?" + request.getQueryString());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin người dùng đã đăng nhập
        User user = (User) session.getAttribute("user");

        try {
            // Bước 2: Lấy và xác thực ID của câu lạc bộ
            // Hỗ trợ cả 2 parameter name: "id" và "clubId"
            String clubIdParam = request.getParameter("id");
            if (clubIdParam == null) {
                clubIdParam = request.getParameter("clubId");
            }

            // Kiểm tra xem có ID CLB được cung cấp không
            if (clubIdParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing club ID");
                return;
            }

            // Chuyển đổi ID từ String sang Integer
            int clubId = Integer.parseInt(clubIdParam);

            // Bước 3.1: Kiểm tra xem người dùng đã là thành viên hoặc đã gửi yêu cầu chưa
            if (memberDAO.isMember(user.getUserID(), clubId)) {
                // Nếu đã là thành viên hoặc đã gửi yêu cầu:
                // - Đặt thông báo lỗi
                // - Chuyển hướng về trang chi tiết CLB
                session.setAttribute("error", "Bạn đã là thành viên hoặc đã gửi yêu cầu tham gia CLB này");
                response.sendRedirect(request.getContextPath() + "/club-detail?id=" + clubId);
                return;
            }

            // Bước 3.2: Thực hiện đăng ký tham gia CLB
            boolean success = memberDAO.joinClub(user.getUserID(), clubId);

            // Bước 3.3: Xử lý kết quả đăng ký
            if (success) {
                // Nếu đăng ký thành công:
                // - Đặt thông báo thành công
                session.setAttribute("success", "Đã gửi yêu cầu tham gia thành công! Vui lòng đợi phê duyệt.");
            } else {
                // Nếu đăng ký thất bại:
                // - Đặt thông báo lỗi
                session.setAttribute("error", "Không thể gửi yêu cầu tham gia. Vui lòng thử lại.");
            }

            // Bước 3.4: Chuyển hướng về trang chi tiết CLB
            response.sendRedirect(request.getContextPath() + "/club-detail?id=" + clubId);

        } catch (NumberFormatException e) {
            // Xử lý lỗi khi clubId không phải là số
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID câu lạc bộ không hợp lệ");
        }
    }
}
