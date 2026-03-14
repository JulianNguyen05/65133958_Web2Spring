package julian.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import julian.repository.MockData;

@Controller
@RequestMapping("/page")
public class PageController {

	@GetMapping("/all")
	public String listPages(ModelMap model) {
		model.addAttribute("pages", MockData.pages);
		return "page_list";
	}

	@GetMapping("/delete/{id}")
	public String deletePage(@PathVariable int id) {
		MockData.pages.removeIf(p -> p.getId() == id);
		return "redirect:/page/all";
	}

	// Các mapping cho /new, /view/{id} bạn cấu trúc tương tự,
	// trả về template html chứa form thêm mới hoặc trang chi tiết.
}
