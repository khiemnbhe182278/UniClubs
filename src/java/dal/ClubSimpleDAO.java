package dal;

import model.Club;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClubSimpleDAO extends DBContext {

    // Lấy tất cả clubs (chỉ bảng Clubs)
    public List<Club> getAllClubs() {
        List<Club> list = new ArrayList<>();
        String sql = """
            SELECT ClubID, ClubName, Description, Logo, FacultyID, LeaderID, Status, CreatedAt, UpdatedAt 
            FROM Clubs 
            ORDER BY ClubID DESC
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Club c = new Club();
                c.setClubID(rs.getInt("ClubID"));
                c.setClubName(rs.getString("ClubName"));
                c.setDescription(rs.getString("Description"));
                c.setLogo(rs.getString("Logo"));
                c.setFacultyID(rs.getInt("FacultyID"));
                c.setLeaderID(rs.getInt("LeaderID"));
                c.setStatus(rs.getBoolean("Status"));
                c.setCreatedAt(rs.getTimestamp("CreatedAt"));
                c.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                list.add(c);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error in getAllClubs(): " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // Hàm main test
    public static void main(String[] args) {
        ClubSimpleDAO dao = new ClubSimpleDAO();
        List<Club> clubs = dao.getAllClubs();

        if (clubs.isEmpty()) {
            System.out.println("⚠ No clubs found in database.");
        } else {
            System.out.println("=== ✅ List of Clubs ===");
            for (Club c : clubs) {
                System.out.println("ID: " + c.getClubID());
                System.out.println("Name: " + c.getClubName());
                System.out.println("Description: " + c.getDescription());
                System.out.println("Logo: " + c.getLogo());
                System.out.println("FacultyID: " + c.getFacultyID());
                System.out.println("LeaderID: " + c.getLeaderID());
                System.out.println("Status: " + (c.isStatus() ? "Active" : "Inactive"));
                System.out.println("Created At: " + c.getCreatedAt());
                System.out.println("Updated At: " + c.getUpdatedAt());
                System.out.println("-----------------------------");
            }
        }
    }
}
