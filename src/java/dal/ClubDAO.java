package dal;

import model.Club;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Event;
import model.News;
import model.Stats;
import model.User;

/**
 * ClubDAO - Người Quản Lý Câu Lạc Bộ
 * ================================
 * 
 * 1. Nhiệm Vụ Chính
 *    - Là "thủ quỹ và thư ký" của tất cả câu lạc bộ:
 *      + Lưu trữ thông tin câu lạc bộ
 *      + Quản lý danh sách thành viên
 *      + Theo dõi hoạt động và sự kiện
 *      + Thống kê và báo cáo
 * 
 * 2. Các Công Việc Hàng Ngày
 *    a. Quản Lý Thông Tin CLB:
 *       - Tạo câu lạc bộ mới
 *       - Cập nhật thông tin
 *       - Kiểm tra trạng thái hoạt động
 * 
 *    b. Quản Lý Thành Viên:
 *       - Thêm thành viên mới
 *       - Cập nhật vai trò
 *       - Kiểm tra tư cách thành viên
 * 
 *    c. Theo Dõi Hoạt Động:
 *       - Lưu trữ lịch sự kiện
 *       - Ghi nhận tin tức, thông báo
 *       - Thống kê tham gia
 * 
 * 3. Cách Làm Việc
 *    - Giống như một "hệ thống quản lý văn phòng":
 *      + Hồ sơ câu lạc bộ: lưu trong bảng Clubs
 *      + Danh sách thành viên: bảng Members
 *      + Lịch sự kiện: bảng Events
 *      + Tin tức: bảng News
 * 
 * 4. Ví Dụ Thực Tế
 *    - Như văn phòng quản lý của trường học:
 *      + Lưu hồ sơ các lớp học
 *      + Quản lý danh sách học sinh
 *      + Theo dõi các hoạt động
 *      + Lập báo cáo định kỳ
 * 
 * 5. Bảo Mật
 *    - Như "két sắt" bảo vệ thông tin:
 *      + Mã hóa thông tin nhạy cảm
 *      + Kiểm tra quyền truy cập
 *      + Chỉ chia sẻ thông tin cần thiết
 *
 * EN: Data Access Object for club-related database operations.
 * - Inherits DBContext which provides a `connection` to the database.
 * - Methods return model objects (Club, User, Stats) or counts/booleans for actions.
 * - Security note: avoid exposing sensitive fields and let caller handle presentation.
 */
public class ClubDAO extends DBContext {

    /**
     * getClubLeader
     * ----------------
     * VN: Trả về đối tượng User đại diện cho leader của CLB (nếu có).
     * - Input: clubId (ClubID)
     * - Output: User object của leader hoặc null nếu không tìm thấy
     * - SQL: join giữa Users và ClubMembers, lọc Role = 'Leader' và Status = 'Approved'
     *
     * EN: Returns the User who is the leader of the club.
     * - Input: clubId
     * - Output: User for leader, or null if none found
     * - The query joins Users and ClubMembers, filters Role='Leader' and approved membership.
     */
    public User getClubLeader(int clubId) {
        String sql = "SELECT u.* FROM Users u "
                + "INNER JOIN ClubMembers cm ON u.UserID = cm.UserID "
                + "WHERE cm.ClubID = ? AND cm.Role = 'Leader' AND cm.Status = 'Approved'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("Email"));
                user.setRoleID(rs.getInt("RoleID"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error getting club leader: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

// Get club faculty/advisor
    public User getClubFaculty(int clubId) {
        String sql = "SELECT u.* FROM Users u "
                + "INNER JOIN Clubs c ON u.UserID = c.FacultyID "
                + "WHERE c.ClubID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("Email"));
                user.setRoleID(rs.getInt("RoleID"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error getting club faculty: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public boolean updateClub(Club club) {
        String sql = "UPDATE Clubs SET ClubName = ?, Description = ?, CategoryID = ?, "
                + "UpdatedAt = GETDATE() WHERE ClubID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, club.getClubName());
            ps.setString(2, club.getDescription());
            if (club.getCategoryID() > 0) {
                ps.setInt(3, club.getCategoryID());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.setInt(4, club.getClubID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getMemberCount(int clubId) {
        String sql = "SELECT COUNT(*) FROM Members WHERE ClubID = ? AND JoinStatus = 'Approved'";
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

    public int getNewMembersCount(int clubId, int days) {
        String sql = "SELECT COUNT(*) FROM Members "
                + "WHERE ClubID = ? AND JoinStatus = 'Approved' "
                + "AND JoinedAt >= DATEADD(day, -?, GETDATE())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            ps.setInt(2, days);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getPendingMembersCount(int clubId) {
        String sql = "SELECT COUNT(*) FROM Members WHERE ClubID = ? AND JoinStatus = 'Pending'";
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

// EventDAO.java
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

    public List<Club> advancedSearch(String keyword, String category, int minMembers, String sortBy) {
        List<Club> clubs = new ArrayList<>();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT c.ClubID, c.ClubName, c.Description, c.Logo, c.Status, ");
        sql.append("COUNT(DISTINCT m.MemberID) as MemberCount ");
        sql.append("FROM Clubs c ");
        sql.append("LEFT JOIN Members m ON c.ClubID = m.ClubID AND m.JoinStatus = 'Approved' ");
        sql.append("WHERE c.Status = 'Active' ");

        List<String> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (c.ClubName LIKE ? OR c.Description LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        sql.append("GROUP BY c.ClubID, c.ClubName, c.Description, c.Logo, c.Status ");

        if (minMembers > 0) {
            sql.append("HAVING COUNT(DISTINCT m.MemberID) >= ? ");
            params.add(String.valueOf(minMembers));
        }

        // Sort
        if ("members".equals(sortBy)) {
            sql.append("ORDER BY MemberCount DESC");
        } else if ("newest".equals(sortBy)) {
            sql.append("ORDER BY c.CreatedAt DESC");
        } else {
            sql.append("ORDER BY c.ClubName ASC");
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setLogo(rs.getString("Logo"));
                club.setStatus(rs.getString("Status"));
                club.setMemberCount(rs.getInt("MemberCount"));
                clubs.add(club);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    public List<Club> getFeaturedClubs(int limit) {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT TOP (?) c.ClubID, c.ClubName, c.Description, c.Logo, "
                + "COUNT(DISTINCT m.MemberID) as MemberCount "
                + "FROM Clubs c "
                + "LEFT JOIN Members m ON c.ClubID = m.ClubID AND m.JoinStatus = 'Approved' "
                + "WHERE c.Status = 'Active' "
                + "GROUP BY c.ClubID, c.ClubName, c.Description, c.Logo "
                + "ORDER BY MemberCount DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setLogo(rs.getString("Logo"));
                club.setMemberCount(rs.getInt("MemberCount"));
                clubs.add(club);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    public List<Club> getAllActiveClubs() {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, c.Status, "
                + "COUNT(DISTINCT m.MemberID) as MemberCount "
                + "FROM Clubs c "
                + "LEFT JOIN Members m ON c.ClubID = m.ClubID AND m.JoinStatus = 'Approved' "
                + "WHERE c.Status = 'Active' "
                + "GROUP BY c.ClubID, c.ClubName, c.Description, c.Logo, c.Status "
                + "ORDER BY c.ClubName";

        try {
            if (connection == null) {
                System.out.println("ERROR: Database connection is null!");
                return clubs;
            }

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            System.out.println("Executing query: " + sql);

            while (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setLogo(rs.getString("Logo"));
                club.setStatus(rs.getString("Status"));
                club.setMemberCount(rs.getInt("MemberCount"));
                clubs.add(club);

                System.out.println("Found club: " + club.getClubName());
            }

            System.out.println("Total clubs found: " + clubs.size());

        } catch (SQLException e) {
            System.err.println("SQL Error in getAllActiveClubs: " + e.getMessage());
            e.printStackTrace();
        }
        return clubs;
    }

    public Stats getStats() {
        Stats stats = new Stats();

        try {
            // Total active clubs
            String sql1 = "SELECT COUNT(*) as total FROM Clubs WHERE Status = 'Active'";
            PreparedStatement ps1 = connection.prepareStatement(sql1);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                stats.setTotalClubs(rs1.getInt("total"));
            }

            // Total approved members
            String sql2 = "SELECT COUNT(DISTINCT UserID) as total FROM Members WHERE JoinStatus = 'Approved'";
            PreparedStatement ps2 = connection.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                stats.setTotalMembers(rs2.getInt("total"));
            }

            // Total events this year
            String sql3 = "SELECT COUNT(*) as total FROM Events WHERE YEAR(EventDate) = YEAR(GETDATE())";
            PreparedStatement ps3 = connection.prepareStatement(sql3);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                stats.setTotalEvents(rs3.getInt("total"));
            }

            // Satisfaction rate (can be calculated from surveys/ratings - using dummy for now)
            stats.setSatisfactionRate(98.0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return stats;
    }

    // Search clubs
    public List<Club> searchClubs(String keyword) {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, "
                + "COUNT(DISTINCT m.MemberID) as MemberCount "
                + "FROM Clubs c "
                + "LEFT JOIN Members m ON c.ClubID = m.ClubID AND m.JoinStatus = 'Approved' "
                + "WHERE c.Status = 'Active' AND "
                + "(c.ClubName LIKE ? OR c.Description LIKE ?) "
                + "GROUP BY c.ClubID, c.ClubName, c.Description, c.Logo "
                + "ORDER BY c.ClubName";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setLogo(rs.getString("Logo"));
                club.setMemberCount(rs.getInt("MemberCount"));
                clubs.add(club);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    public boolean createClub(Club club) {
        String sql = "INSERT INTO Clubs (ClubName, Description, FacultyID, LeaderID, Status) "
                + "VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, club.getClubName());
            ps.setString(2, club.getDescription());
            ps.setInt(3, club.getFacultyID());
            ps.setInt(4, club.getLeaderID());
            ps.setString(5, club.getStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
// Get club by ID

    public List<Club> getUserLeadClubs(int userId) {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT c.* FROM Clubs c "
                + "WHERE c.LeaderID = ? AND c.Status = 'Active' "
                + "ORDER BY c.ClubName";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setStatus(rs.getString("Status"));
                clubs.add(club);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    public Club getClubById(int clubId) {
        String sql = "SELECT c.*, COUNT(DISTINCT m.MemberID) as MemberCount "
                + "FROM Clubs c "
                + "LEFT JOIN Members m ON c.ClubID = m.ClubID "
                + "WHERE c.ClubID = ? "
                + "GROUP BY c.ClubID, c.ClubName, c.Description, c.Logo, c.FacultyID, "
                + "c.LeaderID, c.Status, c.CreatedAt, c.UpdatedAt, c.CategoryID";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setLogo(rs.getString("Logo"));
                club.setStatus(rs.getString("Status"));
                club.setMemberCount(rs.getInt("MemberCount"));
                return club;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Event> getEventsByClub(int clubID) {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT EventID, ClubID, EventName, Description, EventDate, Status, CreatedAt "
                + "FROM Events WHERE ClubID = ? ORDER BY EventDate DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt("EventID"));
                event.setClubID(rs.getInt("ClubID"));
                event.setEventName(rs.getString("EventName"));
                event.setDescription(rs.getString("Description"));
                event.setEventDate(rs.getTimestamp("EventDate"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<News> getNewsByClub(int clubID) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT NewsID, ClubID, Title, Content, Status, CreatedAt "
                + "FROM News WHERE ClubID = ? ORDER BY CreatedAt DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setClubID(rs.getInt("ClubID"));
                news.setTitle(rs.getString("Title"));
                news.setContent(rs.getString("Content"));
                news.setStatus(rs.getString("Status"));
                news.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(news);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Event getUpcomingEvent(int clubID) {
        String sql = "SELECT TOP 1 EventID, ClubID, EventName, Description, EventDate, Status, CreatedAt "
                + "FROM Events WHERE ClubID = ? AND EventDate > GETDATE() AND Status = 'Approved' "
                + "ORDER BY EventDate ASC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt("EventID"));
                event.setClubID(rs.getInt("ClubID"));
                event.setEventName(rs.getString("EventName"));
                event.setDescription(rs.getString("Description"));
                event.setEventDate(rs.getTimestamp("EventDate"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return event;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public News getLatestNews(int clubID) {
        String sql = "SELECT TOP 1 NewsID, ClubID, Title, Content, Status, CreatedAt "
                + "FROM News WHERE ClubID = ? AND Status = 'Approved' ORDER BY CreatedAt DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setClubID(rs.getInt("ClubID"));
                news.setTitle(rs.getString("Title"));
                news.setContent(rs.getString("Content"));
                news.setStatus(rs.getString("Status"));
                news.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return news;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

//    public Club getClubDetail(int clubID) {
//        Club club = null;
//        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, c.Status, "
//                + "c.FacultyID, f.UserName AS FacultyName, "
//                + "c.LeaderID, l.UserName AS LeaderName, "
//                + "c.CreatedAt, c.UpdatedAt "
//                + "FROM Clubs c "
//                + "LEFT JOIN Users f ON c.FacultyID = f.UserID "
//                + "LEFT JOIN Users l ON c.LeaderID = l.UserID "
//                + "WHERE c.ClubID = ?";
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, clubID);
//            ResultSet rs = st.executeQuery();
//            if (rs.next()) {
//                club = new Club();
//                club.setClubID(rs.getInt("ClubID"));
//                club.setClubName(rs.getString("ClubName"));
//                club.setDescription(rs.getString("Description"));
//                club.setLogo(rs.getString("Logo"));
//                club.setStatus(rs.getBoolean("Status"));
//                club.setFacultyID(rs.getInt("FacultyID"));
//                club.setFacultyName(rs.getString("FacultyName"));
//                club.setLeaderID(rs.getInt("LeaderID"));
//                club.setLeaderName(rs.getString("LeaderName"));
//                club.setCreatedAt(rs.getTimestamp("CreatedAt"));
//                club.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return club;
//    }
    public int countMembers(int clubID) {
        String sql = "SELECT COUNT(*) FROM Members WHERE ClubID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countEvents(int clubID) {
        String sql = "SELECT COUNT(*) FROM Events WHERE ClubID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countNews(int clubID) {
        String sql = "SELECT COUNT(*) FROM News WHERE ClubID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

//    public List<UserDTO> getMembers(int clubID) {
//        List<UserDTO> list = new ArrayList<>();
//        String sql = "SELECT u.UserID, u.UserName, u.Email, r.RoleName, m.JoinStatus, m.JoinedAt "
//                + "FROM Members m "
//                + "INNER JOIN Users u ON m.UserID = u.UserID "
//                + "INNER JOIN Roles r ON u.RoleID = r.RoleID "
//                + "WHERE m.ClubID = ?";
//
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, clubID);
//            ResultSet rs = st.executeQuery();
//
//            System.out.println("Executing query for clubID: " + clubID); // Debug
//
//            while (rs.next()) {
//                UserDTO u = new UserDTO();
//                u.setUserID(rs.getInt("UserID"));
//                u.setUserName(rs.getString("UserName"));
//                u.setEmail(rs.getString("Email"));
//                u.setRole(rs.getString("RoleName"));
//                u.setStatus("Approved".equalsIgnoreCase(rs.getString("JoinStatus"))); // FIX: JoinStatus
//                list.add(u);
//
//                System.out.println("Found member: " + rs.getString("UserName")); // Debug
//            }
//
//            System.out.println("Total members found: " + list.size()); // Debug
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            System.out.println("Error in getMembers for clubID: " + clubID);
//        }
//        return list;
//    }
//    public List<Club> getClubs(String search) {
//        List<Club> list = new ArrayList<>();
//
//        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, "
//                + "f.UserName AS FacultyName, "
//                + "l.UserName AS LeaderName, "
//                + "c.Status, c.CreatedAt, c.UpdatedAt "
//                + "FROM Clubs c "
//                + "LEFT JOIN Users f ON c.FacultyID = f.UserID "
//                + "LEFT JOIN Users l ON c.LeaderID = l.UserID "
//                + "WHERE 1=1 ";
//
//        if (search != null && !search.trim().isEmpty()) {
//            sql += " AND (c.ClubName LIKE ? OR c.Description LIKE ?)";
//        }
//
//        sql += " ORDER BY c.ClubID DESC";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            if (search != null && !search.trim().isEmpty()) {
//                ps.setString(1, "%" + search + "%");
//                ps.setString(2, "%" + search + "%");
//            }
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Club c = new Club();
//                c.setClubID(rs.getInt("ClubID"));
//                c.setClubName(rs.getString("ClubName"));
//                c.setDescription(rs.getString("Description"));
//                c.setLogo(rs.getString("Logo"));
//                c.setFacultyName(rs.getString("FacultyName"));
//                c.setLeaderName(rs.getString("LeaderName"));
//                c.setStatus(rs.getBoolean("Status"));
//                c.setCreatedAt(rs.getTimestamp("CreatedAt"));
//                c.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
//                list.add(c);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
////        }
//
//        return list;
//    }
}
