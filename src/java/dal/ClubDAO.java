package dal;

import model.Club;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClubDAO extends DBContext {

    public List<Club> getClubs(String search) {
        List<Club> list = new ArrayList<>();

        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, "
                + "f.UserName AS FacultyName, "
                + "l.UserName AS LeaderName, "
                + "c.Status, c.CreatedAt, c.UpdatedAt "
                + "FROM Clubs c "
                + "LEFT JOIN Users f ON c.FacultyID = f.UserID "
                + "LEFT JOIN Users l ON c.LeaderID = l.UserID "
                + "WHERE 1=1 ";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (c.ClubName LIKE ? OR c.Description LIKE ?)";
        }

        sql += " ORDER BY c.ClubID DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Club c = new Club();
                c.setClubID(rs.getInt("ClubID"));
                c.setClubName(rs.getString("ClubName"));
                c.setDescription(rs.getString("Description"));
                c.setLogo(rs.getString("Logo"));
                c.setFacultyName(rs.getString("FacultyName"));
                c.setLeaderName(rs.getString("LeaderName"));
                c.setStatus(rs.getBoolean("Status"));
                c.setCreatedAt(rs.getTimestamp("CreatedAt"));
                c.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Club> getAllClubs() {
    return getClubs(null); // truyền null để lấy tất cả
}



}
