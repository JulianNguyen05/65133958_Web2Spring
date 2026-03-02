package toeic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import toeic.connection.DBConnection;
import toeic.model.Result;

public class ResultDAO {

	// 1. Lưu kết quả vào Database
	public boolean saveResult(int userId, int examId, int score, int timeSpent) {
		String query = "INSERT INTO results (user_id, exam_id, score, time_spent) VALUES (?, ?, ?, ?)";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, userId);
			ps.setInt(2, examId);
			ps.setInt(3, score);
			ps.setInt(4, timeSpent);
			int row = ps.executeUpdate();
			conn.close();
			return row > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 2. Lấy Bảng xếp hạng (Sắp xếp theo Điểm GIẢM DẦN, Thời gian TĂNG DẦN)
	public List<Result> getTopResults(int examId) {
		List<Result> list = new ArrayList<>();
		String query = "SELECT u.username, u.full_name, r.score, r.time_spent, r.completed_at "
				+ "FROM results r JOIN users u ON r.user_id = u.user_id " + "WHERE r.exam_id = ? "
				+ "ORDER BY r.score DESC, r.time_spent ASC LIMIT 50";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, examId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Result(rs.getString("username"), rs.getString("full_name"), rs.getInt("score"),
						rs.getInt("time_spent"), rs.getTimestamp("completed_at")));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}