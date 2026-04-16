package julian.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import julian.service.TinTucService;

@Controller
public class TinTucController {

	@Autowired
	private TinTucService tinTucService;

	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("tintucs", tinTucService.findAll());
		return "index";
	}

	@GetMapping("/tintuc/{id}")
	public String chiTiet(@PathVariable Integer id, Model model) {
		model.addAttribute("tin", tinTucService.findById(id));
		return "chitiet";
	}
}
