package julian.thSpringBoot.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import julian.thSpringBoot.models.SanPham; // Tận dụng lại Model SanPham đã tạo ở Bài 5

@Controller
public class B6_TruyenDanhSach2View {

	@GetMapping("/vd6")
	public String hienThiDanhSachSanPham(Model model) {
		List<SanPham> listSP = new ArrayList<>();

		listSP.add(new SanPham("SP001", "Laptop Dell XPS 15", 25000000));
		listSP.add(new SanPham("SP002", "Chuột không dây Logitech", 1200000));
		listSP.add(new SanPham("SP003", "Bàn phím cơ Keychron", 1800000));
		listSP.add(new SanPham("SP004", "Màn hình LG 27 inch 4K", 8500000));
		listSP.add(new SanPham("SP005", "Tai nghe Sony WH-1000XM5", 7000000));

		model.addAttribute("dsSanPham", listSP);

		return "vd6-danhsach-sanpham";
	}
}