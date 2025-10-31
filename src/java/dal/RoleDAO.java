//package dal;
//
//import java.sql.*;
//import java.util.*;
//import model.RoleDTO;
//
//public class RoleDAO extends DBContext {
//
//    public List<RoleDTO> getRolesToCreateUsers() {
//        List<RoleDTO> list = new ArrayList<>();
//        String sql = "SELECT RoleID, RoleName FROM Roles Where RoleID = 2 or RoleID = 3";
//        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//            while (rs.next()) {
//                RoleDTO r = new RoleDTO();
//                r.setRoleID(rs.getInt("RoleID"));
//                r.setRoleName(rs.getString("RoleName"));
//                list.add(r);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
//    
//    
//}
