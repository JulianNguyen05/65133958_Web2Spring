package julian.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import julian.model.Student;
import julian.model.Topic;
import julian.service.StudentService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/student")
@RequiredArgsConstructor
public class StudentController {

	private final StudentService studentService;

	@GetMapping("/all")
	public String listStudents(Model model) {
		model.addAttribute("topics", studentService.getAll());
		return "student/list";
	}

	@GetMapping("/new")
	public String showAddForm(Model model) {
		model.addAttribute("student", new Topic());
		return "student/form";
	}

	@PostMapping("/new")
	public String addStudent(@ModelAttribute Student student) {
		studentService.add(student);
		return "redirect:/student/all";
	}

	@GetMapping("/view/{id}")
	public String viewStudent(@PathVariable String id, Model model) {
		model.addAttribute("topic", studentService.getById(id));
		return "student/view";
	}

	@GetMapping("/delete/{id}")
	public String deleteStudent(@PathVariable String id) {
		studentService.delete(id);
		return "redirect:/student/all";
	}
}