package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DBContext - Cầu Nối Với Cơ Sở Dữ Liệu
 * ===================================
 * 
 * 1. Vai Trò của DBContext
 *    - Như "người gác cổng" của kho dữ liệu:
 *      + Tạo và quản lý kết nối database
 *      + Đảm bảo an toàn dữ liệu
 *      + Cung cấp công cụ truy cập cho các DAO
 * 
 * 2. Cách Hoạt Động
 *    - Giống như "trạm kiểm soát":
 *      + Kiểm tra thông tin kết nối
 *      + Mở cổng khi cần truy cập
 *      + Đóng cổng sau khi xong việc
 *      + Xử lý lỗi khi có sự cố
 * 
 * 3. Mối Quan Hệ Với Các DAO
 *    - Như "công ty mẹ" của các DAO:
 *      + Cung cấp kết nối cho mọi DAO
 *      + Đảm bảo quy chuẩn an toàn
 *      + Quản lý tài nguyên chung
 * 
 * 4. Ví Dụ Thực Tế
 *    - Giống như bảo vệ tòa nhà:
 *      + Kiểm soát ra vào (kết nối)
 *      + Quản lý chìa khóa (credentials)
 *      + Xử lý tình huống khẩn cấp (lỗi)
 * 
 * 5. Tại Sao Cần DBContext?
 *    a. Bảo Mật:
 *       - Tập trung quản lý thông tin nhạy cảm
 *       - Kiểm soát quyền truy cập
 *       - Ngăn chặn rò rỉ dữ liệu
 * 
 *    b. Hiệu Quả:
 *       - Tái sử dụng kết nối
 *       - Giảm tải server
 *       - Tối ưu tài nguyên
 * 
 *    c. Dễ Bảo Trì:
 *       - Thay đổi cấu hình dễ dàng
 *       - Nâng cấp không ảnh hưởng code
 *       - Dễ theo dõi và sửa lỗi
 */
public class DBContext {
    protected Connection connection;
    public DBContext()
    {
        try {
            String user = "sa";
            String pass = "123";
            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=UniClubs";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
}
