package dal;

import model.EventRegistration;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventRegistrationDAO extends DBContext {
    
    // Get all participants by event ID
    public List<EventRegistration> getParticipantsByEventId(int eventId) {
        List<EventRegistration> participants = new ArrayList<>();
        String sql = "SELECT er.*, u.UserName, u.Email " +
                     "FROM EventRegistrations er " +
                     "INNER JOIN Users u ON er.UserID = u.UserID " +
                     "WHERE er.EventID = ? " +
                     "ORDER BY er.RegistrationDate DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                EventRegistration registration = new EventRegistration();
                registration.setParticipantID(rs.getInt("RegistrationID"));
                registration.setEventID(rs.getInt("EventID"));
                registration.setUserID(rs.getInt("UserID"));
                registration.setUserName(rs.getString("UserName"));
                registration.setEmail(rs.getString("Email"));
                registration.setRegistrationDate(rs.getTimestamp("RegistrationDate"));
                registration.setStatus(rs.getString("Status"));
                registration.setAttendanceStatus(rs.getString("AttendanceStatus"));
                
                participants.add(registration);
            }
        } catch (SQLException e) {
            System.err.println("Error getting participants by event ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return participants;
    }
    
    // Update attendance status
    public boolean updateAttendanceStatus(int participantId, String attendanceStatus) {
        String sql = "UPDATE EventRegistrations SET AttendanceStatus = ? WHERE RegistrationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, attendanceStatus);
            ps.setInt(2, participantId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating attendance status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get registration by ID
    public EventRegistration getRegistrationById(int registrationId) {
        String sql = "SELECT er.*, u.UserName, u.Email " +
                     "FROM EventRegistrations er " +
                     "INNER JOIN Users u ON er.UserID = u.UserID " +
                     "WHERE er.RegistrationID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, registrationId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                EventRegistration registration = new EventRegistration();
                registration.setParticipantID(rs.getInt("RegistrationID"));
                registration.setEventID(rs.getInt("EventID"));
                registration.setUserID(rs.getInt("UserID"));
                registration.setUserName(rs.getString("UserName"));
                registration.setEmail(rs.getString("Email"));
                registration.setRegistrationDate(rs.getTimestamp("RegistrationDate"));
                registration.setStatus(rs.getString("Status"));
                registration.setAttendanceStatus(rs.getString("AttendanceStatus"));
                
                return registration;
            }
        } catch (SQLException e) {
            System.err.println("Error getting registration by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Register user for event
    public boolean registerForEvent(int eventId, int userId) {
        String sql = "INSERT INTO EventRegistrations (EventID, UserID, Status, AttendanceStatus, RegistrationDate) " +
                     "VALUES (?, ?, 'Approved', 'Registered', GETDATE())";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error registering for event: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if user is already registered
    public boolean isUserRegistered(int eventId, int userId) {
        String sql = "SELECT COUNT(*) FROM EventRegistrations WHERE EventID = ? AND UserID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking user registration: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Get count of approved participants
    public int getApprovedParticipantsCount(int eventId) {
        String sql = "SELECT COUNT(*) FROM EventRegistrations " +
                     "WHERE EventID = ? AND Status = 'Approved'";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting approved participants count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
}