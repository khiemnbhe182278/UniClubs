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

/**
 * AdminDAO - Lớp xử lý dữ liệu liên quan đến Admin
 * ==============================================
 * Lớp này chứa các phương thức thao tác với CSDL phục vụ cho các chức năng của Admin:
 * 1. Quản lý câu lạc bộ (CLB)
 *    - Duyệt/từ chối CLB mới
 *    - Xem danh sách CLB chờ duyệt
 * 
 * 2. Quản lý thành viên
 *    - Xem danh sách thành viên chờ duyệt
 *    - Duyệt/từ chối thành viên
 * 
 * 3. Quản lý sự kiện
 *    - Xem danh sách sự kiện chờ duyệt
 *    - Duyệt/từ chối sự kiện
 * 
 * 4. Quản lý người dùng
 *    - Xem danh sách người dùng
 *    - Kích hoạt/vô hiệu hóa tài khoản
 * 
 * 5. Thống kê tổng quan
 *    - Số liệu về CLB, thành viên, sự kiện
 *    - Số lượng đang chờ duyệt
 *    - Tổng số người dùng
 */
public class AdminDAO extends DBContext {

    /**
     * Lấy danh sách câu lạc bộ đang chờ duyệt
     * =======================================
     * Input: Không có
     * 
     * Output: 
     * - List<Club>: Danh sách các CLB có status = 'Pending'
     * - Mỗi Club chứa thông tin cơ bản: ID, tên, mô tả, ngày tạo
     * - Bao gồm cả tên người tạo (từ bảng Users)
     * 
     * SQL:
     * - Join bảng Clubs với Users để lấy tên người tạo
     * - Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
     */
    public List<Club> getPendingClubs() {
        List<Club> clubs = new ArrayList<>();
        
        // Câu lệnh SQL:
        // - Lấy tất cả thông tin từ bảng Clubs (c.*)
        // - Kèm theo tên người tạo từ bảng Users (u.UserName)
        // - Chỉ lấy các CLB có trạng thái "Pending"
        // - Sắp xếp theo thời gian tạo mới nhất
        String sql = "SELECT c.*, u.UserName as LeaderName "
                + "FROM Clubs c "
                + "LEFT JOIN Users u ON c.LeaderID = u.UserID "
                + "WHERE c.Status = 'Pending' "
                + "ORDER BY c.CreatedAt DESC";

        try {
            // Thực thi câu lệnh SQL
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Duyệt qua từng dòng kết quả
            while (rs.next()) {
                // Tạo đối tượng Club và set các thuộc tính
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));        // Mã CLB
                club.setClubName(rs.getString("ClubName"));  // Tên CLB
                club.setDescription(rs.getString("Description")); // Mô tả
                club.setStatus(rs.getString("Status"));     // Trạng thái
                club.setCreatedAt(rs.getTimestamp("CreatedAt")); // Ngày tạo
                clubs.add(club);
            }
        } catch (SQLException e) {
            // In lỗi nếu có vấn đề khi truy vấn
            e.printStackTrace();
        }
        return clubs; // Trả về danh sách các CLB
    }

    /**
     * Duyệt câu lạc bộ
     * ===============
     * Input:
     * - clubId: Mã của CLB cần duyệt
     * 
     * Output:
     * - true: Nếu duyệt thành công
     * - false: Nếu có lỗi xảy ra
     * 
     * Xử lý:
     * - Cập nhật trạng thái CLB thành "Active"
     * - Cập nhật thời gian cập nhật (UpdatedAt)
     */
    public boolean approveClub(int clubId) {
        // Câu lệnh SQL:
        // - Cập nhật trạng thái thành "Active"
        // - Cập nhật thời gian sửa đổi bằng GETDATE() (thời điểm hiện tại)
        // - Chỉ cập nhật CLB có ID tương ứng
        String sql = "UPDATE Clubs SET Status = 'Active', UpdatedAt = GETDATE() WHERE ClubID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);  // Gán giá trị cho tham số clubId
            
            // Thực thi câu lệnh và kiểm tra kết quả
            // ps.executeUpdate() trả về số dòng bị ảnh hưởng
            // > 0 nghĩa là có ít nhất 1 dòng được cập nhật
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi nếu có
        }
        return false; // Trả về false nếu có lỗi
    }

    /**
     * Từ chối câu lạc bộ
     * ================
     * Input:
     * - clubId: Mã của CLB cần từ chối
     * 
     * Output:
     * - true: Nếu từ chối thành công
     * - false: Nếu có lỗi xảy ra
     * 
     * Xử lý:
     * - Cập nhật trạng thái CLB thành "Rejected"
     * - Cập nhật thời gian cập nhật (UpdatedAt)
     */
    public boolean rejectClub(int clubId) {
        // Câu lệnh SQL:
        // - Cập nhật trạng thái thành "Rejected"
        // - Cập nhật thời gian sửa đổi
        // - Chỉ cập nhật CLB có ID tương ứng
        String sql = "UPDATE Clubs SET Status = 'Rejected', UpdatedAt = GETDATE() WHERE ClubID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);  // Gán giá trị cho tham số clubId
            return ps.executeUpdate() > 0;  // Trả về true nếu cập nhật thành công
            
        } catch (SQLException e) {
            e.printStackTrace();  // In lỗi nếu có
        }
        return false;  // Trả về false nếu có lỗi
    }

    /**
     * Lấy danh sách thành viên đang chờ duyệt
     * ====================================
     * Input: Không có
     * 
     * Output:
     * - List<Member>: Danh sách các thành viên đang chờ duyệt
     * - Mỗi Member chứa:
     *   + Thông tin thành viên (ID, trạng thái, ngày tham gia)
     *   + Thông tin người dùng (tên, email)
     *   + Thông tin CLB (tên CLB)
     * 
     * SQL:
     * - Join 3 bảng: Members, Users, Clubs
     * - Lọc theo trạng thái "Pending"
     * - Sắp xếp theo thời gian tham gia mới nhất
     */
    public List<Member> getPendingMembers() {
        List<Member> members = new ArrayList<>();
        
        // Câu lệnh SQL:
        // - Lấy tất cả thông tin từ Members (m.*)
        // - Kèm theo thông tin người dùng (tên, email)
        // - Và tên CLB từ bảng Clubs
        // - Chỉ lấy các thành viên đang chờ duyệt
        // - Sắp xếp theo thời gian tham gia mới nhất
        String sql = "SELECT m.*, u.UserName, u.Email, c.ClubName "
                + "FROM Members m "
                + "INNER JOIN Users u ON m.UserID = u.UserID "
                + "INNER JOIN Clubs c ON m.ClubID = c.ClubID "
                + "WHERE m.JoinStatus = 'Pending' "
                + "ORDER BY m.JoinedAt DESC";

        try {
            // Thực thi câu lệnh SQL
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Duyệt qua từng dòng kết quả
            while (rs.next()) {
                // Tạo đối tượng Member và set các thuộc tính
                Member member = new Member();
                member.setMemberID(rs.getInt("MemberID"));      // ID thành viên
                member.setUserID(rs.getInt("UserID"));          // ID người dùng
                member.setClubID(rs.getInt("ClubID"));          // ID câu lạc bộ
                member.setJoinStatus(rs.getString("JoinStatus")); // Trạng thái
                member.setJoinedAt(rs.getTimestamp("JoinedAt")); // Ngày tham gia
                member.setUserName(rs.getString("UserName"));    // Tên người dùng
                member.setEmail(rs.getString("Email"));          // Email
                member.setClubName(rs.getString("ClubName"));    // Tên CLB
                members.add(member);
            }
        } catch (SQLException e) {
            // In lỗi nếu có vấn đề khi truy vấn
            e.printStackTrace();
        }
        return members; // Trả về danh sách thành viên
    }

    /**
     * Lấy danh sách sự kiện đang chờ duyệt
     * =================================
     * Input: Không có
     * 
     * Output:
     * - List<Event>: Danh sách các sự kiện đang chờ duyệt
     * - Mỗi Event chứa:
     *   + Thông tin sự kiện (ID, tên, mô tả, thời gian...)
     *   + Thông tin CLB tổ chức (tên CLB)
     * 
     * SQL:
     * - Join bảng Events với Clubs
     * - Lọc theo trạng thái "Pending"
     * - Sắp xếp theo thời gian tạo mới nhất
     */
    public List<Event> getPendingEvents() {
        List<Event> events = new ArrayList<>();
        
        // Câu lệnh SQL:
        // - Lấy tất cả thông tin từ Events (e.*)
        // - Kèm theo tên CLB từ bảng Clubs
        // - Chỉ lấy các sự kiện đang chờ duyệt
        // - Sắp xếp theo thời gian tạo mới nhất
        String sql = "SELECT e.*, c.ClubName FROM Events e "
                + "INNER JOIN Clubs c ON e.ClubID = c.ClubID "
                + "WHERE e.Status = 'Pending' "
                + "ORDER BY e.CreatedAt DESC";

        try {
            // Thực thi câu lệnh SQL
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Duyệt qua từng dòng kết quả
            while (rs.next()) {
                // Tạo đối tượng Event và set các thuộc tính
                Event event = new Event();
                event.setEventID(rs.getInt("EventID"));         // ID sự kiện
                event.setClubID(rs.getInt("ClubID"));          // ID câu lạc bộ
                event.setEventName(rs.getString("EventName"));  // Tên sự kiện
                event.setDescription(rs.getString("Description")); // Mô tả
                event.setEventDate(rs.getTimestamp("EventDate")); // Thời gian tổ chức
                event.setStatus(rs.getString("Status"));        // Trạng thái
                event.setClubName(rs.getString("ClubName"));    // Tên CLB
                events.add(event);
            }
        } catch (SQLException e) {
            // In lỗi nếu có vấn đề khi truy vấn
            e.printStackTrace();
        }
        return events; // Trả về danh sách sự kiện
    }

    /**
     * Duyệt sự kiện
     * ===========
     * Input:
     * - eventId: Mã sự kiện cần duyệt
     * 
     * Output:
     * - true: Nếu duyệt thành công
     * - false: Nếu có lỗi xảy ra
     * 
     * Xử lý:
     * - Cập nhật trạng thái sự kiện thành "Approved"
     */
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

    /**
     * Lấy thống kê tổng quan cho Admin Dashboard
     * =====================================
     * Input: Không có
     * 
     * Output:
     * - AdminStats object chứa các thống kê:
     *   + Số CLB đang chờ duyệt
     *   + Số thành viên đang chờ duyệt
     *   + Số sự kiện đang chờ duyệt
     *   + Tổng số người dùng đang hoạt động
     * 
     * SQL:
     * - 4 câu query riêng biệt để đếm số lượng
     * - Mỗi query tập trung vào 1 khía cạnh cụ thể
     * - Kết quả được tổng hợp vào đối tượng AdminStats
     */
    public AdminStats getAdminStats() {
        AdminStats stats = new AdminStats();
        try {
            // 1. Đếm số CLB đang chờ duyệt
            // - Lọc theo Status = 'Pending'
            String sql1 = "SELECT COUNT(*) FROM Clubs WHERE Status = 'Pending'";
            PreparedStatement ps1 = connection.prepareStatement(sql1);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                stats.setPendingClubs(rs1.getInt(1));
            }

            // 2. Đếm số thành viên đang chờ duyệt
            // - Lọc theo JoinStatus = 'Pending'
            String sql2 = "SELECT COUNT(*) FROM Members WHERE JoinStatus = 'Pending'";
            PreparedStatement ps2 = connection.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                stats.setPendingMembers(rs2.getInt(1));
            }

            // 3. Đếm số sự kiện đang chờ duyệt
            // - Lọc theo Status = 'Pending'
            String sql3 = "SELECT COUNT(*) FROM Events WHERE Status = 'Pending'";
            PreparedStatement ps3 = connection.prepareStatement(sql3);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                stats.setPendingEvents(rs3.getInt(1));
            }

            // 4. Đếm tổng số người dùng đang hoạt động
            // - Lọc theo Status = 1 (active)
            String sql4 = "SELECT COUNT(*) FROM Users WHERE Status = 1";
            PreparedStatement ps4 = connection.prepareStatement(sql4);
            ResultSet rs4 = ps4.executeQuery();
            if (rs4.next()) {
                stats.setTotalUsers(rs4.getInt(1));
            }

        } catch (SQLException e) {
            // In lỗi nếu có vấn đề khi truy vấn
            e.printStackTrace();
        }
        return stats; // Trả về đối tượng chứa các thống kê
    }
}
