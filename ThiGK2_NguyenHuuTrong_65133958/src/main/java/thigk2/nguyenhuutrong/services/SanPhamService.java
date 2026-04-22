package thigk2.nguyenhuutrong.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import thigk2.nguyenhuutrong.models.SanPham;
import thigk2.nguyenhuutrong.repositories.SanPhamRepository;

@Service
public class SanPhamService {
	@Autowired
	private SanPhamRepository sanPhamRepo;

	public List<SanPham> getAll() {
		return sanPhamRepo.findAll();
	}

	public SanPham save(SanPham sp) {
		return sanPhamRepo.save(sp);
	}

	public void delete(Long id) {
		sanPhamRepo.deleteById(id);
	}

	public SanPham findById(Long id) {
		return sanPhamRepo.findById(id).orElse(null);
	}
}
