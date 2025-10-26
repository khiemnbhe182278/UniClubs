package dal;

import model.Club;
import model.Member;
import model.Event;
import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.AdminStats;

public class AdminDAO extends DBContext {

    // Get all pending clubs
    public List<Club> getPendingClubs() {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT c.*, u.UserName as LeaderName "
                + "FROM Clubs c "
                + "LEFT JOIN Users u ON c.LeaderID = u.UserID "
                + "WHERE c.Status = 'Pending' "
                + "ORDER BY c.CreatedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setStatus(rs.getString("Status"));
                club.setCreatedAt(rs.getTimestamp("CreatedAt"));
                clubs.add(club);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    // Approve club
    public boolean approveClub(int clubId) {
        String sql = "UPDATE Clubs SET Status = 'Active', UpdatedAt = GETDATE() WHERE ClubID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Reject club
    public boolean rejectClub(int clubId) {
        String sql = "UPDATE Clubs SET Status = 'Rejected', UpdatedAt = GETDATE() WHERE ClubID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all pending members
    public List<Member> getPendingMembers() {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT m.*, u.UserName, u.Email, c.ClubName "
                + "FROM Members m "
                + "INNER JOIN Users u ON m.UserID = u.UserID "
                + "INNER JOIN Clubs c ON m.ClubID = c.ClubID "
                + "WHERE m.JoinStatus = 'Pending' "
                + "ORDER BY m.JoinedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Member member = new Member();
                member.setMemberID(rs.getInt("MemberID"));
                member.setUserID(rs.getInt("UserID"));
                member.setClubID(rs.getInt("ClubID"));
                member.setJoinStatus(rs.getString("JoinStatus"));
                member.setJoinedAt(rs.getTimestamp("JoinedAt"));
                member.setUserName(rs.getString("UserName"));
                member.setEmail(rs.getString("Email"));
                member.setClubName(rs.getString("ClubName"));
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    // Get all pending events
    public List<Event> getPendingEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, c.ClubName FROM Events e "
                + "INNER JOIN Clubs c ON e.ClubID = c.ClubID "
                + "WHERE e.Status = 'Pending' "
                + "ORDER BY e.CreatedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt("EventID"));
                event.setClubID(rs.getInt("ClubID"));
                event.setEventName(rs.getString("EventName"));
                event.setDescription(rs.getString("Description"));
                event.setEventDate(rs.getTimestamp("EventDate"));
                event.setStatus(rs.getString("Status"));
                event.setClubName(rs.getString("ClubName"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // Approve event
    public boolean approveEvent(int eventId) {
        String sql = "UPDATE Events SET Status = 'Approved' WHERE EventID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Reject event
    public boolean rejectEvent(int eventId) {
        String sql = "UPDATE Events SET Status = 'Rejected' WHERE EventID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.*, r.RoleName FROM Users u "
                + "INNER JOIN Roles r ON u.RoleID = r.RoleID "
                + "ORDER BY u.CreatedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("Email"));
                user.setRoleID(rs.getInt("RoleID"));
                user.setRoleName(rs.getString("RoleName"));
                user.setStatus(rs.getBoolean("Status"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Toggle user status
    public boolean toggleUserStatus(int userId) {
        String sql = "UPDATE Users SET Status = CASE WHEN Status = 1 THEN 0 ELSE 1 END WHERE UserID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get dashboard statistics
    public AdminStats getAdminStats() {
        AdminStats stats = new AdminStats();
        try {
            // Pending clubs
            String sql1 = "SELECT COUNT(*) FROM Clubs WHERE Status = 'Pending'";
            PreparedStatement ps1 = connection.prepareStatement(sql1);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                stats.setPendingClubs(rs1.getInt(1));
            }

            // Pending members
            String sql2 = "SELECT COUNT(*) FROM Members WHERE JoinStatus = 'Pending'";
            PreparedStatement ps2 = connection.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                stats.setPendingMembers(rs2.getInt(1));
            }

            // Pending events
            String sql3 = "SELECT COUNT(*) FROM Events WHERE Status = 'Pending'";
            PreparedStatement ps3 = connection.prepareStatement(sql3);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                stats.setPendingEvents(rs3.getInt(1));
            }

            // Total users
            String sql4 = "SELECT COUNT(*) FROM Users WHERE Status = 1";
            PreparedStatement ps4 = connection.prepareStatement(sql4);
            ResultSet rs4 = ps4.executeQuery();
            if (rs4.next()) {
                stats.setTotalUsers(rs4.getInt(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
}
