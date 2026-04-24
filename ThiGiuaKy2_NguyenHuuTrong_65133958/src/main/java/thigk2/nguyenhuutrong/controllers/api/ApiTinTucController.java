package thigk2.nguyenhuutrong.controllers.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import thigk2.nguyenhuutrong.models.TheLoaiTin;
import thigk2.nguyenhuutrong.models.Tin;
import thigk2.nguyenhuutrong.services.TheLoaiTinService;
import thigk2.nguyenhuutrong.services.TinService;

@RestController
@RequestMapping("/api")
public class ApiTinTucController {

	@Autowired
	private TheLoaiTinService theLoaiTinService;

	@Autowired
	private TinService tinService;

	@GetMapping("/the-loai")
	public ResponseEntity<List<TheLoaiTin>> layDanhSachTheLoai() {
		return ResponseEntity.ok(theLoaiTinService.layTatCaTheLoai());
	}

	@GetMapping("/the-loai/{id}/tin")
	public ResponseEntity<List<Tin>> layTinTheoTheLoai(@PathVariable("id") Long theLoaiId) {
		return ResponseEntity.ok(tinService.layTinTheoTheLoai(theLoaiId));
	}
}