package toeic.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			String url = "jdbc:mysql://localhost:3306/LuyenThiToeicDB?useSSL=false&serverTimezone=UTC";
			String user = "root";
			String pass = "1234";

			conn = DriverManager.getConnection(url, user, pass);
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("Lỗi kết nối: " + e.getMessage());
			e.printStackTrace();
		}
		return conn;
	}

	public static void main(String[] args) {
		Connection testConn = getConnection();
		if (testConn != null) {
			System.out.println("Chúc mừng Julian! Kết nối Database thành công.");
		} else {
			System.out.println("Kết nối thất bại, hãy kiểm tra lại mật khẩu hoặc tên DB.");
		}
	}
}