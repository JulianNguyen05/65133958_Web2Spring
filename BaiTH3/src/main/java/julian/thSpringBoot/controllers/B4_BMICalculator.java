package julian.thSpringBoot.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class B4_BMICalculator {
	@GetMapping("/bmi")
	public String showBmiForm() {
		return "bmi-form";
	}

	@PostMapping("/tinh-bmi")
	public String tinhBMI(@RequestParam("chieuCao") double chieuCao, @RequestParam("canNang") double canNang,
			ModelMap model) {
		double bmi = canNang / (chieuCao * chieuCao);
		String danhGia;

		if (bmi < 18.5)
			danhGia = "Thiếu cân";
		else if (bmi < 25)
			danhGia = "Bình thường";
		else if (bmi < 30)
			danhGia = "Thừa cân";
		else
			danhGia = "Béo phì";

		model.addAttribute("bmi", String.format("%.2f", bmi));
		model.addAttribute("danhGia", danhGia);
		return "bmi-result";
	}
}
