-- 1. Tạo cơ sở dữ liệu (Database)
CREATE DATABASE IF NOT EXISTS tin_tuc_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tin_tuc_db;

-- 2. Tạo bảng Thể loại (categories)
CREATE TABLE categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- 3. Tạo bảng Người dùng (users)
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- 4. Tạo bảng Tin tức (news)
CREATE TABLE news (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    category_id BIGINT,
    CONSTRAINT fk_news_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- ==========================================
-- DỮ LIỆU MẪU (DUMMY DATA) ĐỂ TEST ỨNG DỤNG
-- ==========================================

-- Thêm dữ liệu mẫu cho bảng categories
INSERT INTO categories (name) VALUES
('Công nghệ'),
('Thể thao'),
('Giáo dục'),
('Giải trí');

-- Thêm dữ liệu mẫu cho bảng users
-- Lưu ý: Mật khẩu ở đây là '123456' đã được mã hóa bằng thuật toán BCrypt
INSERT INTO users (username, password, role) VALUES
('admin', '123456', 'ROLE_ADMIN'),
('user_test', '123456', 'ROLE_USER');


-- Thêm dữ liệu mẫu cho bảng news
INSERT INTO news (title, content, category_id) VALUES
('Spring Boot 3.0 mang lại cải tiến gì?', 'Spring Boot 3.0 hỗ trợ mạnh mẽ cho Native Image thông qua GraalVM, giúp ứng dụng khởi động nhanh hơn và tốn ít RAM hơn rất nhiều so với trước đây...', 1),
('Kiến trúc Microservices lên ngôi', 'Nhiều doanh nghiệp đang dần chuyển đổi từ kiến trúc Monolithic sang Microservices để dễ dàng scale và bảo trì hệ thống...', 1),
('Đội tuyển Việt Nam chuẩn bị cho giải đấu mới', 'Huấn luyện viên trưởng đã công bố danh sách 23 cầu thủ tập trung cho đợt thi đấu sắp tới với nhiều gương mặt trẻ...', 2),
('Học bổng toàn phần du học Mỹ năm 2026', 'Các trường đại học hàng đầu tại Mỹ vừa công bố hàng loạt chương trình học bổng dành riêng cho sinh viên quốc tế ngành CNTT...', 3),
('Review bộ phim bom tấn cuối tuần', 'Hình ảnh sắc nét, âm thanh sống động và cốt truyện lôi cuốn là những gì khán giả nhận xét về bộ phim chiếu rạp tuần này...', 4);