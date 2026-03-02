package toeic.model;

import java.sql.Timestamp;

public class Result {
	private String username;
	private String fullName;
	private int score;
	private int timeSpent; // Tính bằng giây
	private Timestamp completedAt;

	public Result(String username, String fullName, int score, int timeSpent, Timestamp completedAt) {
		this.username = username;
		this.fullName = fullName;
		this.score = score;
		this.timeSpent = timeSpent;
		this.completedAt = completedAt;
	}

	// Hàm tiện ích để hiển thị thời gian làm bài đẹp hơn (VD: 14:05)
	public String getFormattedTime() {
		int m = timeSpent / 60;
		int s = timeSpent % 60;
		return String.format("%02d:%02d", m, s);
	}

	public String getUsername() {
		return username;
	}

	public String getFullName() {
		return fullName;
	}

	public int getScore() {
		return score;
	}

	public int getTimeSpent() {
		return timeSpent;
	}

	public Timestamp getCompletedAt() {
		return completedAt;
	}
}