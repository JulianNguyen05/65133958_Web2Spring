package julian.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import julian.model.LoaiTinTuc;

public interface LoaiTinTucRepository extends JpaRepository<LoaiTinTuc, Integer> {
}