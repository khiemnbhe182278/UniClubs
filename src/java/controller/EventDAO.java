/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.Event;
import model.News;

/**
 *
 * @author duyhv
 */
public class EventDAO extends DBContext {

    public Event getEventByID(int eventID) {
        String sql = "SELECT * FROM Events WHERE EventID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, eventID);
            try (ResultSet rs = st.executeQuery()) {
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
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
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

    public boolean createEvent(Event e) {
        String sql = "INSERT INTO Events (ClubID, EventName, Description, EventDate, Status, CreatedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, e.getClubID());
            st.setString(2, e.getEventName());
            st.setString(3, e.getDescription());
            st.setTimestamp(4, e.getEventDate());
            st.setString(5, e.getStatus());
            st.setTimestamp(6, e.getCreatedAt());

            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0; // Returns true if one or more rows were inserted
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false; // Returns false if an exception occurred
        }
    }

    public boolean updateEvent(Event e, int eventID) {
        String sql = "UPDATE Events SET EventName = ?, Description = ?, EventDate = ? WHERE EventID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, e.getEventName());
            st.setString(2, e.getDescription());
            st.setTimestamp(3, e.getEventDate());
            st.setInt(4, eventID);

            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM Events ORDER BY CreatedAt DESC";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Event e = new Event(
                        rs.getInt("EventID"),
                        rs.getInt("ClubID"),
                        rs.getString("EventName"),
                        rs.getString("Description"),
                        rs.getTimestamp("EventDate"),
                        rs.getString("Status"),
                        rs.getTimestamp("CreatedAt")
                );
                list.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
}
