package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Rule;

/**
 * RuleDAO - Người Quản Lý Nội Quy và Quy Định
 * =======================================
 * 
 * 1. Vai Trò Chính
 *    - Như "ban pháp chế" của tổ chức:
 *      + Quản lý nội quy, quy định
 *      + Đảm bảo tuân thủ quy tắc
 *      + Cập nhật và duy trì quy định
 * 
 * 2. Các Chức Năng Chính
 *    a. Quản Lý Quy Định:
 *       - Thêm quy định mới
 *       - Cập nhật quy định cũ
 *       - Xóa quy định không còn phù hợp
 * 
 *    b. Kiểm Soát Nội Quy:
 *       - Phân loại theo CLB
 *       - Kiểm tra tính hợp lệ
 *       - Đảm bảo tính nhất quán
 * 
 *    c. Hỗ Trợ Tra Cứu:
 *       - Tìm kiếm quy định
 *       - Xem lịch sử thay đổi
 *       - Thống kê áp dụng
 * 
 * 3. Cách Hoạt Động
 *    - Như "sổ tay nội quy điện tử":
 *      + Lưu trữ có hệ thống
 *      + Dễ dàng cập nhật
 *      + Tra cứu nhanh chóng
 * 
 * 4. Ví Dụ Thực Tế
 *    - Giống văn phòng luật sư:
 *      + Soạn thảo quy định
 *      + Kiểm tra tính pháp lý
 *      + Lưu trữ và quản lý
 * 
 * 5. Tầm Quan Trọng
 *    - Như "nền tảng kỷ luật":
 *      + Đảm bảo trật tự hoạt động
 *      + Tạo môi trường công bằng
 *      + Hướng dẫn hành vi chuẩn mực
 */
public class RuleDAO extends DBContext {

    /**
     * Tạo một quy định mới cho câu lạc bộ.
     *
     * Mô tả (dành cho người không biết code):
     * - Hàm này nhận một đối tượng `Rule` chứa thông tin quy định (mã CLB, tiêu đề, nội dung)
     *   và lưu nó vào cơ sở dữ liệu.
     *
     * Tham số:
     * - rule: đối tượng Rule đã được điền các trường cần thiết (clubId, title, ruleText).
     *
     * Giá trị trả về:
     * - true: nếu thao tác ghi vào CSDL thành công (đã thêm 1 dòng)
     * - false: nếu có lỗi trong quá trình thêm (ví dụ lỗi kết nối hoặc ràng buộc dữ liệu)
     *
     * Ví dụ ngắn:
     * Rule r = new Rule(); r.setClubID(3); r.setTitle("Nội quy"); r.setRuleText("...");
     * createRule(r) -> true nếu thêm thành công.
     */
    public boolean createRule(Rule rule) {
        String sql = "INSERT INTO Rules (ClubID, Title, RuleText) VALUES (?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, rule.getClubID());
            ps.setString(2, rule.getTitle());
            ps.setString(3, rule.getRuleText());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error creating rule: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy một quy định theo mã (RuleID).
     *
     * Mô tả:
     * - Trả về một đối tượng Rule nếu tìm thấy theo ruleId.
     * - Trả về null nếu không tìm thấy hoặc có lỗi.
     *
     * Tham số:
     * - ruleId: mã quy định (số nguyên)
     *
     * Giá trị trả về:
     * - Rule object: khi tìm thấy
     * - null: khi không tìm thấy hoặc gặp lỗi
     */
    public Rule getRuleById(int ruleId) {
        String sql = "SELECT * FROM Rules WHERE RuleID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, ruleId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractRuleFromResultSet(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error getting rule by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Lấy tất cả quy định thuộc về một câu lạc bộ.
     *
     * Mô tả:
     * - Trả về danh sách (List) các Rule cho clubId được cho.
     * - Nếu không có quy định nào sẽ trả về danh sách rỗng.
     *
     * Tham số:
     * - clubId: mã câu lạc bộ
     *
     * Giá trị trả về:
     * - List<Rule>: danh sách quy định (có thể rỗng)
     */
    public List<Rule> getRulesByClubId(int clubId) {
        List<Rule> rules = new ArrayList<>();
        String sql = "SELECT * FROM Rules WHERE ClubID = ? ORDER BY RuleID";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                rules.add(extractRuleFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting rules by club ID: " + e.getMessage());
            e.printStackTrace();
        }

        return rules;
    }

    /**
     * Cập nhật một quy định đã tồn tại.
     *
     * Mô tả:
     * - Dựa theo rule.getRuleID() để xác định bản ghi cần cập nhật.
     * - Cập nhật các trường Title và RuleText.
     *
     * Tham số:
     * - rule: đối tượng Rule chứa ruleID và các giá trị mới cho title, ruleText.
     *
     * Giá trị trả về:
     * - true: nếu cập nhật thành công (>=1 hàng bị ảnh hưởng)
     * - false: nếu không thành công hoặc có lỗi
     */
    public boolean updateRule(Rule rule) {
        String sql = "UPDATE Rules SET Title = ?, RuleText = ? WHERE RuleID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, rule.getTitle());
            ps.setString(2, rule.getRuleText());
            ps.setInt(3, rule.getRuleID());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating rule: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa một quy định theo mã.
     *
     * Mô tả:
     * - Thực hiện xóa bản ghi trong bảng Rules theo ruleId.
     * - Trước khi gọi hàm này, phía caller nên đảm bảo quyền (rule thuộc CLB của user).
     *
     * Tham số:
     * - ruleId: mã của quy định cần xóa
     *
     * Giá trị trả về:
     * - true: nếu xóa thành công
     * - false: nếu có lỗi
     */
    public boolean deleteRule(int ruleId) {
        String sql = "DELETE FROM Rules WHERE RuleID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, ruleId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting rule: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa toàn bộ quy định của một câu lạc bộ.
     *
     * Mô tả:
     * - Hành động này sẽ xóa mọi bản ghi Rules có ClubID = clubId.
     * - Thận trọng: đây là thao tác mạnh, thường dùng khi xoá CLB hoặc reset dữ liệu.
     *
     * Tham số:
     * - clubId: mã câu lạc bộ
     *
     * Giá trị trả về:
     * - true: nếu thao tác thực thi thành công
     * - false: nếu có lỗi xảy ra
     */
    public boolean deleteRulesByClubId(int clubId) {
        String sql = "DELETE FROM Rules WHERE ClubID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error deleting rules by club ID: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Đếm số lượng quy định thuộc về một câu lạc bộ.
     *
     * Tham số:
     * - clubId: mã câu lạc bộ
     *
     * Giá trị trả về:
     * - Số nguyên >=0: số lượng quy định
     */
    public int countRulesByClubId(int clubId) {
        String sql = "SELECT COUNT(*) FROM Rules WHERE ClubID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error counting rules: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Chuyển một hàng (row) trong ResultSet thành đối tượng Rule.
     *
     * Giải thích:
     * - Khi chạy truy vấn SELECT, ResultSet chứa nhiều hàng. Hàm này lấy dữ liệu ở hàng hiện tại
     *   và gán vào một đối tượng Rule để sử dụng dễ dàng trong Java.
     *
     * Tham số:
     * - rs: ResultSet đang trỏ tới hàng cần chuyển
     *
     * Trả về:
     * - Rule: đối tượng chứa dữ liệu được lấy từ ResultSet
     */
    private Rule extractRuleFromResultSet(ResultSet rs) throws SQLException {
        Rule rule = new Rule();
        rule.setRuleID(rs.getInt("RuleID"));
        rule.setClubID(rs.getInt("ClubID"));
        rule.setTitle(rs.getString("Title"));
        rule.setRuleText(rs.getString("RuleText"));

        // If you have CreatedDate column
        try {
            rule.setCreatedDate(rs.getTimestamp("CreatedDate"));
        } catch (SQLException e) {
            // Column might not exist
        }

        return rule;
    }

}
