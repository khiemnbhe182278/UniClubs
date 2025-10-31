package dal;

import model.Notification;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * NotificationDAO - Hệ Thống Thông Báo Thông Minh
 * ==========================================
 * 
 * 1. Vai Trò của NotificationDAO
 *    - Như "trung tâm thông báo" của toàn bộ hệ thống:
 *      + Gửi thông báo đến người dùng
 *      + Quản lý trạng thái đã đọc/chưa đọc
 *      + Lưu trữ lịch sử thông báo
 * 
 * 2. Các Loại Thông Báo
 *    a. Thông Báo Sự Kiện:
 *       - Sự kiện mới được tạo
 *       - Nhắc nhở sự kiện sắp diễn ra
 *       - Cập nhật thông tin sự kiện
 * 
 *    b. Thông Báo Thành Viên:
 *       - Chấp nhận/từ chối đơn đăng ký
 *       - Thay đổi vai trò trong CLB
 *       - Nhắc nhở nhiệm vụ
 * 
 *    c. Thông Báo Hệ Thống:
 *       - Bảo trì hệ thống
 *       - Cập nhật quy định
 *       - Thông báo chung
 * 
 * 3. Cách Hoạt Động
 *    - Giống như "hệ thống báo động thông minh":
 *      + Tự động gửi thông báo khi có sự kiện
 *      + Theo dõi trạng thái đã đọc
 *      + Lưu trữ có tổ chức trong database
 * 
 * 4. Ví Dụ Thực Tế
 *    - Như hệ thống thông báo trong mạng xã hội:
 *      + Thông báo khi có bài viết mới
 *      + Nhắc về sự kiện sắp tới
 *      + Đánh dấu đã đọc/chưa đọc
 * 
 * 5. Tối Ưu Hóa
 *    - Như "bộ lọc thư":
 *      + Sắp xếp theo độ ưu tiên
 *      + Gom nhóm thông báo liên quan
 *      + Xóa thông báo cũ tự động
 */
public class NotificationDAO extends DBContext {

    // Create notification
    public boolean createNotification(Notification notification) {
        String sql = "INSERT INTO Notifications (UserID, Title, Content, NotificationType, RelatedID, IsRead) "
                + "VALUES (?, ?, ?, ?, ?, 0)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, notification.getUserID());
            ps.setString(2, notification.getTitle());
            ps.setString(3, notification.getContent());
            ps.setString(4, notification.getNotificationType());
            ps.setInt(5, notification.getRelatedID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get user notifications
    public List<Notification> getUserNotifications(int userId, int limit) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Notifications "
                + "WHERE UserID = ? "
                + "ORDER BY CreatedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Notification notif = new Notification();
                notif.setNotificationID(rs.getInt("NotificationID"));
                notif.setUserID(rs.getInt("UserID"));
                notif.setTitle(rs.getString("Title"));
                notif.setContent(rs.getString("Content"));
                notif.setNotificationType(rs.getString("NotificationType"));
                notif.setRelatedID(rs.getInt("RelatedID"));
                notif.setRead(rs.getBoolean("IsRead"));
                notif.setCreatedAt(rs.getTimestamp("CreatedAt"));
                notifications.add(notif);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    // Mark as read
    public boolean markAsRead(int notificationId) {
        String sql = "UPDATE Notifications SET IsRead = 1 WHERE NotificationID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, notificationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get unread count
    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) FROM Notifications WHERE UserID = ? AND IsRead = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
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
