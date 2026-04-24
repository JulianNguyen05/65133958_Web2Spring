package thigk2.nguyenhuutrong.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import thigk2.nguyenhuutrong.services.TheLoaiTinService;
import thigk2.nguyenhuutrong.services.TinService;

@Controller
public class WebTinTucController {

	@Autowired
	private TinService tinService;

	@Autowired
	private TheLoaiTinService theLoaiTinService;

	@GetMapping({ "/", "/trang-chu" })
	public String hienThiTrangChu(Model model) {
		model.addAttribute("danhSachTheLoai", theLoaiTinService.layTatCaTheLoai());
		model.addAttribute("danhSachTin", tinService.layTatCaTin());
		return "index";
	}

	@GetMapping("/the-loai/{id}")
	public String hienThiTinTheoTheLoai(@PathVariable("id") Long id, Model model) {
		model.addAttribute("danhSachTheLoai", theLoaiTinService.layTatCaTheLoai());
		model.addAttribute("danhSachTin", tinService.layTinTheoTheLoai(id));
		return "index";
	}

	@GetMapping("/tin-tuc/{id}")
	public String hienThiChiTietTin(@PathVariable("id") Long id, Model model) {
		model.addAttribute("danhSachTheLoai", theLoaiTinService.layTatCaTheLoai());
		model.addAttribute("tin", tinService.layChiTietTin(id));
		return "detail";
	}

	@GetMapping("/login")
	public String hienThiTrangDangNhap() {
		return "login";
	}
}