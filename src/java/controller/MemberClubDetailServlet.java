package controller;

/**
 * MemberClubDetailServlet: Servlet xử lý hiển thị chi tiết câu lạc bộ cho thành viên
 * - Hiển thị thông tin chi tiết CLB
 * - Hiển thị tin tức, sự kiện, quy tắc của CLB
 * - Quản lý trạng thái thành viên
 */

// Import các lớp DAO để truy cập dữ liệu
import dal.ClubDAO;     // Truy cập dữ liệu CLB
import dal.NewsDAO;     // Truy cập dữ liệu tin tức
import dal.RuleDAO;     // Truy cập dữ liệu quy tắc
import dal.EventDAO;    // Truy cập dữ liệu sự kiện
import dal.MemberDAO;   // Truy cập dữ liệu thành viên

// Import các model
import model.Club;      // Model CLB
import model.News;      // Model tin tức
import model.Rule;      // Model quy tắc
import model.Event;     // Model sự kiện
import model.User;      // Model người dùng

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet hiển thị chi tiết CLB cho thành viên
 * URL pattern: /member-club-detail
 * 
 * Chức năng chính:
 * 1. Hiển thị thông tin chi tiết của CLB
 * 2. Hiển thị danh sách tin tức của CLB
 * 3. Hiển thị danh sách sự kiện sắp tới
 * 4. Hiển thị quy tắc của CLB
 * 5. Kiểm tra trạng thái thành viên của người dùng
 */
@WebServlet(name = "MemberClubDetailServlet", urlPatterns = {"/member-club-detail"})
public class MemberClubDetailServlet extends HttpServlet {
    
    // Khai báo các đối tượng DAO để truy cập dữ liệu
    private ClubDAO clubDAO;      // Xử lý dữ liệu CLB
    private NewsDAO newsDAO;      // Xử lý dữ liệu tin tức
    private RuleDAO ruleDAO;      // Xử lý dữ liệu quy tắc
    private EventDAO eventDAO;    // Xử lý dữ liệu sự kiện
    private MemberDAO memberDAO;  // Xử lý dữ liệu thành viên
    
    /**
     * Khởi tạo Servlet
     * Khởi tạo tất cả các đối tượng DAO cần thiết
     */
    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();      // Khởi tạo DAO CLB
        newsDAO = new NewsDAO();       // Khởi tạo DAO tin tức
        ruleDAO = new RuleDAO();       // Khởi tạo DAO quy tắc
        eventDAO = new EventDAO();     // Khởi tạo DAO sự kiện
        memberDAO = new MemberDAO();   // Khởi tạo DAO thành viên
    }
    
    /**
     * Xử lý request GET - Hiển thị chi tiết CLB
     * Các bước xử lý:
     * 1. Kiểm tra người dùng đăng nhập (không bắt buộc)
     * 2. Lấy và xác thực thông tin CLB
     * 3. Lấy các thông tin liên quan (tin tức, sự kiện, quy tắc)
     * 4. Kiểm tra trạng thái thành viên của người dùng
     * 5. Chuyển dữ liệu tới JSP để hiển thị
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Bước 1: Kiểm tra session và lấy thông tin người dùng
        HttpSession session = request.getSession(false);
        
        // Không bắt buộc đăng nhập để xem, nhưng cần để tham gia CLB
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        
        try {
            // Bước 2.1: Lấy và kiểm tra ID của CLB
            String clubIdParam = request.getParameter("id");
            if (clubIdParam == null || clubIdParam.trim().isEmpty()) {
                // Nếu không có ID CLB, chuyển về trang dashboard với thông báo lỗi
                response.sendRedirect(request.getContextPath() + "/dashboard?error=noclubid");
                return;
            }
            
            // Bước 2.2: Chuyển đổi ID từ String sang Integer
            int clubId = Integer.parseInt(clubIdParam);
            
            // Bước 2.3: Lấy thông tin chi tiết CLB
            Club club = clubDAO.getClubById(clubId);
            if (club == null) {
                // Nếu không tìm thấy CLB, chuyển về dashboard với thông báo lỗi
                response.sendRedirect(request.getContextPath() + "/dashboard?error=clubnotfound");
                return;
            }
            
            // Bước 3: Lấy các thông tin liên quan của CLB
            // 3.1: Lấy thông tin người lãnh đạo CLB
            User leader = clubDAO.getClubLeader(clubId);
            
            // 3.2: Lấy thông tin giảng viên phụ trách
            User faculty = clubDAO.getClubFaculty(clubId);
            
            // 3.3: Lấy danh sách tin tức đã được công bố
            List<News> newsList = newsDAO.getPublishedNewsByClubId(clubId);
            
            // 3.4: Lấy danh sách quy tắc của CLB
            List<Rule> rules = ruleDAO.getRulesByClubId(clubId);
            
            // 3.5: Lấy danh sách sự kiện sắp diễn ra
            List<Event> events = eventDAO.getUpcomingEventsByClubId(clubId);
            
            // 3.6: Lấy số lượng thành viên
            int memberCount = memberDAO.getMemberCountByClubId(clubId);
            
            // Bước 4: Kiểm tra trạng thái thành viên của người dùng hiện tại
            boolean isMember = false;
            boolean isPendingMember = false;
            if (user != null) {
                // Kiểm tra xem người dùng đã là thành viên chưa
                isMember = memberDAO.checkMember(clubId, user.getUserID());
                // Kiểm tra xem người dùng có đang chờ duyệt không
                isPendingMember = memberDAO.isPendingMember(clubId, user.getUserID());
            }
            
            // Bước 5: Đặt các thuộc tính để truyền cho JSP
            request.setAttribute("club", club);           // Thông tin CLB
            request.setAttribute("leader", leader);       // Thông tin người lãnh đạo
            request.setAttribute("faculty", faculty);     // Thông tin giảng viên
            request.setAttribute("newsList", newsList);   // Danh sách tin tức
            request.setAttribute("rules", rules);         // Danh sách quy tắc
            request.setAttribute("events", events);       // Danh sách sự kiện
            request.setAttribute("memberCount", memberCount); // Số lượng thành viên
            request.setAttribute("isMember", isMember);   // Trạng thái thành viên
            request.setAttribute("isPendingMember", isPendingMember); // Trạng thái chờ duyệt
            
            // Chuyển hướng tới trang JSP để hiển thị
            request.getRequestDispatcher("member-club-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi ID CLB không phải là số
            e.printStackTrace();
            request.setAttribute("error", "ID câu lạc bộ không hợp lệ");
            request.getRequestDispatcher("member-club-detail.jsp").forward(request, response);
        } catch (Exception e) {
            // Xử lý các lỗi không xác định khác
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi xử lý yêu cầu");
            request.getRequestDispatcher("member-club-detail.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý request POST
     * Trong trường hợp này, chuyển tiếp tới phương thức GET
     * vì trang chi tiết CLB chỉ cần hiển thị thông tin
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}