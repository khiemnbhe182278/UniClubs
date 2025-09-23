package dal;

import java.sql.*;
import java.util.*;
import model.Event;

public class EventDAO extends DBContext {

    public List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT id, title, date, location FROM Events";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Event(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("date"),
                        rs.getString("location")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
