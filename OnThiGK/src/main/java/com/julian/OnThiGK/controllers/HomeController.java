package com.julian.OnThiGK.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
	public String index(ModelMap m) {
		m.addAttribute("username", "Julian Nguyen");
		return "HomeView";
	}
}