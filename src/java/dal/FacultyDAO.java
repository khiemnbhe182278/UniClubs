package dal;

import model.*;
import java.sql.*;
import java.util.*;

public class FacultyDAO extends DBContext {

    // ===== EXISTING METHODS (giữ nguyên) =====
    // Get all clubs supervised by a faculty
    public List<Club> getClubsByFaculty(int facultyID) {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, c.Status, "
                + "c.CreatedAt, c.LeaderID, c.CategoryID, cat.CategoryName, "
                + "(SELECT COUNT(*) FROM Members WHERE ClubID = c.ClubID AND JoinStatus = 'Approved') as MemberCount "
                + "FROM Clubs c "
                + "LEFT JOIN ClubCategories cat ON c.CategoryID = cat.CategoryID "
                + "WHERE c.FacultyID = ? "
                + "ORDER BY c.CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, facultyID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setLogo(rs.getString("Logo"));
                club.setStatus(rs.getString("Status"));
                club.setCreatedAt(rs.getTimestamp("CreatedAt"));
                club.setLeaderID(rs.getInt("LeaderID"));
                club.setCategoryID(rs.getInt("CategoryID"));
                club.setCategoryName(rs.getString("CategoryName"));
                club.setMemberCount(rs.getInt("MemberCount"));
                clubs.add(club);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    // ===== NEW METHOD: Get single club by ID =====
    public Club getClubById(int clubID) {
        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, c.Status, "
                + "c.CreatedAt, c.LeaderID, c.FacultyID, c.CategoryID, cat.CategoryName, "
                + "u.UserName as LeaderName, "
                + "(SELECT COUNT(*) FROM Members WHERE ClubID = c.ClubID AND JoinStatus = 'Approved') as MemberCount "
                + "FROM Clubs c "
                + "LEFT JOIN ClubCategories cat ON c.CategoryID = cat.CategoryID "
                + "LEFT JOIN Users u ON c.LeaderID = u.UserID "
                + "WHERE c.ClubID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Club club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setLogo(rs.getString("Logo"));
                club.setStatus(rs.getString("Status"));
                club.setCreatedAt(rs.getTimestamp("CreatedAt"));
                club.setLeaderID(rs.getInt("LeaderID"));
                club.setFacultyID(rs.getInt("FacultyID"));
                club.setCategoryID(rs.getInt("CategoryID"));
                club.setCategoryName(rs.getString("CategoryName"));
                club.setLeaderName(rs.getString("LeaderName"));
                club.setMemberCount(rs.getInt("MemberCount"));
                return club;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all events from clubs supervised by faculty
    public List<Event> getEventsByFaculty(int facultyID) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.EventID, e.ClubID, e.EventName, e.Description, "
                + "e.EventDate, e.Status, e.Location, e.MaxParticipants, "
                + "e.RegistrationDeadline, e.EventImage, e.CreatedAt, "
                + "c.ClubName, "
                + "(SELECT COUNT(*) FROM EventParticipants WHERE EventID = e.EventID) as CurrentParticipants "
                + "FROM Events e "
                + "INNER JOIN Clubs c ON e.ClubID = c.ClubID "
                + "WHERE c.FacultyID = ? "
                + "ORDER BY e.EventDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, facultyID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt("EventID"));
                event.setClubID(rs.getInt("ClubID"));
                event.setEventName(rs.getString("EventName"));
                event.setDescription(rs.getString("Description"));
                event.setEventDate(rs.getTimestamp("EventDate"));
                event.setStatus(rs.getString("Status"));
                event.setLocation(rs.getString("Location"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setRegistrationDeadline(rs.getTimestamp("RegistrationDeadline"));
                event.setEventImage(rs.getString("EventImage"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setClubName(rs.getString("ClubName"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // ===== NEW METHOD: Get pending events only =====
    public List<Event> getPendingEventsByFaculty(int facultyID) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.EventID, e.ClubID, e.EventName, e.Description, "
                + "e.EventDate, e.Status, e.Location, e.MaxParticipants, "
                + "e.RegistrationDeadline, e.EventImage, e.CreatedAt, "
                + "c.ClubName, "
                + "(SELECT COUNT(*) FROM EventParticipants WHERE EventID = e.EventID) as CurrentParticipants "
                + "FROM Events e "
                + "INNER JOIN Clubs c ON e.ClubID = c.ClubID "
                + "WHERE c.FacultyID = ? AND e.Status = 'Pending' "
                + "ORDER BY e.CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, facultyID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Event event = new Event();
                event.setEventID(rs.getInt("EventID"));
                event.setClubID(rs.getInt("ClubID"));
                event.setEventName(rs.getString("EventName"));
                event.setDescription(rs.getString("Description"));
                event.setEventDate(rs.getTimestamp("EventDate"));
                event.setStatus(rs.getString("Status"));
                event.setLocation(rs.getString("Location"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setRegistrationDeadline(rs.getTimestamp("RegistrationDeadline"));
                event.setEventImage(rs.getString("EventImage"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setClubName(rs.getString("ClubName"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // Get pending members for faculty's clubs
    public List<Member> getPendingMembersByFaculty(int facultyID) {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT m.MemberID, m.UserID, m.ClubID, m.JoinStatus, m.JoinedAt, "
                + "u.UserName, u.Email, u.FullName, u.StudentID, u.Faculty, "
                + "c.ClubName "
                + "FROM Members m "
                + "INNER JOIN Users u ON m.UserID = u.UserID "
                + "INNER JOIN Clubs c ON m.ClubID = c.ClubID "
                + "WHERE c.FacultyID = ? AND m.JoinStatus = 'Pending' "
                + "ORDER BY m.JoinedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, facultyID);
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
                member.setFullName(rs.getString("FullName"));
                member.setStudentID(rs.getString("StudentID"));
                member.setFaculty(rs.getString("Faculty"));
                member.setClubName(rs.getString("ClubName"));
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    // Get all news from faculty's clubs
    public List<News> getNewsByFaculty(int facultyID, String status) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.NewsID, n.ClubID, n.Title, n.Content, n.Status, "
                + "n.CreatedAt, c.ClubName "
                + "FROM News n "
                + "INNER JOIN Clubs c ON n.ClubID = c.ClubID "
                + "WHERE c.FacultyID = ? "
                + (status != null ? "AND n.Status = ? " : "")
                + "ORDER BY n.CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, facultyID);
            if (status != null) {
                ps.setString(2, status);
            }
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setClubID(rs.getInt("ClubID"));
                news.setTitle(rs.getString("Title"));
                news.setContent(rs.getString("Content"));
                news.setStatus(rs.getString("Status"));
                news.setCreatedAt(rs.getTimestamp("CreatedAt"));
                news.setClubName(rs.getString("ClubName"));
                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }

    // Approve/Reject member
    public boolean updateMemberStatus(int memberID, String status) {
        String sql = "UPDATE Members SET JoinStatus = ? WHERE MemberID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, memberID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Approve/Reject event
    public boolean updateEventStatus(int eventID, String status) {
        String sql = "UPDATE Events SET Status = ? WHERE EventID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, eventID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Approve/Reject news
    public boolean updateNewsStatus(int newsID, String status) {
        String sql = "UPDATE News SET Status = ? WHERE NewsID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, newsID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get faculty dashboard statistics
    public Map<String, Integer> getFacultyStatistics(int facultyID) {
        Map<String, Integer> stats = new HashMap<>();

        try {
            // Total clubs
            String sql1 = "SELECT COUNT(*) FROM Clubs WHERE FacultyID = ?";
            PreparedStatement ps1 = connection.prepareStatement(sql1);
            ps1.setInt(1, facultyID);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                stats.put("totalClubs", rs1.getInt(1));
            }

            // Total members
            String sql2 = "SELECT COUNT(*) FROM Members m "
                    + "INNER JOIN Clubs c ON m.ClubID = c.ClubID "
                    + "WHERE c.FacultyID = ? AND m.JoinStatus = 'Approved'";
            PreparedStatement ps2 = connection.prepareStatement(sql2);
            ps2.setInt(1, facultyID);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                stats.put("totalMembers", rs2.getInt(1));
            }

            // Pending members
            String sql3 = "SELECT COUNT(*) FROM Members m "
                    + "INNER JOIN Clubs c ON m.ClubID = c.ClubID "
                    + "WHERE c.FacultyID = ? AND m.JoinStatus = 'Pending'";
            PreparedStatement ps3 = connection.prepareStatement(sql3);
            ps3.setInt(1, facultyID);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                stats.put("pendingMembers", rs3.getInt(1));
            }

            // Total events
            String sql4 = "SELECT COUNT(*) FROM Events e "
                    + "INNER JOIN Clubs c ON e.ClubID = c.ClubID "
                    + "WHERE c.FacultyID = ?";
            PreparedStatement ps4 = connection.prepareStatement(sql4);
            ps4.setInt(1, facultyID);
            ResultSet rs4 = ps4.executeQuery();
            if (rs4.next()) {
                stats.put("totalEvents", rs4.getInt(1));
            }

            // Pending events
            String sql5 = "SELECT COUNT(*) FROM Events e "
                    + "INNER JOIN Clubs c ON e.ClubID = c.ClubID "
                    + "WHERE c.FacultyID = ? AND e.Status = 'Pending'";
            PreparedStatement ps5 = connection.prepareStatement(sql5);
            ps5.setInt(1, facultyID);
            ResultSet rs5 = ps5.executeQuery();
            if (rs5.next()) {
                stats.put("pendingEvents", rs5.getInt(1));
            }

            // Pending news
            String sql6 = "SELECT COUNT(*) FROM News n "
                    + "INNER JOIN Clubs c ON n.ClubID = c.ClubID "
                    + "WHERE c.FacultyID = ? AND n.Status = 'Pending'";
            PreparedStatement ps6 = connection.prepareStatement(sql6);
            ps6.setInt(1, facultyID);
            ResultSet rs6 = ps6.executeQuery();
            if (rs6.next()) {
                stats.put("pendingNews", rs6.getInt(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    // Get event participants for faculty's events
    public List<EventParticipant> getEventParticipants(int eventID) {
        List<EventParticipant> participants = new ArrayList<>();
        String sql = "SELECT ep.ParticipantID, ep.EventID, ep.UserID, "
                + "ep.RegistrationDate, ep.AttendanceStatus, "
                + "u.UserName, u.Email, e.EventName "
                + "FROM EventParticipants ep "
                + "INNER JOIN Users u ON ep.UserID = u.UserID "
                + "INNER JOIN Events e ON ep.EventID = e.EventID "
                + "WHERE ep.EventID = ? "
                + "ORDER BY ep.RegistrationDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventID);
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
                participant.setEventName(rs.getString("EventName"));
                participants.add(participant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return participants;
    }

    // Update attendance status
    public boolean updateAttendanceStatus(int participantID, String status) {
        String sql = "UPDATE EventParticipants SET AttendanceStatus = ? WHERE ParticipantID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, participantID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get club rules
    public List<Rule> getClubRules(int clubID) {
        List<Rule> rules = new ArrayList<>();
        String sql = "SELECT RuleID, ClubID, Title, RuleText, CreatedAt "
                + "FROM Rules WHERE ClubID = ? ORDER BY CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Rule rule = new Rule();
                rule.setRuleID(rs.getInt("RuleID"));
                rule.setClubID(rs.getInt("ClubID"));
                rule.setTitle(rs.getString("Title"));
                rule.setRuleText(rs.getString("RuleText"));
                rule.setCreatedDate(rs.getTimestamp("CreatedAt"));
                rules.add(rule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rules;
    }
}
