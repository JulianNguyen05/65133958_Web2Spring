package thigk2.nguyenhuutrong.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import thigk2.nguyenhuutrong.services.LoaiSanPhamService;
import thigk2.nguyenhuutrong.services.SanPhamService;

@Controller
@RequestMapping("/admin")
public class AdminWebController {

	@Autowired
	private SanPhamService sanPhamService;

	@Autowired
	private LoaiSanPhamService loaiSanPhamService;

	@GetMapping({ "", "/", "/dashboard" })
	public String viewDashboard() {
		return "admin-dashboard";
	}

	@GetMapping("/san-pham")
	public String viewSanPham(Model model) {
		model.addAttribute("listSanPham", sanPhamService.getAll());
		model.addAttribute("listLoai", loaiSanPhamService.getAll());
		return "san-pham";
	}

	@GetMapping("/loai-san-pham")
	public String viewLoaiSanPham(Model model) {
		model.addAttribute("listLoai", loaiSanPhamService.getAll());
		return "loai-san-pham";
	}
}