package controller;

/**
 * ClubMembersServlet: Servlet xử lý quản lý thành viên của câu lạc bộ
 * - Hiển thị danh sách thành viên
 * - Phê duyệt/từ chối yêu cầu tham gia
 */

import dal.MemberDAO;    // Import lớp truy cập dữ liệu thành viên
import model.Member;     // Import model thành viên
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet quản lý thành viên CLB
 * URL pattern: /club/members
 * 
 * Chức năng chính:
 * 1. Hiển thị danh sách tất cả thành viên của CLB
 * 2. Xử lý phê duyệt/từ chối yêu cầu tham gia
 * 3. Kiểm tra quyền truy cập (chỉ leader CLB mới có quyền)
 */
@WebServlet("/club/members")
public class ClubMembersServlet extends HttpServlet {

    /**
     * Xử lý request GET - Hiển thị danh sách thành viên
     * Các bước xử lý:
     * 1. Kiểm tra người dùng đã đăng nhập và có quyền truy cập
     * 2. Lấy danh sách thành viên của CLB
     * 3. Chuyển dữ liệu tới JSP để hiển thị
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra quyền truy cập
        HttpSession session = request.getSession();
        Integer clubId = (Integer) session.getAttribute("currentClubId");

        // Nếu chưa đăng nhập hoặc không có quyền, chuyển về trang đăng nhập
        if (clubId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Bước 2: Lấy danh sách thành viên
        MemberDAO dao = new MemberDAO();
        List<Member> members = dao.getClubMembers(clubId);

        // Bước 3: Chuyển dữ liệu tới JSP
        request.setAttribute("members", members);
        RequestDispatcher rd = request.getRequestDispatcher("/clubMembers.jsp");
        rd.forward(request, response);
    }

    /**
     * Xử lý request POST - Phê duyệt/từ chối thành viên
     * Các bước xử lý:
     * 1. Lấy thông tin hành động (phê duyệt/từ chối) và ID thành viên
     * 2. Thực hiện hành động tương ứng
     * 3. Chuyển hướng về trang danh sách thành viên
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Lấy thông tin từ request
        String action = request.getParameter("action");          // Lấy hành động (approve/reject)
        int memberId = Integer.parseInt(request.getParameter("memberId")); // Lấy ID thành viên
        MemberDAO dao = new MemberDAO();

        // Bước 2: Xử lý hành động
        if ("approve".equalsIgnoreCase(action)) {
            // Phê duyệt thành viên
            dao.approveMember(memberId);
        } else if ("reject".equalsIgnoreCase(action)) {
            // Từ chối thành viên
            dao.rejectMember(memberId);
        }

        // Bước 3: Chuyển hướng về trang danh sách thành viên
        response.sendRedirect(request.getContextPath() + "/club/members");
    }
}
