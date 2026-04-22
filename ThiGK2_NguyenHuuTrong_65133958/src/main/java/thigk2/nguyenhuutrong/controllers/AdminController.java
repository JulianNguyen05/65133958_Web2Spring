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

import thigk2.nguyenhuutrong.models.SanPham;
import thigk2.nguyenhuutrong.services.SanPhamService;

@RestController
@RequestMapping("/api/admin/san-pham")
public class AdminController {

	@Autowired
	private SanPhamService sanPhamService;

	// R - Read All
	@GetMapping
	public List<SanPham> getAll() {
		return sanPhamService.getAll();
	}

	// C - Create
	@PostMapping
	public SanPham create(@RequestBody SanPham sanPham) {
		return sanPhamService.save(sanPham);
	}

	// U - Update
	@PutMapping("/{id}")
	public SanPham update(@PathVariable Long id, @RequestBody SanPham sanPhamDetails) {
		SanPham sp = sanPhamService.findById(id);
		if (sp != null) {
			sp.setTenSanPham(sanPhamDetails.getTenSanPham());
			sp.setGia(sanPhamDetails.getGia());
			sp.setLoaiSanPham(sanPhamDetails.getLoaiSanPham());
			return sanPhamService.save(sp);
		}
		return null;
	}

	// D - Delete
	@DeleteMapping("/{id}")
	public void delete(@PathVariable Long id) {
		sanPhamService.delete(id);
	}
}