package julian;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class APIPageController {
	@GetMapping("/api/hello")
	public String hello() {
		return "Hello, World!";
	}

	@PostMapping("/api/hello")
	public String helloPost(@RequestBody String body) {
		return "Noi dung nhan duoc: " + body;
	}
}
