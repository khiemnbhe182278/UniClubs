package dal;

import dal.DBContext;
import model.UserDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDTODAO extends DBContext {

    // Lấy tất cả user
    public List<UserDTO> getAllUsers() {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                UserDTO u = new UserDTO(
                        rs.getInt("UserID"),
                        rs.getString("UserName"),
                        rs.getString("Email"),
                        rs.getString("PasswordHash"),
                        rs.getInt("RoleID"),
                        rs.getString("Role"),
                        rs.getString("ManagedClub"),
                        rs.getString("JoinedClubs"),
                        rs.getBoolean("Status")
                );
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm user
    public void addUser(UserDTO u) {
        String sql = "INSERT INTO Users(UserName, Email, PasswordHash, RoleID, Role, ManagedClub, JoinedClubs, Status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, u.getUserName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPasswordHash());
            ps.setInt(4, u.getRoleID());
            ps.setString(5, u.getRole());
            ps.setString(6, u.getManagedClub());
            ps.setString(7, u.getJoinedClubs());
            ps.setBoolean(8, u.isStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy user theo ID
    public UserDTO getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE UserID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserDTO(
                            rs.getInt("UserID"),
                            rs.getString("UserName"),
                            rs.getString("Email"),
                            rs.getString("PasswordHash"),
                            rs.getInt("RoleID"),
                            rs.getString("Role"),
                            rs.getString("ManagedClub"),
                            rs.getString("JoinedClubs"),
                            rs.getBoolean("Status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật user
    public void updateUser(UserDTO u) {
        String sql = "UPDATE Users SET UserName=?, Email=?, PasswordHash=?, RoleID=?, Role=?, "
                   + "ManagedClub=?, JoinedClubs=?, Status=? WHERE UserID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, u.getUserName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPasswordHash());
            ps.setInt(4, u.getRoleID());
            ps.setString(5, u.getRole());
            ps.setString(6, u.getManagedClub());
            ps.setString(7, u.getJoinedClubs());
            ps.setBoolean(8, u.isStatus());
            ps.setInt(9, u.getUserID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa user
    public void deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE UserID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
