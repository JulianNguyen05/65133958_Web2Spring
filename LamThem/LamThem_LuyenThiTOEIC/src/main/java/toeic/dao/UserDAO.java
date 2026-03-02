package toeic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import toeic.connection.DBConnection;
import toeic.model.User;

public class UserDAO {

	public static User checkLogin(String username, String password) {
		User user = null;
		String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, username);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"),
						rs.getString("full_name"), rs.getString("role"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	public static boolean register(User user) {
		String sql = "INSERT INTO users (username, password, full_name, role) VALUES (?, ?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getFullName());
			ps.setString(4, "USER");

			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<User> getAllUsers() {
		List<User> list = new ArrayList<>();
		String query = "SELECT * FROM users ORDER BY user_id DESC";
		try {
			Connection conn = DBConnection.getConnection();
			if (conn == null)
				return list;
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"),
						rs.getString("full_name"), rs.getString("role")));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean insertUser(String username, String password, String fullName, String role) {
		String query = "INSERT INTO users (username, password, full_name, role) VALUES (?, ?, ?, ?)";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, fullName);
			ps.setString(4, role);
			int row = ps.executeUpdate();
			conn.close();
			return row > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteUser(int userId) {
		String query = "DELETE FROM users WHERE user_id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, userId);
			int row = ps.executeUpdate();
			conn.close();
			return row > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateUser(int userId, String fullName, String role) {
		String query = "UPDATE users SET full_name = ?, role = ? WHERE user_id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, fullName);
			ps.setString(2, role);
			ps.setInt(3, userId);
			int row = ps.executeUpdate();
			conn.close();
			return row > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}