package toeic.model;

import java.sql.Timestamp;

public class Exam {
	private int examId;
	private String title;
	private String description;
	private String fileName;
	private Timestamp createdAt;

	public Exam() {
	}

	public Exam(int examId, String title, String description, String fileName, Timestamp createdAt) {
		this.examId = examId;
		this.title = title;
		this.description = description;
		this.fileName = fileName;
		this.createdAt = createdAt;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getExamId() {
		return examId;
	}

	public void setExamId(int examId) {
		this.examId = examId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
}