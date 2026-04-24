package thigk2.nguyenhuutrong.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import thigk2.nguyenhuutrong.models.Tin;

@Repository
public interface TinRepository extends JpaRepository<Tin, Long> {
	List<Tin> findByTheLoaiTinId(Long theLoaiId);
}