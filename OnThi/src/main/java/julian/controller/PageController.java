package julian.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import julian.models.Page;
import julian.services.PageService;

@Controller
@RequestMapping("/page")
public class PageController {

	@Autowired
	private PageService pageService;

	@GetMapping("/all")
	public String listPages(ModelMap model) {
		List<Page> pages = pageService.getAllPages();
		model.addAttribute("pages", pages);
		return "page_list";
	}

	@GetMapping("/delete/{id}")
	public String deletePage(@PathVariable("id") Integer id) {
		pageService.deletePageById(id);
		return "redirect:/page/all";
	}

	@GetMapping("/new")
	public String showNewPageForm() {
		return "page_new";
	}

	@PostMapping("/new")
	public String addNewPage(@RequestParam("pageName") String pageName, @RequestParam("keyword") String keyword,
			@RequestParam("content") String content,
			@RequestParam(value = "parentPageId", required = false) Integer parentPageId) {

		Page newPage = new Page(null, pageName, keyword, content, parentPageId);

		pageService.savePage(newPage);
		return "redirect:/page/all";
	}

	@GetMapping("/view/{id}")
	public String viewPage(@PathVariable("id") Integer id, ModelMap model) {
		Page page = pageService.getPageById(id);
		model.addAttribute("page", page);
		return "page_view";
	}

	@GetMapping("/edit/{id}")
	public String showEditPageForm(@PathVariable("id") Integer id, ModelMap model) {
		Page page = pageService.getPageById(id);
		model.addAttribute("page", page);
		return "page_edit";
	}

	@PostMapping("/edit")
	public String editPage(@RequestParam("id") Integer id, @RequestParam("pageName") String pageName,
			@RequestParam("keyword") String keyword, @RequestParam("content") String content,
			@RequestParam(value = "parentPageId", required = false) Integer parentPageId) {

		Page p = pageService.getPageById(id);

		if (p != null) {
			p.setPageName(pageName);
			p.setKeyword(keyword);
			p.setContent(content);
			p.setParentPageId(parentPageId);

			pageService.savePage(p);
		}
		return "redirect:/page/all";
	}
}