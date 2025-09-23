package dal;

import model.News;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO extends DBContext {

    // Lấy tất cả news (có tên author)
    public List<News> getAllNews() {
        List<News> list = new ArrayList<>();
        String sql = "SELECT n.*, u.username as author_name " +
                     "FROM news n " +
                     "JOIN users u ON n.author_id = u.id " +
                     "WHERE n.status = 'published' " +
                     "ORDER BY n.publish_date DESC, n.created_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                News news = mapResultSetToNews(rs);
                news.setAuthorName(rs.getString("author_name"));
                list.add(news);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy news theo ID
    public News getNewsById(int id) {
        String sql = "SELECT n.*, u.username as author_name " +
                     "FROM news n " +
                     "JOIN users u ON n.author_id = u.id " +
                     "WHERE n.id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                News news = mapResultSetToNews(rs);
                news.setAuthorName(rs.getString("author_name"));
                return news;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm news mới
    public boolean insertNews(News news) {
        String sql = "INSERT INTO news (title, content, image_url, author_id, publish_date, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getImageUrl());
            ps.setInt(4, news.getAuthorId());
            ps.setDate(5, Date.valueOf(news.getPublishDate()));
            ps.setString(6, news.getStatus());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật news
    public boolean updateNews(News news) {
        String sql = "UPDATE news SET title=?, content=?, image_url=?, publish_date=?, status=?, updated_at=GETDATE() " +
                     "WHERE id=?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getImageUrl());
            ps.setDate(4, Date.valueOf(news.getPublishDate()));
            ps.setString(5, news.getStatus());
            ps.setInt(6, news.getId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa news (soft delete - chuyển status thành draft)
    public boolean deleteNews(int id) {
        String sql = "UPDATE news SET status='draft', updated_at=GETDATE() WHERE id=?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy news theo author
    public List<News> getNewsByAuthor(int authorId) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT n.*, u.username as author_name " +
                     "FROM news n " +
                     "JOIN users u ON n.author_id = u.id " +
                     "WHERE n.author_id = ? " +
                     "ORDER BY n.publish_date DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, authorId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                News news = mapResultSetToNews(rs);
                news.setAuthorName(rs.getString("author_name"));
                list.add(news);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper method: map ResultSet to News object
    private News mapResultSetToNews(ResultSet rs) throws SQLException {
        News news = new News();
        news.setId(rs.getInt("id"));
        news.setTitle(rs.getString("title"));
        news.setContent(rs.getString("content"));
        news.setImageUrl(rs.getString("image_url"));
        news.setAuthorId(rs.getInt("author_id"));
        news.setPublishDate(rs.getDate("publish_date").toLocalDate());
        news.setStatus(rs.getString("status"));
        news.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            news.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        
        return news;
    }

    // Test method
    public static void main(String[] args) {
        NewsDAO dao = new NewsDAO();
        
        // Test getAllNews
        System.out.println("=== All Published News ===");
        List<News> newsList = dao.getAllNews();
        for (News news : newsList) {
            System.out.println("ID: " + news.getId() + 
                             ", Title: " + news.getTitle() +
                             ", Author: " + news.getAuthorName() +
                             ", Date: " + news.getPublishDate());
        }
        
        // Test insert
        News newNews = new News();
        newNews.setTitle("Test News Title");
        newNews.setContent("This is a test news content.");
        newNews.setAuthorId(4); // ID từ bảng users
        newNews.setPublishDate(LocalDate.now());
        newNews.setStatus("published");
        
        boolean result = dao.insertNews(newNews);
        System.out.println("Insert result: " + result);
    }
}