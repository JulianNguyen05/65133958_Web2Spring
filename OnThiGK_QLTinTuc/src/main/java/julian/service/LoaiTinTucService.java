package julian.service;

import java.util.List;

import julian.model.LoaiTinTuc;

public interface LoaiTinTucService {
	List<LoaiTinTuc> findAll();

	LoaiTinTuc save(LoaiTinTuc loai);

	void deleteById(Integer id);
}
