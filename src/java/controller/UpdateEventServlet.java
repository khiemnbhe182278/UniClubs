package controller;

import dal.EventDAO;
import dal.ClubDAO;
import model.Event;
import model.User;
import model.Club;
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
import java.util.Date;

@WebServlet(name = "UpdateEventServlet", urlPatterns = {"/leader/update-event"})
public class UpdateEventServlet extends HttpServlet {

    /*
     * UpdateEventServlet
     * Mục đích: Hiển thị form chỉnh sửa sự kiện (GET) và xử lý lưu sự kiện sau khi chỉnh sửa (POST)
     * Đường dẫn: /leader/update-event
     * Dành cho: Leader (người quản lý CLB) muốn cập nhật thông tin một sự kiện đã tạo.
     *
     * Giải thích đơn giản cho người không biết code:
     * - Có hai phần chính: hiển thị form (khi người dùng muốn chỉnh sửa) và xử lý dữ liệu gửi lên (khi người dùng nhấn Lưu).
     * - "DAO" (Data Access Object) là phần xử lý đọc/ghi dữ liệu vào cơ sở dữ liệu; ở đây dùng EventDAO và ClubDAO.
     */
    // DAO để thao tác với bảng sự kiện
    private EventDAO eventDAO;
    // DAO để lấy thông tin câu lạc bộ (ví dụ: kiểm tra quyền sở hữu sự kiện)
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        // Khởi tạo các DAO khi servlet được nạp lần đầu
        eventDAO = new EventDAO();
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Mô tả ngắn: Hiển thị form sửa sự kiện

        // Bước 1: kiểm tra đăng nhập (session)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Nếu chưa đăng nhập, chuyển tới trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin user (ở đây chủ yếu để kiểm tra quyền nếu cần mở rộng)
        User user = (User) session.getAttribute("user");

        // Bước 2: lấy 'eventId' từ tham số. Hỗ trợ cả 'eventId' và 'id' (tùy nguồn yêu cầu)
        String eventIdStr = request.getParameter("eventId");
        if (eventIdStr == null) {
            eventIdStr = request.getParameter("id");
        }

        // Kiểm tra tham số eventId có hợp lệ không
        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            // Nếu thiếu tham số -> trả lỗi 400 (Bad Request)
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing event id parameter");
            return;
        }

        int eventId;
        try {
            eventId = Integer.parseInt(eventIdStr.trim());
        } catch (NumberFormatException ex) {
            // Nếu không phải số -> trả lỗi 400
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event id parameter");
            return;
        }

        // Bước 3: lấy thông tin sự kiện từ CSDL
        Event event = eventDAO.getEventById(eventId);
        if (event == null) {
            // Nếu không tìm thấy sự kiện -> trả lỗi 404 (Not Found)
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Bước 4: chuyển đối tượng event sang JSP để hiển thị form chỉnh sửa
        request.setAttribute("event", event);
        request.getRequestDispatcher("/leader-update-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Bước 1: kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("user");

        try {
            // Bước 2: thu thập dữ liệu từ form
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String eventName = request.getParameter("eventName");
            String description = request.getParameter("description");
            String eventDateStr = request.getParameter("eventDate");
            String eventTimeStr = request.getParameter("eventTime");
            String location = request.getParameter("location");
            String maxParticipantsStr = request.getParameter("maxParticipants");

            // Bước 3: kiểm tra dữ liệu bắt buộc
            if (eventName == null || eventName.trim().isEmpty()
                    || description == null || description.trim().isEmpty()) {
                // Nếu thiếu trường bắt buộc -> đặt thông báo lỗi và hiển thị lại form
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin cần thiết");
                doGet(request, response);
                return;
            }

            // Bước 4: chuyển chuỗi ngày giờ thành Timestamp
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String dateTimeStr = eventDateStr + " " + eventTimeStr;
            Date eventDate = sdf.parse(dateTimeStr);
            Timestamp eventTimestamp = new Timestamp(eventDate.getTime());

            // Bước 5: lấy event hiện tại từ CSDL, cập nhật các trường với giá trị mới
            Event event = eventDAO.getEventById(eventId);
            event.setEventName(eventName.trim());
            event.setDescription(description.trim());
            event.setEventDate(eventTimestamp);
            event.setLocation(location);

            // Nếu người dùng nhập giới hạn số lượng, cập nhật
            if (maxParticipantsStr != null && !maxParticipantsStr.isEmpty()) {
                event.setMaxParticipants(Integer.parseInt(maxParticipantsStr));
            }

            // Bước 6: gọi DAO để lưu thay đổi
            boolean success = eventDAO.updateEvent(event);

            // Bước 7: chuyển hướng hoặc hiển thị lỗi tùy kết quả
            if (success) {
                response.sendRedirect(request.getContextPath() + "/leader/dashboard?success=event_updated");
            } else {
                request.setAttribute("error", "Cập nhật sự kiện thất bại");
                doGet(request, response);
            }

        } catch (NumberFormatException | ParseException e) {
            // Nếu có lỗi chuyển đổi số hoặc phân tích ngày giờ -> hiển thị lỗi cho người dùng
            request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ");
            doGet(request, response);
        }
    }
}
