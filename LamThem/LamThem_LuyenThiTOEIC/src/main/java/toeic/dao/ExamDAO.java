package toeic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import toeic.connection.DBConnection;
import toeic.model.Exam;

public class ExamDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public List<Exam> getAllExams() {
		List<Exam> list = new ArrayList<>();
		String query = "SELECT * FROM exams ORDER BY created_at DESC";

		try {
			conn = DBConnection.getConnection();
			if (conn == null) {
				System.out.println("Không thể kết nối đến Database!");
				return list;
			}

			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new Exam(rs.getInt("exam_id"), rs.getString("title"), rs.getString("description"),
						rs.getString("file_name"), rs.getTimestamp("created_at")));
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean insertExam(String title, String description, String fileName) {
		String query = "INSERT INTO exams (title, description, file_name) VALUES (?, ?, ?)";
		boolean isSuccess = false;

		try {
			Connection conn = DBConnection.getConnection();
			if (conn == null)
				return false;

			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, title);
			ps.setString(2, description);
			ps.setString(3, fileName);

			int row = ps.executeUpdate();
			if (row > 0) {
				isSuccess = true;
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// Hàm xóa đề thi
	public boolean deleteExam(int examId) {
		String query = "DELETE FROM exams WHERE exam_id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			if (conn == null)
				return false;

			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, examId);
			int row = ps.executeUpdate();
			conn.close();

			return row > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Hàm cập nhật đề thi (chỉ sửa Tên và Mô tả, giữ nguyên file JSON)
	public boolean updateExam(int examId, String title, String description) {
		String query = "UPDATE exams SET title = ?, description = ? WHERE exam_id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			if (conn == null)
				return false;

			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, title);
			ps.setString(2, description);
			ps.setInt(3, examId);
			int row = ps.executeUpdate();
			conn.close();

			return row > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}