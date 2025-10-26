package dal;

import model.Rule;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RuleDAO extends DBContext {

    public List<Rule> getRulesByClub(int clubID) {
        List<Rule> list = new ArrayList<>();
        String sql = "SELECT RuleID, ClubID, Title, RuleText, CreatedAt "
                + "FROM Rules WHERE ClubID = ? ORDER BY CreatedAt DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Rule r = new Rule();
                r.setRuleID(rs.getInt("RuleID"));
                r.setClubID(rs.getInt("ClubID"));
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

    public Rule getRule(int ruleID) {
        String sql = "SELECT RuleID, ClubID, RuleText, CreatedAt, Title "
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
                r.setTitle(rs.getString("Title")); 
                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm rule mới
    public boolean insertRule(Rule rule) {
        String sql = "INSERT INTO Rules (ClubID, RuleText, Title) VALUES (?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, rule.getClubID());
            st.setString(2, rule.getRuleText());
            st.setString(3, rule.getTitle());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật rule
    public boolean updateRule(Rule rule) {
        String sql = "UPDATE Rules SET ClubID = ?, RuleText = ?, Title = ? WHERE RuleID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, rule.getClubID());
            st.setString(2, rule.getRuleText());
            st.setString(3, rule.getTitle());  // Title cuối
            st.setInt(4, rule.getRuleID());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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
