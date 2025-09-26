package dal;

import model.UserDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    // Lấy danh sách user với phân trang, search, filter
    public List<UserDTO> getUsers(int page, int pageSize, String search, String roleFilter) {
        List<UserDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT u.UserID, u.UserName, u.Email, u.Status, r.RoleName, "
                + "clb_lead.ClubName AS ManagedClub, "
                + "STRING_AGG(clb_mem.ClubName, ', ') AS JoinedClubs "
                + "FROM Users u "
                + "INNER JOIN Roles r ON u.RoleID = r.RoleID "
                + "LEFT JOIN Clubs clb_lead ON (u.UserID = clb_lead.LeaderID OR u.UserID = clb_lead.FacultyID) "
                + "LEFT JOIN Members m ON u.UserID = m.UserID "
                + "LEFT JOIN Clubs clb_mem ON m.ClubID = clb_mem.ClubID "
                + "WHERE 1=1 "
        );

        if (search != null && !search.isEmpty()) {
            sql.append(" AND (u.UserName LIKE ? OR u.Email LIKE ?)");
        }
        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND r.RoleName = ?");
        }

        sql.append(" GROUP BY u.UserID, u.UserName, u.Email, u.Status, r.RoleName, clb_lead.ClubName ");
        sql.append(" ORDER BY u.UserName ");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            if (search != null && !search.isEmpty()) {
                ps.setString(idx++, "%" + search + "%");
                ps.setString(idx++, "%" + search + "%");
            }
            if (roleFilter != null && !roleFilter.isEmpty()) {
                ps.setString(idx++, roleFilter);
            }
            ps.setInt(idx++, (page - 1) * pageSize);
            ps.setInt(idx, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO u = new UserDTO();
                u.setUserID(rs.getInt("UserID"));
                u.setUserName(rs.getString("UserName"));
                u.setEmail(rs.getString("Email"));
                u.setRole(rs.getString("RoleName"));
                u.setManagedClub(rs.getString("ManagedClub"));
                u.setJoinedClubs(rs.getString("JoinedClubs"));
                u.setStatus(rs.getBoolean("Status"));
                list.add(u); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countUsers(String search, String roleFilter) {
        int total = 0;
        String sql = "SELECT COUNT(*) AS Total FROM Users u INNER JOIN Roles r ON u.RoleID = r.RoleID WHERE 1=1";
        if (search != null && !search.isEmpty()) {
            sql += " AND (u.UserName LIKE ? OR u.Email LIKE ?)";
        }
        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql += " AND r.RoleName = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            if (search != null && !search.isEmpty()) {
                ps.setString(idx++, "%" + search + "%");
                ps.setString(idx++, "%" + search + "%");
            }
            if (roleFilter != null && !roleFilter.isEmpty()) {
                ps.setString(idx++, roleFilter);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt("Total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public boolean createUser(UserDTO user) {
        String sql = "INSERT INTO Users (UserName, Email, PasswordHash, RoleID, CreatedAt, UpdatedAt) "
                + "VALUES (?, ?, ?, ?, GETDATE(), GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setInt(4, user.getRoleID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean changeRole(int userID, int roleID) {
        String sql = "UPDATE Users SET RoleID = ? WHERE UserID = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roleID);
            ps.setInt(2, userID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean toggleBan(int userID, boolean newStatus) {
        String sql = "UPDATE Users SET Status = ? WHERE UserID = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, newStatus);
            ps.setInt(2, userID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
