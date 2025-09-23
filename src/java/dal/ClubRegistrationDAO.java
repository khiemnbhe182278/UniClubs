package dal;

import model.ClubRegistration;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClubRegistrationDAO extends DBContext {

    // Lấy tất cả đơn đăng ký kèm tên CLB
    public List<ClubRegistration> getAllRegistrations() {
        List<ClubRegistration> list = new ArrayList<>();
        String sql = "SELECT r.*, c.clubName " +
                     "FROM club_registrations r " +
                     "JOIN clubs c ON r.clubID = c.clubID " +
                     "ORDER BY r.registrationDate DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ClubRegistration reg = new ClubRegistration();
                reg.setRegistrationID(rs.getInt("registrationID"));
                reg.setUserID(rs.getInt("userID"));
                reg.setClubID(rs.getInt("clubID"));
                reg.setRegistrationDate(rs.getTimestamp("registrationDate").toLocalDateTime());
                reg.setStatus(rs.getString("status"));
                reg.setNotes(rs.getString("notes"));
                reg.setClubName(rs.getString("clubName"));
                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm đơn đăng ký mới - SỬA: đổi tên bảng users
    public boolean insertRegistration(ClubRegistration reg) {
        String sql = "INSERT INTO club_registrations (userID, clubID, registrationDate, status, notes) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reg.getUserID());
            ps.setInt(2, reg.getClubID());
            ps.setTimestamp(3, Timestamp.valueOf(reg.getRegistrationDate()));
            ps.setString(4, reg.getStatus());
            ps.setString(5, reg.getNotes());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật đơn đăng ký
    public boolean updateRegistration(ClubRegistration reg) {
        String sql = "UPDATE club_registrations SET status=?, notes=?, updatedAt=GETDATE() WHERE registrationID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, reg.getStatus());
            ps.setString(2, reg.getNotes());
            ps.setInt(3, reg.getRegistrationID());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa đơn đăng ký
    public boolean deleteRegistration(int id) {
        String sql = "DELETE FROM club_registrations WHERE registrationID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy đơn đăng ký theo ID
    public ClubRegistration getRegistrationById(int id) {
        String sql = "SELECT r.*, c.clubName FROM club_registrations r " +
                     "JOIN clubs c ON r.clubID = c.clubID WHERE r.registrationID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ClubRegistration reg = new ClubRegistration();
                reg.setRegistrationID(rs.getInt("registrationID"));
                reg.setUserID(rs.getInt("userID"));
                reg.setClubID(rs.getInt("clubID"));
                reg.setRegistrationDate(rs.getTimestamp("registrationDate").toLocalDateTime());
                reg.setStatus(rs.getString("status"));
                reg.setNotes(rs.getString("notes"));
                reg.setClubName(rs.getString("clubName"));
                return reg;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // TEST METHOD - Kiểm tra với bảng users
    // TEST METHOD - Kiểm tra với bảng users
public static void main(String[] args) {
    ClubRegistrationDAO dao = new ClubRegistrationDAO();
    
    System.out.println("=== 🧪 TEST CLUB REGISTRATION DAO ===\n");
    
    // Test 1: Kiểm tra kết nối database
    System.out.println("1. Testing database connection...");
    try {
        if (dao.connection != null && !dao.connection.isClosed()) {
            System.out.println("✅ Database connection: SUCCESS");
        } else {
            System.out.println("❌ Database connection: FAILED");
            return;
        }
    } catch (SQLException e) {
        System.out.println("❌ Database connection error: " + e.getMessage());
        return;
    }
    
    // Kiểm tra cấu trúc thực tế của bảng users
    System.out.println("\n🔍 Checking actual structure of users table...");
    checkTableStructure(dao.connection, "users");
    
    // Kiểm tra dữ liệu mẫu trong bảng users
    System.out.println("\n🔍 Sample data from users table:");
    showSampleData(dao.connection, "users");
    
    // Kiểm tra foreign key constraint
    System.out.println("\n🔗 Checking foreign key constraints...");
    checkForeignKeyConstraints(dao.connection);
}

// Kiểm tra cấu trúc bảng
private static void checkTableStructure(Connection connection, String tableName) {
    try {
        DatabaseMetaData meta = connection.getMetaData();
        ResultSet columns = meta.getColumns(null, null, tableName, null);
        
        System.out.println("📋 Columns in " + tableName + " table:");
        while (columns.next()) {
            String columnName = columns.getString("COLUMN_NAME");
            String columnType = columns.getString("TYPE_NAME");
            int columnSize = columns.getInt("COLUMN_SIZE");
            System.out.println("   - " + columnName + " (" + columnType + "(" + columnSize + "))");
        }
    } catch (Exception e) {
        System.out.println("❌ Error checking table structure: " + e.getMessage());
    }
}

// Hiển thị dữ liệu mẫu
private static void showSampleData(Connection connection, String tableName) {
    String sql = "SELECT TOP 5 * FROM " + tableName;
    try (PreparedStatement ps = connection.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        ResultSetMetaData meta = rs.getMetaData();
        int columnCount = meta.getColumnCount();
        
        // Hiển thị tên cột
        System.out.print("   Columns: ");
        for (int i = 1; i <= columnCount; i++) {
            if (i > 1) System.out.print(" | ");
            System.out.print(meta.getColumnName(i));
        }
        System.out.println();
        
        // Hiển thị dữ liệu
        while (rs.next()) {
            System.out.print("   Row: ");
            for (int i = 1; i <= columnCount; i++) {
                if (i > 1) System.out.print(" | ");
                System.out.print(rs.getString(i));
            }
            System.out.println();
        }
    } catch (Exception e) {
        System.out.println("❌ Error reading data: " + e.getMessage());
    }
}

// Kiểm tra foreign key constraints
private static void checkForeignKeyConstraints(Connection connection) {
    try {
        DatabaseMetaData meta = connection.getMetaData();
        ResultSet importedKeys = meta.getImportedKeys(null, null, "club_registrations");
        
        System.out.println("🔗 Foreign keys for club_registrations:");
        boolean hasKeys = false;
        while (importedKeys.next()) {
            hasKeys = true;
            String fkColumn = importedKeys.getString("FKCOLUMN_NAME");
            String pkTable = importedKeys.getString("PKTABLE_NAME");
            String pkColumn = importedKeys.getString("PKCOLUMN_NAME");
            String fkName = importedKeys.getString("FK_NAME");
            
            System.out.println("   - Constraint: " + fkName);
            System.out.println("     Column: " + fkColumn + " → " + pkTable + "." + pkColumn);
        }
        
        if (!hasKeys) {
            System.out.println("   ℹ️ No foreign keys found");
        }
    } catch (Exception e) {
        System.out.println("❌ Error checking foreign keys: " + e.getMessage());
    }
}
    // Kiểm tra users thực tế trong bảng users
    private static void checkActualUsers(Connection connection) {
        String sql = "SELECT TOP 10 userID, username, email FROM users ORDER BY userID";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                System.out.println("   - UserID: " + rs.getInt("userID") + 
                                 ", Name: " + rs.getString("username") +
                                 ", Email: " + rs.getString("email"));
            }
            
            if (!hasData) {
                System.out.println("   ℹ️ No users found in users table");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error checking users: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Kiểm tra clubs thực tế
    private static void checkActualClubs(Connection connection) {
        String sql = "SELECT TOP 5 ClubID, ClubName, Status FROM Clubs ORDER BY ClubID";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                System.out.println("   - ClubID: " + rs.getInt("ClubID") + 
                                 ", Name: " + rs.getString("ClubName") +
                                 ", Status: " + (rs.getBoolean("Status") ? "Active" : "Inactive"));
            }
        } catch (Exception e) {
            System.out.println("❌ Error checking clubs: " + e.getMessage());
        }
    }

    // Tìm UserID hợp lệ trong bảng users
    private static Integer findValidUserID(Connection connection) {
        String sql = "SELECT TOP 1 userID FROM users ORDER BY userID";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt("userID");
            }
        } catch (Exception e) {
            System.out.println("❌ Error finding userID: " + e.getMessage());
        }
        return null;
    }

    // Tìm ClubID hợp lệ
    private static Integer findValidClubID(Connection connection) {
        String sql = "SELECT TOP 1 ClubID FROM Clubs WHERE Status = 1 ORDER BY ClubID";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt("ClubID");
            }
        } catch (Exception e) {
            System.out.println("❌ Error finding clubID: " + e.getMessage());
        }
        return null;
    }

    // Test insert với dữ liệu hợp lệ
    private static void testInsertWithValidData(ClubRegistrationDAO dao, int userID, int clubID) {
        try {
            dao.connection.setAutoCommit(false); // Dùng transaction để rollback
            
            ClubRegistration newReg = new ClubRegistration();
            newReg.setUserID(userID);
            newReg.setClubID(clubID);
            newReg.setRegistrationDate(java.time.LocalDateTime.now());
            newReg.setStatus("pending");
            newReg.setNotes("Test registration with valid user from users table");
            
            System.out.println("📝 Attempting insert...");
            boolean insertResult = dao.insertRegistration(newReg);
            
            if (insertResult) {
                System.out.println("✅ Insert SUCCESS!");
                dao.connection.commit();
                
                // Hiển thị kết quả
                List<ClubRegistration> regs = dao.getAllRegistrations();
                System.out.println("📋 Total registrations: " + regs.size());
                
                if (!regs.isEmpty()) {
                    ClubRegistration latest = regs.get(0);
                    System.out.println("🎉 Latest registration:");
                    System.out.println("   - ID: " + latest.getRegistrationID());
                    System.out.println("   - User: " + latest.getUserID());
                    System.out.println("   - Club: " + latest.getClubID());
                    System.out.println("   - Club Name: " + latest.getClubName());
                    System.out.println("   - Status: " + latest.getStatus());
                }
            } else {
                System.out.println("❌ Insert FAILED");
                dao.connection.rollback();
            }
            
            dao.connection.setAutoCommit(true);
            
        } catch (Exception e) {
            System.out.println("❌ Error during test: " + e.getMessage());
            e.printStackTrace();
            try {
                dao.connection.rollback();
                dao.connection.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}