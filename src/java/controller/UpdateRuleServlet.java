package controller;

import dal.RuleDAO;
import dal.ClubDAO;
import model.Rule;
import model.User;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UpdateRuleServlet", urlPatterns = {"/leader/update-rule"})
public class UpdateRuleServlet extends HttpServlet {

    /*
     * Servlet này xử lý chức năng "Cập nhật quy định" của một câu lạc bộ.
     * Đường dẫn: /leader/update-rule
     * Dành cho: Leader (người quản lý CLB) gửi form cập nhật một quy định hiện có.
     * 
     * Ghi chú dành cho người không biết code:
     * - "DAO" là viết tắt của Data Access Object: đây là phần mềm giúp đọc/ghi dữ liệu vào cơ sở dữ liệu.
     * - Chúng ta dùng hai DAO: RuleDAO (làm việc với quy định) và ClubDAO (lấy thông tin câu lạc bộ).
     */
    // DAO để thao tác với dữ liệu quy định (create/read/update/delete quy định)
    private RuleDAO ruleDAO;
    // DAO để lấy thông tin câu lạc bộ (dùng để kiểm tra quyền, tồn tại CLB...)
    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        try {
            // Khi servlet bắt đầu chạy, tạo đối tượng DAO để dùng xuyên suốt
            ruleDAO = new RuleDAO();
            clubDAO = new ClubDAO();
        } catch (Exception e) {
            // Nếu không khởi tạo được DAO -> trả lỗi và không chạy tiếp
            throw new ServletException("Không thể khởi tạo kết nối tới cơ sở dữ liệu", e);
        }
    }

    /*
     * Xử lý khi leader gửi form cập nhật quy định.
     * Luồng xử lý (mô tả đơn giản):
     * 1) Kiểm tra người dùng có phiên đăng nhập hay chưa. Nếu chưa -> yêu cầu đăng nhập.
     * 2) Lấy dữ liệu từ form (mã quy định, mã CLB, tiêu đề, nội dung quy định).
     * 3) Kiểm tra dữ liệu hợp lệ (không được để trống tiêu đề/nội dung).
     * 4) Kiểm tra câu lạc bộ có tồn tại (để đảm bảo người cập nhật làm việc trên CLB đúng).
     * 5) Tạo đối tượng Rule mới với dữ liệu đã chỉnh sửa, gọi DAO để cập nhật vào CSDL.
     * 6) Chuyển hướng người dùng kèm thông báo (thành công/không thành công).
     *
     * Giải thích cho người không biết code:
     * - "session" là nơi lưu thông tin đăng nhập; nếu không có -> người dùng chưa đăng nhập.
     * - Nếu dữ liệu không hợp lệ hoặc CLB không tồn tại, người dùng sẽ được chuyển về trang phù hợp kèm thông báo lỗi.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra phiên đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null) {
            // Nếu không có session, chuyển về trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin user đã đăng nhập (nếu có)
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // Nếu không có thông tin user -> yêu cầu đăng nhập
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Bước 2: Lấy dữ liệu từ form gửi lên
            // ruleId: mã quy định cần cập nhật
            // clubId: mã câu lạc bộ sở hữu quy định
            int ruleId = Integer.parseInt(request.getParameter("ruleId"));
            int clubId = Integer.parseInt(request.getParameter("clubId"));
            String title = request.getParameter("title");
            String ruleText = request.getParameter("ruleText");

            // Bước 3: Kiểm tra dữ liệu không được để trống
            if (title == null || title.trim().isEmpty()
                    || ruleText == null || ruleText.trim().isEmpty()) {
                // Nếu thiếu dữ liệu -> chuyển về trang danh sách quy định với lỗi
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=invalid");
                return;
            }

            // Bước 4: Kiểm tra CLB tồn tại
            Club club = clubDAO.getClubById(clubId);
            if (club == null) {
                // Nếu không tìm thấy CLB -> chuyển về dashboard với thông báo
                response.sendRedirect(request.getContextPath()
                        + "/leader/dashboard?error=clubnotfound");
                return;
            }

            // Bước 5: Tạo đối tượng Rule chứa thông tin cập nhật và gọi DAO cập nhật vào CSDL
            Rule rule = new Rule();
            rule.setRuleID(ruleId);                // Gán mã quy định cần cập nhật
            rule.setClubID(clubId);                // Gán mã CLB sở hữu quy định
            rule.setTitle(title.trim());           // Gán tiêu đề mới (bỏ khoảng trắng thừa)
            rule.setRuleText(ruleText.trim());     // Gán nội dung mới (bỏ khoảng trắng thừa)

            // Gọi DAO để cập nhật; hàm trả về true nếu cập nhật thành công
            boolean success = ruleDAO.updateRule(rule);

            // Bước 6: Chuyển hướng người dùng với thông báo kết quả
            if (success) {
                // Nếu cập nhật thành công -> quay về danh sách quy định cùng thông báo
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&success=updated");
            } else {
                // Nếu cập nhật không thành công -> quay lại danh sách kèm lỗi
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=failed");
            }

        } catch (NumberFormatException e) {
            // Nếu ruleId hoặc clubId không phải số hợp lệ
            response.sendRedirect(request.getContextPath()
                    + "/leader/dashboard?error=invalid");
        } catch (Exception e) {
            // Bắt các lỗi không mong muốn, ghi log để kiểm tra
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()
                    + "/leader/dashboard?error=unexpected");
        }
    }

    /*
     * Phương thức này được gọi khi servlet bị dừng hoặc server tắt.
     * Mục đích: giải phóng bộ nhớ và tài nguyên, đặt các tham chiếu về null để GC dọn dẹp.
     * Giải thích cho người không biết code: đây chỉ là bước dọn dẹp, không ảnh hưởng đến dữ liệu trong CSDL.
     */
    @Override
    public void destroy() {
        // Xóa tham chiếu đến DAO để giải phóng bộ nhớ nếu cần
        ruleDAO = null; // Xóa đối tượng quản lý quy định
        clubDAO = null; // Xóa đối tượng quản lý câu lạc bộ
    }
}
