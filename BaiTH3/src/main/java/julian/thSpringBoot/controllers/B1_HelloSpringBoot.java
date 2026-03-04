package julian.thSpringBoot.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class B1_HelloSpringBoot {
	@GetMapping("/vd1")
	public String getVivd1(ModelMap m) {
		m.addAttribute("message", "Dữ liệu này đến từ B1_HelloSpringBoot. Chào mừng bạn đến với dự án đầu tiên!");
		return "index";
	}
}
