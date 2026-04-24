CREATE DATABASE thigk2_nguyenhuutrong;
USE thigk2_nguyenhuutrong;

CREATE TABLE loai_san_pham (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ten_loai VARCHAR(255) NOT NULL
);

CREATE TABLE san_pham (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ten_sp VARCHAR(255) NOT NULL,
    gia DOUBLE,
    loai_id BIGINT,
    FOREIGN KEY (loai_id) REFERENCES loai_san_pham(id)
);

-- Chèn dữ liệu mẫu để test
INSERT INTO loai_san_pham (ten_loai) VALUES ('Điện tử'), ('Gia dụng');
INSERT INTO san_pham (ten_sp, gia, loai_id) VALUES ('Laptop Dell', 15000000, 1), ('Nồi cơm điện', 1200000, 2);