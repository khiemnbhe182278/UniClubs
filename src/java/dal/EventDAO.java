package dal;

import model.Event;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.AdminStats;
import model.Club;
import model.Member;
import model.User;

public class EventDAO extends DBContext {

    public boolean deleteEvent(int eventId) {
        String sql = "DELETE FROM Events WHERE EventID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Event> getUpcomingEventsByClubId(int clubId) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, c.ClubName, "
                + "(SELECT COUNT(*) FROM EventParticipants ep "
                + "WHERE ep.EventID = e.EventID) as CurrentParticipants "
                + "FROM Events e "
                + "LEFT JOIN Clubs c ON e.ClubID = c.ClubID "
                + "WHERE e.ClubID = ? "
                + "AND e.Status = 'Approved' "
                + "AND e.EventDate >= GETDATE() "
                + "ORDER BY e.EventDate ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Event event = mapResultSetToEvent(rs);
                events.add(event);
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming events by club ID: " + e.getMessage());
            e.printStackTrace();
        }
        return events;
    }

    public Event getEventById(int eventId) {
        String sql = "SELECT e.*, c.ClubName, "
                + "(SELECT COUNT(*) FROM EventParticipants ep "
                + "WHERE ep.EventID = e.EventID) as CurrentParticipants "
                + "FROM Events e "
                + "LEFT JOIN Clubs c ON e.ClubID = c.ClubID "
                + "WHERE e.EventID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToEvent(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting event by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    private Event mapResultSetToEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventID(rs.getInt("EventID"));
        event.setClubID(rs.getInt("ClubID"));
        event.setEventName(rs.getString("EventName"));
        event.setDescription(rs.getString("Description"));
        event.setEventDate(rs.getTimestamp("EventDate"));
        event.setStatus(rs.getString("Status"));
        event.setCreatedAt(rs.getTimestamp("CreatedAt"));
        event.setLocation(rs.getString("Location"));
        event.setMaxParticipants(rs.getInt("MaxParticipants"));
        event.setRegistrationDeadline(rs.getTimestamp("RegistrationDeadline"));
        event.setEventImage(rs.getString("EventImage"));
        event.setClubName(rs.getString("ClubName"));
        event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
        return event;
    }

    // Helper method to close resources
    private void closeResources(ResultSet rs, PreparedStatement ps) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public boolean updateEvent(Event event) {
        String sql = "UPDATE Events SET EventName = ?, Description = ?, EventDate = ?, "
                + "Location = ?, MaxParticipants = ? WHERE EventID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, event.getEventName());
            ps.setString(2, event.getDescription());
            ps.setTimestamp(3, event.getEventDate());
            ps.setString(4, event.getLocation());
            if (event.getMaxParticipants() > 0) {
                ps.setInt(5, event.getMaxParticipants());
            } else {
                ps.setNull(5, java.sql.Types.INTEGER);
            }
            ps.setInt(6, event.getEventID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all upcoming events
    public List<Event> getUpcomingEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, c.ClubName "
                + "FROM Events e "
                + "INNER JOIN Clubs c ON e.ClubID = c.ClubID "
                + "WHERE e.EventDate >= GETDATE() AND e.Status = 'Approved' "
                + "ORDER BY e.EventDate ASC";

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

    // Get events by club
    public List<Event> getEventsByClub(int clubId) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM Events WHERE ClubID = ? ORDER BY EventDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt("EventID"));
                event.setClubID(rs.getInt("ClubID"));
                event.setEventName(rs.getString("EventName"));
                event.setDescription(rs.getString("Description"));
                event.setEventDate(rs.getTimestamp("EventDate"));
                event.setStatus(rs.getString("Status"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<Event> getAllActiveEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.EventID, e.ClubID, e.EventName, e.Description, e.EventDate, "
                + "e.Status, e.CreatedAt, e.Location, e.MaxParticipants, "
                + "c.ClubName, "
                + "COUNT(DISTINCT ep.ParticipantID) as CurrentParticipants "
                + "FROM Events e "
                + "LEFT JOIN Clubs c ON e.ClubID = c.ClubID "
                + "LEFT JOIN EventParticipants ep ON e.EventID = ep.EventID "
                + "WHERE e.Status = 'Active' "
                + "GROUP BY e.EventID, e.ClubID, e.EventName, e.Description, e.EventDate, "
                + "e.Status, e.CreatedAt, e.Location, e.MaxParticipants, c.ClubName "
                + "ORDER BY e.EventDate DESC";

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt("EventID"));
                event.setClubID(rs.getInt("ClubID"));
                event.setEventName(rs.getString("EventName"));
                event.setDescription(rs.getString("Description"));
                event.setEventDate(rs.getTimestamp("EventDate"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setLocation(rs.getString("Location"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setClubName(rs.getString("ClubName"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return events;
    }

    public Event getEventId(int eventId) {
        Event event = null;
        String sql = "SELECT e.EventID, e.ClubID, e.EventName, e.Description, e.EventDate, "
                + "e.Status, e.CreatedAt, e.Location, e.MaxParticipants, "
                + "c.ClubName, "
                + "COUNT(DISTINCT ep.ParticipantID) as CurrentParticipants "
                + "FROM Events e "
                + "LEFT JOIN Clubs c ON e.ClubID = c.ClubID "
                + "LEFT JOIN EventParticipants ep ON e.EventID = ep.EventID "
                + "WHERE e.EventID = ? "
                + "GROUP BY e.EventID, e.ClubID, e.EventName, e.Description, e.EventDate, "
                + "e.Status, e.CreatedAt, e.Location, e.MaxParticipants, c.ClubName";

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, eventId);
            rs = ps.executeQuery();
            if (rs.next()) {
                event = new Event();
                event.setEventID(rs.getInt("EventID"));
                event.setClubID(rs.getInt("ClubID"));
                event.setEventName(rs.getString("EventName"));
                event.setDescription(rs.getString("Description"));
                event.setEventDate(rs.getTimestamp("EventDate"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setLocation(rs.getString("Location"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setClubName(rs.getString("ClubName"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return event;
    }

    public int getClubEventCount(int clubId) {
        String sql = "SELECT COUNT(*) FROM Events WHERE ClubID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getUpcomingEventCount(int clubId) {
        String sql = "SELECT COUNT(*) FROM Events "
                + "WHERE ClubID = ? AND EventDate >= GETDATE() AND Status = 'Approved'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Create event
    public boolean createEvent(Event event) {
        String sql = "INSERT INTO Events (ClubID, EventName, Description, EventDate, Status) "
                + "VALUES (?, ?, ?, ?, 'Pending')";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, event.getClubID());
            ps.setString(2, event.getEventName());
            ps.setString(3, event.getDescription());
            ps.setTimestamp(4, event.getEventDate());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

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
