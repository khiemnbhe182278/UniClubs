package controller;

import dal.EventDAO;
import model.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý hiển thị danh sách các sự kiện sắp tới cho người dùng
 * URL Pattern: /events
 * Phương thức: GET
 * 
 * Servlet này lấy danh sách các sự kiện sắp diễn ra từ cơ sở dữ liệu
 * và hiển thị chúng cho người dùng xem. Không yêu cầu đăng nhập.
 */
@WebServlet(name = "EventListServlet", urlPatterns = {"/events"})
public class EventListServlet extends HttpServlet {
    
    /**
     * DAO đối tượng để tương tác với bảng Event trong cơ sở dữ liệu.
     * Dùng để lấy danh sách các sự kiện sắp diễn ra.
     */
    private EventDAO eventDAO;
    
    /**
     * Khởi tạo EventDAO khi servlet được tạo.
     * Đây là nơi thiết lập kết nối với cơ sở dữ liệu.
     * 
     * @throws ServletException nếu có lỗi xảy ra trong quá trình khởi tạo
     */
    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
    }
    
    /**
     * Xử lý yêu cầu GET để hiển thị danh sách các sự kiện sắp tới
     * 
     * Phương thức này thực hiện các bước sau:
     * 1. Lấy danh sách các sự kiện sắp diễn ra từ database
     * 2. Đặt danh sách sự kiện vào request attribute
     * 3. Chuyển hướng người dùng đến trang events.jsp để hiển thị
     * 
     * @param request Đối tượng HttpServletRequest chứa yêu cầu từ client
     * @param response Đối tượng HttpServletResponse để gửi phản hồi về client
     * @throws ServletException nếu có lỗi xảy ra trong quá trình xử lý servlet
     * @throws IOException nếu có lỗi xảy ra trong quá trình I/O
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy danh sách các sự kiện sắp diễn ra từ database
        List<Event> events = eventDAO.getUpcomingEvents();
        
        // Đặt danh sách sự kiện vào request attribute để JSP có thể truy cập
        request.setAttribute("events", events);
        
        // Chuyển hướng đến trang JSP để hiển thị danh sách sự kiện
        request.getRequestDispatcher("events.jsp").forward(request, response);
    }
}