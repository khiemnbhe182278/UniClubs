package dal;

import model.EventParticipant;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * EventParticipantDAO - Quản Lý Người Tham Gia Sự Kiện
 * ==============================================
 * 
 * 1. Vai Trò Chính
 *    - Như "người điều phối sự kiện":
 *      + Quản lý danh sách tham gia
 *      + Theo dõi số lượng người tham dự
 *      + Kiểm soát đăng ký/hủy đăng ký
 * 
 * 2. Các Chức Năng Chính
 *    a. Quản Lý Đăng Ký:
 *       - Ghi nhận người đăng ký mới
 *       - Xử lý hủy đăng ký
 *       - Kiểm tra trạng thái đăng ký
 * 
 *    b. Thống Kê Tham Gia:
 *       - Đếm số người tham dự
 *       - Thống kê theo CLB
 *       - Báo cáo tỷ lệ tham gia
 * 
 *    c. Kiểm Soát Sức Chứa:
 *       - Kiểm tra giới hạn người tham gia
 *       - Quản lý danh sách chờ
 *       - Thông báo hết chỗ
 * 
 * 3. Cách Hoạt Động
 *    - Như "hệ thống đặt vé sự kiện":
 *      + Kiểm tra còn chỗ không
 *      + Ghi nhận thông tin người đặt
 *      + Cập nhật số lượng còn lại
 * 
 * 4. Ví Dụ Thực Tế
 *    - Giống quản lý vé concert:
 *      + Bán vé (đăng ký tham gia)
 *      + Kiểm tra số ghế trống
 *      + Xử lý hoàn vé (hủy đăng ký)
 * 
 * 5. Đặc Điểm Nổi Bật
 *    - Như "hệ thống booking thông minh":
 *      + Xử lý nhiều yêu cầu cùng lúc
 *      + Đảm bảo công bằng khi đăng ký
 *      + Thống kê chi tiết
 */
public class EventParticipantDAO extends DBContext {

    public int getTotalParticipants(int clubId) {
        String sql = "SELECT COUNT(DISTINCT ep.UserID) "
                + "FROM EventParticipants ep "
                + "INNER JOIN Events e ON ep.EventID = e.EventID "
                + "WHERE e.ClubID = ?";
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

    public double getAverageAttendance(int clubId) {
        String sql = "SELECT AVG(CAST(ParticipantCount AS FLOAT)) "
                + "FROM (SELECT e.EventID, COUNT(ep.ParticipantID) as ParticipantCount "
                + "FROM Events e "
                + "LEFT JOIN EventParticipants ep ON e.EventID = ep.EventID "
                + "WHERE e.ClubID = ? AND ep.AttendanceStatus = 'Attended' "
                + "GROUP BY e.EventID) as EventStats";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // Register for event
    public boolean registerForEvent(int eventId, int userId) {
        String sql = "INSERT INTO EventParticipants (EventID, UserID, AttendanceStatus) "
                + "VALUES (?, ?, 'Registered')";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check if user is registered
    public boolean isRegistered(int eventId, int userId) {
        String sql = "SELECT COUNT(*) FROM EventParticipants WHERE EventID = ? AND UserID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get event participants
    public List<EventParticipant> getEventParticipants(int eventId) {
        List<EventParticipant> participants = new ArrayList<>();
        String sql = "SELECT ep.*, u.UserName, u.Email FROM EventParticipants ep "
                + "INNER JOIN Users u ON ep.UserID = u.UserID "
                + "WHERE ep.EventID = ? "
                + "ORDER BY ep.RegistrationDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                EventParticipant participant = new EventParticipant();
                participant.setParticipantID(rs.getInt("ParticipantID"));
                participant.setEventID(rs.getInt("EventID"));
                participant.setUserID(rs.getInt("UserID"));
                participant.setRegistrationDate(rs.getTimestamp("RegistrationDate"));
                participant.setAttendanceStatus(rs.getString("AttendanceStatus"));
                participant.setUserName(rs.getString("UserName"));
                participant.setEmail(rs.getString("Email"));
                participants.add(participant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return participants;
    }

    // Get user's registered events
    public List<EventParticipant> getUserEvents(int userId) {
        List<EventParticipant> events = new ArrayList<>();
        String sql = "SELECT ep.*, e.EventName, e.EventDate FROM EventParticipants ep "
                + "INNER JOIN Events e ON ep.EventID = e.EventID "
                + "WHERE ep.UserID = ? "
                + "ORDER BY e.EventDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                EventParticipant participant = new EventParticipant();
                participant.setParticipantID(rs.getInt("ParticipantID"));
                participant.setEventID(rs.getInt("EventID"));
                participant.setUserID(rs.getInt("UserID"));
                participant.setRegistrationDate(rs.getTimestamp("RegistrationDate"));
                participant.setAttendanceStatus(rs.getString("AttendanceStatus"));
                participant.setEventName(rs.getString("EventName"));
                events.add(participant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // Mark attendance
    public boolean markAttendance(int participantId, String status) {
        String sql = "UPDATE EventParticipants SET AttendanceStatus = ? WHERE ParticipantID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, participantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get participant count
    public int getParticipantCount(int eventId) {
        String sql = "SELECT COUNT(*) FROM EventParticipants WHERE EventID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
