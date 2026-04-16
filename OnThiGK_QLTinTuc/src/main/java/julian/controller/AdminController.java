package julian.controller;

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

import julian.model.LoaiTinTuc;
import julian.model.TinTuc;
import julian.service.LoaiTinTucService;
import julian.service.TinTucService;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

	@Autowired
	private TinTucService tinTucService;
	@Autowired
	private LoaiTinTucService loaiTinTucService;

	// ==================== CRUD Loại tin tức ====================
	@GetMapping("/loai")
	public List<LoaiTinTuc> getAllLoai() {
		return loaiTinTucService.findAll();
	}

	@PostMapping("/loai")
	public LoaiTinTuc createLoai(@RequestBody LoaiTinTuc loai) {
		return loaiTinTucService.save(loai);
	}

	@PutMapping("/loai/{id}")
	public LoaiTinTuc updateLoai(@PathVariable Integer id, @RequestBody LoaiTinTuc loai) {
		loai.setId(id);
		return loaiTinTucService.save(loai);
	}

	@DeleteMapping("/loai/{id}")
	public String deleteLoai(@PathVariable Integer id) {
		loaiTinTucService.deleteById(id);
		return "Đã xóa loại tin tức id = " + id;
	}

	// ==================== CRUD Tin tức ====================
	@GetMapping("/tintuc")
	public List<TinTuc> getAllTinTuc() {
		return tinTucService.findAll();
	}

	@PostMapping("/tintuc")
	public TinTuc createTinTuc(@RequestBody TinTuc tin) {
		return tinTucService.save(tin);
	}

	@PutMapping("/tintuc/{id}")
	public TinTuc updateTinTuc(@PathVariable Integer id, @RequestBody TinTuc tin) {
		tin.setId(id);
		return tinTucService.save(tin);
	}

	@DeleteMapping("/tintuc/{id}")
	public String deleteTinTuc(@PathVariable Integer id) {
		tinTucService.deleteById(id);
		return "Đã xóa tin tức id = " + id;
	}
}
