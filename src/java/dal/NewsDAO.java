package dal;

import model.News;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

public class NewsDAO extends DBContext {

    // Phương thức tạo tin tức mới
    public List<News> getNewsByClubId(int clubId) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.*, c.ClubName FROM News n "
                + "LEFT JOIN Clubs c ON n.ClubID = c.ClubID "
                + "WHERE n.ClubID = ? "
                + "ORDER BY n.CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
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
            System.err.println("Error getting news by club ID: " + e.getMessage());
            e.printStackTrace();
        }

        return newsList;
    }

    // Get news by ID
    public News getNewsById(int newsId) {
        String sql = "SELECT n.*, c.ClubName FROM News n "
                + "LEFT JOIN Clubs c ON n.ClubID = c.ClubID "
                + "WHERE n.NewsID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newsId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setClubID(rs.getInt("ClubID"));
                news.setTitle(rs.getString("Title"));
                news.setContent(rs.getString("Content"));
                news.setStatus(rs.getString("Status"));
                news.setCreatedAt(rs.getTimestamp("CreatedAt"));
                news.setClubName(rs.getString("ClubName"));
                return news;
            }
        } catch (SQLException e) {
            System.err.println("Error getting news by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Create new news
    public boolean createNews(News news) {
        String sql = "INSERT INTO News (ClubID, Title, Content, Status, CreatedAt) "
                + "VALUES (?, ?, ?, ?, GETDATE())";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, news.getClubID());
            ps.setString(2, news.getTitle());
            ps.setString(3, news.getContent());
            ps.setString(4, news.getStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating news: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Update news
    public boolean updateNews(News news) {
        String sql = "UPDATE News SET Title = ?, Content = ?, Status = ? "
                + "WHERE NewsID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getStatus());
            ps.setInt(4, news.getNewsID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating news: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Delete news
    public boolean deleteNews(int newsId) {
        String sql = "DELETE FROM News WHERE NewsID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newsId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting news: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get all published news
    public List<News> getAllPublishedNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.*, c.ClubName FROM News n "
                + "LEFT JOIN Clubs c ON n.ClubID = c.ClubID "
                + "WHERE n.Status = 'Published' "
                + "ORDER BY n.CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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
            System.err.println("Error getting published news: " + e.getMessage());
            e.printStackTrace();
        }

        return newsList;

    }

    public List<News> getPublishedNewsByClubId(int clubId) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.*, c.ClubName FROM News n "
                + "LEFT JOIN Clubs c ON n.ClubID = c.ClubID "
                + "WHERE n.ClubID = ? AND n.Status = 'Published' "
                + "ORDER BY n.CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clubId);
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
            System.err.println("Error getting published news by club ID: " + e.getMessage());
            e.printStackTrace();
        }

        return newsList;
    }

    public List<News> getLatestNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) n.NewsID, n.ClubID, n.Title, n.Content, "
                + "n.Status, n.CreatedAt, c.ClubName "
                + "FROM News n "
                + "INNER JOIN Clubs c ON n.ClubID = c.ClubID "
                + "WHERE n.Status = 'Published' "
                + "ORDER BY n.CreatedAt DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
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
}
