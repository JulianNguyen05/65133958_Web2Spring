package julian.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import julian.models.UserRegistrationDTO;
import julian.services.UserService;

@Controller
public class AuthController {

	@Autowired
	private UserService userService;

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@GetMapping("/register")
	public String register() {
		return "register";
	}

	@PostMapping("/register")
	public String registerUser(@ModelAttribute("user") UserRegistrationDTO registrationDto, Model model) {
		try {
			userService.registerNewUser(registrationDto);
			return "redirect:/login?registered";
		} catch (RuntimeException e) {
			model.addAttribute("error", e.getMessage());
			return "register";
		}
	}
}
