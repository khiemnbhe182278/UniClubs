package controller;

import dal.EventDAO;
import dal.ClubDAO;
import dal.MemberDAO;
import dal.UserDAO;
import model.Event;
import model.Club;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Servlet Tạo Sự Kiện - Quy Trình Xử Lý
 * =====================================
 * 
 * 1. Các DAO được sử dụng
 *    - EventDAO: Xử lý thông tin sự kiện
 *    - ClubDAO: Kiểm tra thông tin câu lạc bộ
 *    - MemberDAO: Quản lý thành viên tham gia
 *    - UserDAO: Xác thực người tạo sự kiện
 * 
 * 2. Quy trình như một kế hoạch tổ chức sự kiện:
 *    - Người tổ chức (User) đề xuất sự kiện
 *    - Ban quản lý (Servlet) kiểm tra:
 *      + Người tổ chức có quyền không?
 *      + Thông tin sự kiện hợp lệ không?
 *      + Thời gian, địa điểm có phù hợp không?
 *    - Thủ kho (DAO) thực hiện:
 *      + Lưu thông tin sự kiện mới
 *      + Cập nhật lịch của câu lạc bộ
 *      + Gửi thông báo cho thành viên
 * 
 * 3. Ví dụ thực tế:
 *    - Giống như tổ chức một bữa tiệc:
 *      + Người tổ chức (User) đề xuất ý tưởng
 *      + Quản lý nhà hàng (Servlet) xem xét khả thi
 *      + Đầu bếp và nhân viên (DAO) chuẩn bị thực hiện
 */
import java.util.Date;

@WebServlet(name = "CreateEventServlet", urlPatterns = {"/create-event"})
public class CreateEventServlet extends HttpServlet {

    /*
     * CreateEventServlet
     * (Tiếng Việt)
     * Mục đích: Cho phép người dùng có quyền (Leader/Faculty/Manager...) tạo sự kiện cho một CLB.
     * - Input:
     *   + GET: hiển thị form tạo sự kiện, yêu cầu user đã đăng nhập; truyền `myClubs` để chọn CLB.
     *   + POST: form fields - "clubId", "eventName", "description", "eventDate", "eventTime".
     * - Xử lý:
     *   + Kiểm tra session (phải đăng nhập).
     *   + Validate các trường bắt buộc.
     *   + Parse chuỗi ngày/giờ thành Timestamp.
     *   + Tạo Event với trạng thái "Pending" và gọi EventDAO.createEvent(event) để lưu.
     * - Output: Trả về thông báo thành công (chờ admin duyệt) hoặc lỗi (Invalid input / tạo thất bại).
     * - Lỗi: Bắt và xử lý NumberFormatException/ParseException, trả về thông báo lỗi và hiển thị lại form.
     *
     * Ghi chú:
     * - Date/time format expected: yyyy-MM-dd and HH:mm (kết hợp trước khi parse).
     * - Quyền tạo sự kiện có thể phụ thuộc vào role; ở đây controller dựa vào danh sách CLB trả về từ DAO.
     */

    /**
     * DAO đối tượng để tương tác với bảng Event trong cơ sở dữ liệu.
     * Dùng để tạo mới và quản lý các sự kiện.
     */
    private EventDAO eventDAO;

    /**
     * DAO đối tượng để tương tác với bảng Club trong cơ sở dữ liệu.
     * Dùng để kiểm tra thông tin và quyền của câu lạc bộ.
     */
    private ClubDAO clubDAO;

    /**
     * DAO đối tượng để tương tác với bảng Member trong cơ sở dữ liệu.
     * Dùng để kiểm tra tư cách thành viên của người tạo sự kiện.
     */
    private MemberDAO memberDAO;

    /**
     * DAO đối tượng để tương tác với bảng User trong cơ sở dữ liệu.
     * Dùng để xác thực và kiểm tra quyền của người dùng.
     */
    private UserDAO userDAO;

    /**
     * Khởi tạo các DAO khi servlet được tạo.
     * Thiết lập kết nối với các bảng dữ liệu cần thiết.
     * 
     * @throws ServletException nếu có lỗi xảy ra trong quá trình khởi tạo
     */
    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        clubDAO = new ClubDAO();
        memberDAO = new MemberDAO();
        userDAO = new UserDAO();
    }

    /**
     * Xử lý yêu cầu GET để hiển thị form tạo sự kiện
     * 
     * Quy trình xử lý:
     * 1. Kiểm tra đăng nhập của người dùng
     * 2. Lấy danh sách câu lạc bộ mà người dùng là leader
     * 3. Xác định câu lạc bộ chính của người dùng (nếu là Leader hoặc Faculty)
     * 4. Hiển thị form tạo sự kiện
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Bước 2: Lấy danh sách câu lạc bộ của người dùng
        List<Club> myClubs = clubDAO.getUserLeadClubs(user.getUserID());
        request.setAttribute("myClubs", myClubs);

        // Bước 3: Xác định câu lạc bộ chính của người dùng dựa vào vai trò
        if (user.getRoleID() == 2) { // Nếu là Leader
            Integer clubId = userDAO.getLeaderPrimaryClubId(user.getUserID());
            request.setAttribute("userClubId", clubId);
        } else if (user.getRoleID() == 3) { // Nếu là Faculty
            Integer clubId = userDAO.getFacultyPrimaryClubId(user.getUserID());
            request.setAttribute("userClubId", clubId);
        }

        // Bước 4: Chuyển hướng đến trang JSP để hiển thị form
        request.getRequestDispatcher("create-event.jsp").forward(request, response);
    }

    /**
     * Xử lý yêu cầu POST để tạo sự kiện mới
     * 
     * Quy trình xử lý:
     * 1. Kiểm tra đăng nhập và session
     * 2. Thu thập thông tin sự kiện từ form
     * 3. Kiểm tra tính hợp lệ của dữ liệu
     * 4. Chuyển đổi định dạng ngày giờ
     * 5. Tạo và lưu sự kiện mới
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra đăng nhập và session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            int clubId = Integer.parseInt(request.getParameter("clubId"));
            String eventName = request.getParameter("eventName");
            String description = request.getParameter("description");
            String eventDateStr = request.getParameter("eventDate");
            String eventTimeStr = request.getParameter("eventTime");

            // Validation
            if (eventName == null || eventName.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || eventDateStr == null || eventDateStr.trim().isEmpty()
                    || eventTimeStr == null || eventTimeStr.trim().isEmpty()) {
                request.setAttribute("error", "All fields are required");
                doGet(request, response);
                return;
            }





            // Parse date and time
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String dateTimeStr = eventDateStr + " " + eventTimeStr;
            Date eventDate = sdf.parse(dateTimeStr);
            Timestamp eventTimestamp = new Timestamp(eventDate.getTime());

            Event event = new Event();
            event.setClubID(clubId);
            event.setEventName(eventName.trim());
            event.setDescription(description.trim());
            event.setEventDate(eventTimestamp);
            event.setStatus("Pending");

            boolean success = eventDAO.createEvent(event);

            if (success) {
                request.setAttribute("success", "Event created successfully! Waiting for admin approval.");
            } else {
                request.setAttribute("error", "Failed to create event. Please try again.");
            }

            doGet(request, response);

        } catch (NumberFormatException e) {
            // Xử lý lỗi khi clubId không phải là số
            request.setAttribute("error", "ID câu lạc bộ không hợp lệ");
            doGet(request, response);
        } catch (ParseException e) {
            // Xử lý lỗi khi không thể chuyển đổi định dạng ngày giờ
            request.setAttribute("error", "Định dạng ngày giờ không hợp lệ");
            doGet(request, response);
        }
    }
}
