package controller;

import dal.RuleDAO;
import dal.ClubDAO;
import model.User;
import model.Club;
import model.Rule;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DeleteRuleServlet", urlPatterns = {"/leader/delete-rule"})
public class DeleteRuleServlet extends HttpServlet {

    /*
     * DeleteRuleServlet
     * Mục đích: Xóa một quy định (rule) thuộc về một câu lạc bộ do leader quản lý.
     * Đường dẫn: /leader/delete-rule
     *
     * Giải thích đơn giản cho người không biết code:
     * - Khi leader muốn xóa một quy định, trang web sẽ gửi yêu cầu (request) tới đường dẫn này.
     * - Servlet sẽ kiểm tra leader đã đăng nhập hay chưa, kiểm tra mã quy định và mã CLB,
     *   kiểm tra quyền (quy định đó có thuộc CLB hay không), rồi gọi chức năng xóa trong cơ sở dữ liệu.
     * - Cuối cùng servlet chuyển hướng (redirect) người dùng về trang danh sách quy định với thông báo kết quả.
     */
    // DAO: đối tượng giúp truy xuất dữ liệu từ cơ sở dữ liệu
    private RuleDAO ruleDAO; // thao tác với bảng quy định
    private ClubDAO clubDAO; // thao tác với bảng câu lạc bộ

    @Override
    public void init() throws ServletException {
        try {
            // Khởi tạo các DAO khi servlet được tải lần đầu
            ruleDAO = new RuleDAO();
            clubDAO = new ClubDAO();
        } catch (Exception e) {
            // Nếu không thể khởi tạo DAO -> ném ServletException để báo lỗi khởi động
            throw new ServletException("Không thể khởi tạo kết nối tới cơ sở dữ liệu", e);
        }
    }

    /*
     * Xử lý yêu cầu xóa quy định (POST)
     * Bước xử lý (mô tả đơn giản):
     * 1) Kiểm tra leader đã đăng nhập chưa (dựa vào session). Nếu chưa -> yêu cầu đăng nhập.
     * 2) Lấy mã quy định (ruleId) và mã CLB (clubId) từ form gửi lên.
     * 3) Kiểm tra CLB có tồn tại không (để đảm bảo thao tác hợp lệ).
     * 4) Lấy thông tin quy định theo ruleId và chắc chắn quy định đó thuộc về CLB (kiểm tra quyền).
     * 5) Gọi DAO để xóa quy định khỏi cơ sở dữ liệu.
     * 6) Chuyển hướng người dùng về trang danh sách kèm thông báo thành công hoặc thất bại.
     *
     * Lưu ý an toàn (để người không biết code hiểu):
     * - Không nên cho phép xóa chỉ dựa trên ID truyền lên từ client mà không kiểm tra quyền và sự tồn tại.
     * - Việc kiểm tra 'rule.getClubID() != clubId' đảm bảo người dùng không thể xóa quy định của CLB khác.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra session (đăng nhập)
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Bước 2: Lấy thông tin từ form
            int ruleId = Integer.parseInt(request.getParameter("ruleId"));
            int clubId = Integer.parseInt(request.getParameter("clubId"));

            // Bước 3: Kiểm tra CLB tồn tại
            Club club = clubDAO.getClubById(clubId);
            if (club == null) {
                // Nếu không có CLB -> quay về dashboard với thông báo lỗi
                response.sendRedirect(request.getContextPath()
                        + "/leader/dashboard?error=clubnotfound");
                return;
            }

            // Bước 4: Lấy quy định và kiểm tra quyền sở hữu
            Rule rule = ruleDAO.getRuleById(ruleId);
            if (rule == null || rule.getClubID() != clubId) {
                // Nếu không tìm thấy quy định hoặc quy định không thuộc CLB -> báo lỗi
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=notfound");
                return;
            }

            // Bước 5: Xóa quy định
            boolean success = ruleDAO.deleteRule(ruleId);

            // Bước 6: Chuyển hướng kèm thông báo
            if (success) {
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&success=deleted");
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/leader/rules?clubId=" + clubId + "&error=failed");
            }

        } catch (NumberFormatException e) {
            // Nếu ruleId hoặc clubId không hợp lệ (không phải số)
            response.sendRedirect(request.getContextPath()
                    + "/leader/dashboard?error=invalid");
        } catch (Exception e) {
            // Bắt các lỗi bất ngờ và ghi log để kiểm tra
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()
                    + "/leader/dashboard?error=unexpected");
        }
    }

    /*
     * Dọn dẹp khi servlet bị dừng: đặt các tham chiếu DAO về null để giải phóng bộ nhớ.
     * (Giải thích: đây chỉ là dọn dẹp trong bộ nhớ của ứng dụng; dữ liệu thật vẫn nằm trong CSDL.)
     */
    @Override
    public void destroy() {
        ruleDAO = null;
        clubDAO = null;
    }
}
