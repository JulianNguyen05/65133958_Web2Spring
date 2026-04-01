package julian.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping("/home")
	public String home() {
		return "home";
	}

	@GetMapping("/login")
	public String login() {
		System.out.println("Đang vào trang login...");
		return "login";
	}
}
