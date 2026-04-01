package julian.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import julian.models.JobReasons;
import julian.service.GeminiService; // Đổi import

@RestController
@RequestMapping("/api/ai")
public class AiController { // Đổi tên class

	private final GeminiService geminiService; // Đổi tên biến

	public AiController(GeminiService geminiService) {
		this.geminiService = geminiService;
	}

	@GetMapping("/job-reasons")
	public ResponseEntity<JobReasons> getReasons(@RequestParam(name = "count", defaultValue = "3") int count,
			@RequestParam(name = "job", defaultValue = "Lập trình viên Android") String job,
			@RequestParam(name = "location", defaultValue = "Nha Trang") String location) {

		JobReasons response = geminiService.getJobReasons(count, job, location);
		return ResponseEntity.ok(response);
	}
}