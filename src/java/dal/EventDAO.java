package dal;

import model.Event;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventDAO extends DBContext {

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

    // Get event by ID
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

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

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
            System.err.println("SQL Error in getAllActiveEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return events;
    }

    // Lấy event theo ID
    public Event getEventById(int eventId) {
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

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, eventId);

            try (ResultSet rs = ps.executeQuery()) {
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
            }

        } catch (SQLException e) {
            System.err.println("SQL Error in getEventById: " + e.getMessage());
            e.printStackTrace();
        }
        return event;
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
}
