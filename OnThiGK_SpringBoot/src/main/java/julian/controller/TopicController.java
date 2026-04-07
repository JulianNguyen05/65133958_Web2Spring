package julian.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import julian.model.Topic;
import julian.service.TopicService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/topic")
@RequiredArgsConstructor
public class TopicController {

	private final TopicService topicService;

	@GetMapping("/all")
	public String listTopics(Model model) {
		model.addAttribute("topics", topicService.getAll());
		return "topic/list";
	}

	@GetMapping("/new")
	public String showAddForm(Model model) {
		model.addAttribute("topic", new Topic());
		return "topic/form";
	}

	@PostMapping("/new")
	public String addTopic(@ModelAttribute Topic topic) {
		topicService.add(topic);
		return "redirect:/topic/all";
	}

	@GetMapping("/view/{id}")
	public String viewTopic(@PathVariable String id, Model model) {
		model.addAttribute("topic", topicService.getById(id));
		return "topic/view";
	}

	@GetMapping("/delete/{id}")
	public String deleteTopic(@PathVariable String id) {
		topicService.delete(id);
		return "redirect:/topic/all";
	}
}