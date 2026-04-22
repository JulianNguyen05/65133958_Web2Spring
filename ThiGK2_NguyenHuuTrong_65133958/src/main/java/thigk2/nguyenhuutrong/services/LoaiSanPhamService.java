package thigk2.nguyenhuutrong.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import thigk2.nguyenhuutrong.models.LoaiSanPham;
import thigk2.nguyenhuutrong.repositories.LoaiSanPhamRepository;

@Service
public class LoaiSanPhamService {

	@Autowired
	private LoaiSanPhamRepository loaiSanPhamRepo;

	public List<LoaiSanPham> getAll() {
		return loaiSanPhamRepo.findAll();
	}

	public LoaiSanPham save(LoaiSanPham loai) {
		return loaiSanPhamRepo.save(loai);
	}

	public void delete(Long id) {
		loaiSanPhamRepo.deleteById(id);
	}

	public LoaiSanPham findById(Long id) {
		return loaiSanPhamRepo.findById(id).orElse(null);
	}
}