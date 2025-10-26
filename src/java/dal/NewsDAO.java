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
    public boolean createNews(News n) {
        String sql = "INSERT INTO News (ClubID, Title, Content, Status, CreatedAt) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, n.getClubID());
            st.setString(2, n.getTitle());
            st.setString(3, n.getContent());
            st.setString(4, n.getStatus());
            st.setTimestamp(5, n.getCreatedAt());

            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
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
