package thigk2.nguyenhuutrong.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import thigk2.nguyenhuutrong.services.SanPhamService;

@Controller
public class WebController {

	@Autowired
	private SanPhamService sanPhamService;

	@GetMapping("/san-pham")
	public String viewHomePage(Model model) {
		model.addAttribute("listSanPham", sanPhamService.getAll());
		return "san-pham";
	}
}
