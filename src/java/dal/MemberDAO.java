package dal;

import model.Member;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO extends DBContext {

    public Member getMemberById(int memberId) {
        String sql = "SELECT m.*, c.ClubName FROM Members m "
                + "INNER JOIN Clubs c ON m.ClubID = c.ClubID "
                + "WHERE m.MemberID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Member member = new Member();
                member.setMemberID(rs.getInt("MemberID"));
                member.setUserID(rs.getInt("UserID"));
                member.setClubID(rs.getInt("ClubID"));
                member.setJoinStatus(rs.getString("JoinStatus"));
                member.setJoinedAt(rs.getTimestamp("JoinedAt"));
                member.setClubName(rs.getString("ClubName"));
                return member;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Member> getPendingMembersByClub(int clubId) {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT m.*, u.UserName, u.Email FROM Members m "
                + "INNER JOIN Users u ON m.UserID = u.UserID "
                + "WHERE m.ClubID = ? AND m.JoinStatus = 'Pending' "
                + "ORDER BY m.JoinedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
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
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    // Join club
    public boolean joinClub(int userId, int clubId) {
        String sql = "INSERT INTO Members (UserID, ClubID, JoinStatus) VALUES (?, ?, 'Pending')";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, clubId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check if user is member of club
    public boolean isMember(int userId, int clubId) {
        String sql = "SELECT COUNT(*) FROM Members WHERE UserID = ? AND ClubID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, clubId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get user's clubs
    public List<Member> getUserClubs(int userId) {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT m.*, c.ClubName FROM Members m "
                + "INNER JOIN Clubs c ON m.ClubID = c.ClubID "
                + "WHERE m.UserID = ? ORDER BY m.JoinedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Member member = new Member();
                member.setMemberID(rs.getInt("MemberID"));
                member.setUserID(rs.getInt("UserID"));
                member.setClubID(rs.getInt("ClubID"));
                member.setJoinStatus(rs.getString("JoinStatus"));
                member.setJoinedAt(rs.getTimestamp("JoinedAt"));
                member.setClubName(rs.getString("ClubName"));
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    // Get club members
    public List<Member> getClubMembers(int clubId) {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT m.*, u.UserName, u.Email FROM Members m "
                + "INNER JOIN Users u ON m.UserID = u.UserID "
                + "WHERE m.ClubID = ? AND m.JoinStatus = 'Approved' "
                + "ORDER BY m.JoinedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, clubId);
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
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    // Approve member
    public boolean approveMember(int memberId) {
        String sql = "UPDATE Members SET JoinStatus = 'Approved' WHERE MemberID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, memberId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Reject member
    public boolean rejectMember(int memberId) {
        String sql = "UPDATE Members SET JoinStatus = 'Rejected' WHERE MemberID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, memberId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // Thêm các methods này vào MemberDAO.java

// Get member count by club ID (only approved members)
    public int getMemberCountByClubId(int clubId) {
        String sql = "SELECT COUNT(*) FROM Members "
                + "WHERE ClubID = ? AND JoinStatus = 'Approved'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting member count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

// Check if user is a member of club
    public boolean checkMember(int clubId, int userId) {
        String sql = "SELECT COUNT(*) FROM ClubMembers "
                + "WHERE ClubID = ? AND UserID = ? AND Status = 'Approved'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking if user is member: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

// Check if user has pending membership request
    public boolean isPendingMember(int clubId, int userId) {
        String sql = "SELECT COUNT(*) FROM ClubMembers "
                + "WHERE ClubID = ? AND UserID = ? AND Status = 'Pending'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking pending membership: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}
