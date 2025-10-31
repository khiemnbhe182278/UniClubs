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
     * Create a new rule
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
     * Get rule by ID
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
     * Get all rules for a club
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
     * Update an existing rule
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
     * Delete a rule
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
     * Delete all rules for a club
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
     * Count rules for a club
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
     * Extract Rule object from ResultSet
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
