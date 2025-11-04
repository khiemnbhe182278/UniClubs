package dal;

import model.Payment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * PaymentDAO - Trung Tâm Quản Lý Tài Chính
 * ====================================
 * 
 * 1. Vai Trò Chính
 *    - Như "phòng kế toán" của hệ thống:
 *      + Quản lý mọi giao dịch tài chính
 *      + Theo dõi các khoản thu chi
 *      + Đảm bảo minh bạch tài chính
 * 
 * 2. Các Chức Năng Chính
 *    a. Quản Lý Giao Dịch:
 *       - Ghi nhận khoản thu
 *       - Xử lý hoàn tiền
 *       - Kiểm tra trạng thái thanh toán
 * 
 *    b. Theo Dõi Ngân Sách:
 *       - Thống kê thu chi
 *       - Báo cáo tài chính
 *       - Cảnh báo vượt ngân sách
 * 
 *    c. Xử Lý Đặc Biệt:
 *       - Thanh toán định kỳ
 *       - Xử lý thanh toán trễ
 *       - Ghi nhận phí phạt
 * 
 * 3. Quy Trình Làm Việc
 *    - Như "ngân hàng mini":
 *      + Kiểm tra thông tin giao dịch
 *      + Xác nhận số tiền
 *      + Cập nhật trạng thái
 *      + Ghi log giao dịch
 * 
 * 4. Ví Dụ Thực Tế
 *    - Giống phòng kế toán công ty:
 *      + Thu phí thành viên
 *      + Chi phí tổ chức sự kiện
 *      + Hoàn trả khi hủy đăng ký
 * 
 * 5. Tính Năng An Toàn
 *    - Như "két sắt điện tử":
 *      + Kiểm tra kỹ lưỡng mọi giao dịch
 *      + Lưu trữ lịch sử chi tiết
 *      + Bảo vệ thông tin tài chính
 */
public class PaymentDAO extends DBContext {

    public int getPendingPaymentsCount(int clubId) {
        String sql = "SELECT COUNT(*) FROM Payments WHERE ClubID = ? AND Status = 'Pending'";
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

    public double getMonthlyRevenue(int clubId) {
        String sql = "SELECT SUM(Amount) FROM Payments "
                + "WHERE ClubID = ? AND Status = 'Completed' "
                + "AND MONTH(PaymentDate) = MONTH(GETDATE()) "
                + "AND YEAR(PaymentDate) = YEAR(GETDATE())";
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

    // Create payment
    public boolean createPayment(Payment payment) {
        String sql = "INSERT INTO Payments (ClubID, UserID, Amount, PaymentType, Status) "
                + "VALUES (?, ?, ?, ?, 'Pending')";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, payment.getClubID());
            ps.setInt(2, payment.getUserID());
            ps.setBigDecimal(3, payment.getAmount());
            ps.setString(4, payment.getPaymentType());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get club payments
    public List<Payment> getClubPayments(int clubId) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT p.*, u.UserName FROM Payments p "
                + "INNER JOIN Users u ON p.UserID = u.UserID "
                + "WHERE p.ClubID = ? "
                + "ORDER BY p.PaymentDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentID(rs.getInt("PaymentID"));
                payment.setClubID(rs.getInt("ClubID"));
                payment.setUserID(rs.getInt("UserID"));
                payment.setAmount(rs.getBigDecimal("Amount"));
                payment.setPaymentType(rs.getString("PaymentType"));
                payment.setPaymentDate(rs.getTimestamp("PaymentDate"));
                payment.setStatus(rs.getString("Status"));
                payment.setUserName(rs.getString("UserName"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    // Get user payments
    public List<Payment> getUserPayments(int userId) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT p.*, c.ClubName FROM Payments p "
                + "INNER JOIN Clubs c ON p.ClubID = c.ClubID "
                + "WHERE p.UserID = ? "
                + "ORDER BY p.PaymentDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentID(rs.getInt("PaymentID"));
                payment.setClubID(rs.getInt("ClubID"));
                payment.setUserID(rs.getInt("UserID"));
                payment.setAmount(rs.getBigDecimal("Amount"));
                payment.setPaymentType(rs.getString("PaymentType"));
                payment.setPaymentDate(rs.getTimestamp("PaymentDate"));
                payment.setStatus(rs.getString("Status"));
                payment.setClubName(rs.getString("ClubName"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    // Update payment status
    public boolean updatePaymentStatus(int paymentId, String status) {
        String sql = "UPDATE Payments SET Status = ? WHERE PaymentID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, paymentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get total revenue
    public double getTotalRevenue(int clubId) {
        String sql = "SELECT SUM(Amount) FROM Payments "
                + "WHERE ClubID = ? AND Status = 'Completed'";

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
}
