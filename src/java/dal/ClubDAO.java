package dal;

import model.Club;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Event;
import model.News;
import model.UserDTO;

public class ClubDAO extends DBContext {
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
    public Club getClubDetail(int clubID) {
        Club club = null;
        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, c.Status, "
                + "c.FacultyID, f.UserName AS FacultyName, "
                + "c.LeaderID, l.UserName AS LeaderName, "
                + "c.CreatedAt, c.UpdatedAt "
                + "FROM Clubs c "
                + "LEFT JOIN Users f ON c.FacultyID = f.UserID "
                + "LEFT JOIN Users l ON c.LeaderID = l.UserID "
                + "WHERE c.ClubID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, clubID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                club = new Club();
                club.setClubID(rs.getInt("ClubID"));
                club.setClubName(rs.getString("ClubName"));
                club.setDescription(rs.getString("Description"));
                club.setLogo(rs.getString("Logo"));
                club.setStatus(rs.getBoolean("Status"));
                club.setFacultyID(rs.getInt("FacultyID"));
                club.setFacultyName(rs.getString("FacultyName"));
                club.setLeaderID(rs.getInt("LeaderID"));
                club.setLeaderName(rs.getString("LeaderName"));
                club.setCreatedAt(rs.getTimestamp("CreatedAt"));
                club.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return club;
    }

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

public List<UserDTO> getMembers(int clubID) {
    List<UserDTO> list = new ArrayList<>();
    String sql = "SELECT u.UserID, u.UserName, u.Email, r.RoleName, m.JoinStatus, m.JoinedAt "
            + "FROM Members m "
            + "INNER JOIN Users u ON m.UserID = u.UserID "
            + "INNER JOIN Roles r ON u.RoleID = r.RoleID "
            + "WHERE m.ClubID = ?";
    
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setInt(1, clubID);
        ResultSet rs = st.executeQuery();
        
        System.out.println("Executing query for clubID: " + clubID); // Debug
        
        while (rs.next()) {
            UserDTO u = new UserDTO();
            u.setUserID(rs.getInt("UserID"));
            u.setUserName(rs.getString("UserName"));
            u.setEmail(rs.getString("Email"));
            u.setRole(rs.getString("RoleName"));
            u.setStatus("Approved".equalsIgnoreCase(rs.getString("JoinStatus"))); // FIX: JoinStatus
            list.add(u);
            
            System.out.println("Found member: " + rs.getString("UserName")); // Debug
        }
        
        System.out.println("Total members found: " + list.size()); // Debug
        
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Error in getMembers for clubID: " + clubID);
    }
    return list;
}

    public List<Club> getClubs(String search) {
        List<Club> list = new ArrayList<>();

        String sql = "SELECT c.ClubID, c.ClubName, c.Description, c.Logo, "
                + "f.UserName AS FacultyName, "
                + "l.UserName AS LeaderName, "
                + "c.Status, c.CreatedAt, c.UpdatedAt "
                + "FROM Clubs c "
                + "LEFT JOIN Users f ON c.FacultyID = f.UserID "
                + "LEFT JOIN Users l ON c.LeaderID = l.UserID "
                + "WHERE 1=1 ";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (c.ClubName LIKE ? OR c.Description LIKE ?)";
        }

        sql += " ORDER BY c.ClubID DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Club c = new Club();
                c.setClubID(rs.getInt("ClubID"));
                c.setClubName(rs.getString("ClubName"));
                c.setDescription(rs.getString("Description"));
                c.setLogo(rs.getString("Logo"));
                c.setFacultyName(rs.getString("FacultyName"));
                c.setLeaderName(rs.getString("LeaderName"));
                c.setStatus(rs.getBoolean("Status"));
                c.setCreatedAt(rs.getTimestamp("CreatedAt"));
                c.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
