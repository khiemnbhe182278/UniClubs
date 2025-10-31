package controller;

import dal.EventDAO;
import model.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet xử lý việc hiển thị chi tiết của một sự kiện.
 * URL Pattern: /event-detail
 * Phương thức: GET
 * 
 * Servlet này cho phép người dùng xem thông tin chi tiết của một sự kiện cụ thể
 * dựa trên ID của sự kiện được truyền vào qua parameter.
 */
@WebServlet(name = "EventDetailServlet", urlPatterns = {"/event-detail"})
public class EventDetailServlet extends HttpServlet {
    
    /**
     * DAO đối tượng để tương tác với bảng Event trong cơ sở dữ liệu
     */
    private EventDAO eventDAO;
    
    /**
     * Khởi tạo EventDAO khi servlet được tạo
     * @throws ServletException nếu có lỗi xảy ra trong quá trình khởi tạo
     */
    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
    }
    
    /**
     * Xử lý yêu cầu GET để hiển thị chi tiết của một sự kiện
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy ID sự kiện từ parameter và chuyển đổi sang kiểu int
            int eventId = Integer.parseInt(request.getParameter("id"));
            // Truy vấn thông tin sự kiện từ database
            Event event = eventDAO.getEventById(eventId);
            
            if (event != null) {
                // Nếu tìm thấy sự kiện, đặt nó vào request attribute và chuyển đến trang JSP
                request.setAttribute("event", event);
                request.getRequestDispatcher("event-detail.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy sự kiện, trả về lỗi 404
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
            }
        } catch (NumberFormatException e) {
            // Nếu ID không phải là số hợp lệ, trả về lỗi 400
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID");
        }
    }
}