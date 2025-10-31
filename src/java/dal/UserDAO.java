package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import model.Role;

public class UserDAO extends DBContext {

    public List<Integer> getLeaderClubIds(int userId) {
        List<Integer> clubIds = new ArrayList<>();
        String sql = "SELECT ClubID FROM Clubs WHERE LeaderID = ? AND Status = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                clubIds.add(rs.getInt("ClubID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return clubIds;
    }

    /**
     * Lấy danh sách ClubID mà user là Faculty Advisor
     */
    public List<Integer> getFacultyClubIds(int userId) {
        List<Integer> clubIds = new ArrayList<>();
        String sql = "SELECT ClubID FROM Clubs WHERE FacultyID = ? AND Status = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                clubIds.add(rs.getInt("ClubID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return clubIds;
    }

    /**
     * Lấy ClubID đầu tiên của Leader (nếu chỉ quản lý 1 club)
     */
    public Integer getLeaderPrimaryClubId(int userId) {
        List<Integer> clubIds = getLeaderClubIds(userId);
        return clubIds.isEmpty() ? null : clubIds.get(0);
    }

    /**
     * Lấy ClubID đầu tiên của Faculty (nếu chỉ cố vấn 1 club)
     */
    public Integer getFacultyPrimaryClubId(int userId) {
        List<Integer> clubIds = getFacultyClubIds(userId);
        return clubIds.isEmpty() ? null : clubIds.get(0);
    }

    /**
     * Load đầy đủ thông tin user kèm clubId
     */
    public User getUserWithClubInfo(int userId) {
        User user = getUserById(userId); // Giả sử đã có method này

        if (user != null) {
            // Nếu là Leader (roleID = 2)
            if (user.getRoleID() == 2) {
                List<Integer> clubIds = getLeaderClubIds(userId);
                user.setClubIds(clubIds);
                user.setClubId(clubIds.isEmpty() ? null : clubIds.get(0));
            } // Nếu là Faculty (roleID = 3)
            else if (user.getRoleID() == 3) {
                List<Integer> clubIds = getFacultyClubIds(userId);
                user.setClubIds(clubIds);
                user.setClubId(clubIds.isEmpty() ? null : clubIds.get(0));
            }
        }

        return user;
    }

    public boolean updateUserRole(int userId, int roleId) {
        String sql = "UPDATE Users SET RoleID = ?, UpdatedAt = GETDATE() WHERE UserID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roleId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT * FROM Roles ORDER BY RoleName";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Role role = new Role();
                role.setRoleID(rs.getInt("RoleID"));
                role.setRoleName(rs.getString("RoleName"));
                role.setDescription(rs.getString("Description"));
                roles.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    // Hash password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    // Login
    public User login(String email, String password) {
        String sql = "SELECT u.*, r.RoleName FROM Users u "
                + "INNER JOIN Roles r ON u.RoleID = r.RoleID "
                + "WHERE u.Email = ? AND u.PasswordHash = ? AND u.Status = 1";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashPassword(password));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("Email"));
                user.setRoleID(rs.getInt("RoleID"));
                user.setRoleName(rs.getString("RoleName"));
                user.setStatus(rs.getBoolean("Status"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Register
    public boolean register(User user, String password) {
        String sql = "INSERT INTO Users (UserName, Email, PasswordHash, RoleID, Status) "
                + "VALUES (?, ?, ?, ?, 1)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, hashPassword(password));
            ps.setInt(4, user.getRoleID());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check if email exists
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get user by ID
    public User getUserById(int userId) {
        String sql = "SELECT u.*, r.RoleName FROM Users u "
                + "INNER JOIN Roles r ON u.RoleID = r.RoleID "
                + "WHERE u.UserID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("Email"));
                user.setRoleID(rs.getInt("RoleID"));
                user.setRoleName(rs.getString("RoleName"));
                user.setStatus(rs.getBoolean("Status"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createUserByAdmin(User user, String password) {
        String sql = "INSERT INTO Users (UserName, Email, PasswordHash, RoleID, FullName, Phone, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, hashPassword(password));
            ps.setInt(4, user.getRoleID());
            ps.setString(5, user.getFullName());
            ps.setString(6, user.getPhone());
            ps.setBoolean(7, user.isStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update user profile
    public boolean updateProfile(User user) {
        String sql = "UPDATE Users SET UserName = ?, Phone = ?, Faculty = ? "
                + "WHERE UserID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getFaculty());
            ps.setInt(4, user.getUserID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
