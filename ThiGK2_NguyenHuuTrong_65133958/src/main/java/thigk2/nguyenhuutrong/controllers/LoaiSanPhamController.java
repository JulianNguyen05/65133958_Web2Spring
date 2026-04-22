package thigk2.nguyenhuutrong.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import thigk2.nguyenhuutrong.models.LoaiSanPham;
import thigk2.nguyenhuutrong.services.LoaiSanPhamService;

@RestController
@RequestMapping("/api/admin/loai-san-pham")
public class LoaiSanPhamController {

	@Autowired
	private LoaiSanPhamService loaiSanPhamService;

	// R - Read All
	@GetMapping
	public List<LoaiSanPham> getAll() {
		return loaiSanPhamService.getAll();
	}

	// C - Create
	@PostMapping
	public LoaiSanPham create(@RequestBody LoaiSanPham loai) {
		return loaiSanPhamService.save(loai);
	}

	// U - Update
	@PutMapping("/{id}")
	public LoaiSanPham update(@PathVariable Long id, @RequestBody LoaiSanPham details) {
		LoaiSanPham lsp = loaiSanPhamService.findById(id);
		if (lsp != null) {
			lsp.setTenLoai(details.getTenLoai());
			return loaiSanPhamService.save(lsp);
		}
		return null;
	}

	// D - Delete
	@DeleteMapping("/{id}")
	public void delete(@PathVariable Long id) {
		loaiSanPhamService.delete(id);
	}
}