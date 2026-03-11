package com.julian.OnThiGK.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.julian.OnThiGK.models.Page;
import com.julian.OnThiGK.services.MockDataService;

@Controller
@RequestMapping("/page")
public class PageController {

	@Autowired
	private MockDataService dataService;

	// a. Page - List
	@GetMapping("/all")
	public String listPages(Model model) {
		model.addAttribute("pages", dataService.getAllPages());
		model.addAttribute("username", "Julian Nguyen");
		return "page-list";
	}

	// b. Page - Addnew (Hiển thị form)
	@GetMapping("/new")
	public String showAddPageForm(Model model) {
		model.addAttribute("page", new Page());
		model.addAttribute("username", "Julian Nguyen");
		return "page-add";
	}

	// Xử lý dữ liệu khi submit form Addnew
	@PostMapping("/new")
	public String savePage(@ModelAttribute("page") Page page) {
		dataService.addPage(page);
		return "redirect:/page/all";
	}

	// c. Page - View (Xem chi tiết)
	@GetMapping("/view/{id}")
	public String viewPage(@PathVariable("id") int id, Model model) {
		Page page = dataService.getPageById(id);
		if (page == null) {
			return "redirect:/page/all";
		}
		model.addAttribute("page", page);
		model.addAttribute("username", "Julian Nguyen");
		return "page-view";
	}

	// d. Page - Delete
	@GetMapping("/delete/{id}")
	public String deletePage(@PathVariable("id") int id) {
		dataService.deletePage(id);
		return "redirect:/page/all";
	}

	// e. Page - Edit (Hiển thị form sửa)
	@GetMapping("/edit/{id}")
	public String showEditPageForm(@PathVariable("id") int id, Model model) {
		Page page = dataService.getPageById(id);
		if (page == null) {
			return "redirect:/page/all";
		}
		model.addAttribute("page", page);
		model.addAttribute("username", "Julian Nguyen");
		return "page-edit"; // Chuyển đến trang form edit
	}

	// Xử lý dữ liệu khi submit form Edit
	@PostMapping("/edit")
	public String updatePage(@ModelAttribute("page") Page page) {
		dataService.updatePage(page);
		return "redirect:/page/all";
	}

}