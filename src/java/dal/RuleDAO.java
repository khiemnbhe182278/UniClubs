package dal;

import model.Rule;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RuleDAO extends DBContext {

    // Lấy tất cả rules theo ClubID
    public List<Rule> getRulesByClub(int clubID) {
        List<Rule> list = new ArrayList<>();
        String sql = "SELECT RuleID, ClubID, RuleText, CreatedAt "
                + "FROM Rules WHERE ClubID = ? ORDER BY CreatedAt DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Rule r = new Rule();
                r.setRuleID(rs.getInt("RuleID"));
                r.setClubID(rs.getInt("ClubID"));
                r.setRuleText(rs.getString("RuleText"));
                r.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy rule theo RuleID
    public Rule getRule(int ruleID) {
        String sql = "SELECT RuleID, ClubID, RuleText, CreatedAt "
                + "FROM Rules WHERE RuleID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, ruleID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Rule r = new Rule();
                r.setRuleID(rs.getInt("RuleID"));
                r.setClubID(rs.getInt("ClubID"));
                r.setRuleText(rs.getString("RuleText"));
                r.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm rule mới
    public boolean insertRule(Rule rule) {
        String sql = "INSERT INTO Rules (ClubID, RuleText) VALUES (?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, rule.getClubID());
            st.setString(2, rule.getRuleText());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật rule
    public boolean updateRule(Rule rule) {
        String sql = "UPDATE Rules SET ClubID = ?, RuleText = ? WHERE RuleID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, rule.getClubID());
            st.setString(2, rule.getRuleText());
            st.setInt(3, rule.getRuleID());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy toàn bộ rules kèm tên club
    public List<Rule> getAllRulesWithClubName() {
        List<Rule> list = new ArrayList<>();
        String sql = "SELECT r.RuleID, r.ClubID, c.ClubName, r.RuleText, r.CreatedAt "
                + "FROM Rules r "
                + "JOIN Clubs c ON r.ClubID = c.ClubID "
                + "ORDER BY r.CreatedAt DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Rule r = new Rule();
                r.setRuleID(rs.getInt("RuleID"));
                r.setClubID(rs.getInt("ClubID"));
                r.setRuleText(rs.getString("RuleText"));
                r.setCreatedAt(rs.getTimestamp("CreatedAt"));
                // thêm clubName (cần field mới trong model Rule)
                r.setClubName(rs.getString("ClubName"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    // Lấy danh sách rule của 1 club kèm ClubName
public List<Rule> getRulesByClubWithName(int clubID) {
    List<Rule> list = new ArrayList<>();
    String sql = "SELECT r.RuleID, r.ClubID, c.ClubName, r.Title, r.RuleText, r.CreatedAt "
               + "FROM Rules r "
               + "JOIN Clubs c ON r.ClubID = c.ClubID "
               + "WHERE r.ClubID = ? "
               + "ORDER BY r.CreatedAt DESC";
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setInt(1, clubID);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Rule r = new Rule();
            r.setRuleID(rs.getInt("RuleID"));
            r.setClubID(rs.getInt("ClubID"));
            r.setClubName(rs.getString("ClubName"));
            r.setTitle(rs.getString("Title"));
            r.setRuleText(rs.getString("RuleText"));
            r.setCreatedAt(rs.getTimestamp("CreatedAt"));
            list.add(r);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

    // Lấy toàn bộ rules (không phân biệt ClubID)
    public List<Rule> getAllRules() {
        List<Rule> list = new ArrayList<>();
        String sql = "SELECT RuleID, ClubID, RuleText, CreatedAt "
                + "FROM Rules ORDER BY CreatedAt DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Rule r = new Rule();
                r.setRuleID(rs.getInt("RuleID"));
                r.setClubID(rs.getInt("ClubID"));
                r.setRuleText(rs.getString("RuleText"));
                r.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Xóa rule
    public boolean deleteRule(int ruleID) {
        String sql = "DELETE FROM Rules WHERE RuleID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, ruleID);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
