package thigk2.nguyenhuutrong.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import thigk2.nguyenhuutrong.models.TheLoaiTin;

@Repository
public interface TheLoaiTinRepository extends JpaRepository<TheLoaiTin, Long> {
}