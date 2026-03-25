package julian.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/login")
	public String login() {
		return "login"; // Trả về login.html
	}

	@GetMapping("/public/home")
	public String publicPage() {
		return "public"; // Trả về public.html
	}

	@GetMapping("/products")
	public String productsPage() {
		return "products"; // Trả về products.html (Yêu cầu USER)
	}

	@GetMapping("/admin")
	public String adminPage() {
		return "admin"; // Trả về admin.html (Yêu cầu ADMIN)
	}
}
