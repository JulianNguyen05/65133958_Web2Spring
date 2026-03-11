package com.julian.OnThiGK.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.julian.OnThiGK.services.MockDataService;

@Controller
@RequestMapping("/page")
public class PageController {

	@Autowired
	private MockDataService dataService;

	@GetMapping("/all")
	public String listPages(Model model) {
		model.addAttribute("pages", dataService.getAllPages());
		model.addAttribute("username", "Julian Nguyen");
		return "page-list";
	}

	@GetMapping("/delete/{id}")
	public String deletePage(@PathVariable("id") int id) {
		dataService.deletePage(id);
		return "redirect:/page/all";
	}

}