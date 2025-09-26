package dal;

import model.News;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

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
}
