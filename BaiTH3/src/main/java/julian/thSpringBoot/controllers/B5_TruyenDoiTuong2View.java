package julian.thSpringBoot.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import julian.thSpringBoot.models.SanPham;

@Controller
public class B5_TruyenDoiTuong2View {
	@GetMapping("/vd5")
	public String hienThiSanPham(ModelMap model) {
		SanPham sp = new SanPham("SP001", "Laptop Dell XPS 15", 25000000);

		model.addAttribute("sanPhamObj", sp);

		return "vd5-info";
	}
}
