package julian.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import julian.models.Page;
import julian.repository.MockData;

@Controller
@RequestMapping("/page")
public class PageController {

	@GetMapping("/all")
	public String listPages(ModelMap model) {
		model.addAttribute("pages", MockData.pages);
		return "page_list";
	}

	@GetMapping("/delete/{id}")
	public String deletePage(@PathVariable("id") int id) {
		MockData.pages.removeIf(p -> p.getId() == id);
		return "redirect:/page/all";
	}

	@GetMapping("/new")
	public String showNewPageForm() {
		return "page_new";
	}

	@PostMapping("/new")
	public String addNewPage(@RequestParam("id") int id, @RequestParam("pageName") String pageName,
			@RequestParam("keyword") String keyword, @RequestParam("content") String content,
			@RequestParam(value = "parentPageId", required = false) Integer parentPageId) {

		Page newPage = new Page(id, pageName, keyword, content, parentPageId);
		MockData.pages.add(newPage);
		return "redirect:/page/all";
	}

	@GetMapping("/view/{id}")
	public String viewPage(@PathVariable("id") int id, ModelMap model) {
		Page page = MockData.pages.stream().filter(p -> p.getId() == id).findFirst().orElse(null);
		model.addAttribute("page", page);
		return "page_view";
	}

	@GetMapping("/edit/{id}")
	public String showEditPageForm(@PathVariable("id") int id, ModelMap model) {
		Page page = MockData.pages.stream().filter(p -> p.getId() == id).findFirst().orElse(null);
		model.addAttribute("page", page);
		return "page_edit";
	}

	@PostMapping("/edit")
	public String editPage(@RequestParam("id") int id, @RequestParam("pageName") String pageName,
			@RequestParam("keyword") String keyword, @RequestParam("content") String content,
			@RequestParam(value = "parentPageId", required = false) Integer parentPageId) {

		for (Page p : MockData.pages) {
			if (p.getId() == id) {
				p.setPageName(pageName);
				p.setKeyword(keyword);
				p.setContent(content);
				p.setParentPageId(parentPageId);
				break;
			}
		}
		return "redirect:/page/all";
	}
}