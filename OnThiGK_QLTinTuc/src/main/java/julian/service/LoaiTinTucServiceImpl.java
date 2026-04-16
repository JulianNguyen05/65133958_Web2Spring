package julian.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import julian.model.LoaiTinTuc;
import julian.repository.LoaiTinTucRepository;

@Service
public class LoaiTinTucServiceImpl implements LoaiTinTucService {
	@Autowired
	private LoaiTinTucRepository repo;

	@Override
	public List<LoaiTinTuc> findAll() {
		return repo.findAll();
	}

	@Override
	public LoaiTinTuc save(LoaiTinTuc loai) {
		return repo.save(loai);
	}

	@Override
	public void deleteById(Integer id) {
		repo.deleteById(id);
	}
}