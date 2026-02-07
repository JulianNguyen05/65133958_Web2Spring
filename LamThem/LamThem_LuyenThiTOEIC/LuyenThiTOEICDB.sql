-- 1. Tạo Database mới
CREATE DATABASE IF NOT EXISTS LuyenThiToeicDB;
USE LuyenThiToeicDB;

-- 2. Bảng Users: Quản lý thông tin đăng nhập và vai trò
-- Lưu ý: Bạn là Admin (để thêm đề), người khác là User (để làm bài)
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    role VARCHAR(10) DEFAULT 'USER' -- 'ADMIN' hoặc 'USER'
);

-- 3. Bảng Exams: Lưu trữ thông tin từng đề thi TOEIC riêng biệt
CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL, -- Ví dụ: TOEIC Economy Vol 1 - Test 01
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Bảng Questions: Lưu 100 câu hỏi cho các Part 4, 5, 6
-- Cấu trúc này hỗ trợ cả câu đơn (Part 5) và câu theo đoạn văn (Part 6)
CREATE TABLE questions (
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_id INT,
    part INT, -- Giá trị: 4, 5, hoặc 6
    paragraph TEXT, -- Dùng để lưu đoạn văn cho Part 6 (nếu là Part 5 thì để NULL)
    question_text TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL,
    correct_answer CHAR(1), -- A, B, C, hoặc D
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id) ON DELETE CASCADE
);

-- 5. Bảng Results: Lưu lịch sử làm bài và phục vụ Bảng xếp hạng
CREATE TABLE results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    exam_id INT,
    score INT, -- Số câu đúng trên tổng số câu
    time_spent INT, -- Thời gian hoàn thành tính bằng giây
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id) ON DELETE CASCADE
);