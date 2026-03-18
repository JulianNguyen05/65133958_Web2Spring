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
import julian.repository.PageRepository;

@Controller
@RequestMapping("/page")
public class PageController {

	// Tiêm (Inject) PageRepository để giao tiếp với bảng Page trong MySQL
	@Autowired
	private PageRepository pageRepository;

	@GetMapping("/all")
	public String listPages(ModelMap model) {
		// Lấy toàn bộ danh sách Page từ Database
		List<Page> pages = pageRepository.findAll();
		model.addAttribute("pages", pages);
		return "page_list";
	}

	@GetMapping("/delete/{id}")
	public String deletePage(@PathVariable("id") Integer id) {
		// Xóa thẳng dòng dữ liệu trong CSDL dựa vào ID
		pageRepository.deleteById(id);
		return "redirect:/page/all";
	}

	@GetMapping("/new")
	public String showNewPageForm() {
		return "page_new";
	}

	@PostMapping("/new")
	public String addNewPage(
			// LƯU Ý: Đã bỏ @RequestParam("id") vì MySQL sẽ tự động sinh ID (AUTO_INCREMENT)
			@RequestParam("pageName") String pageName, @RequestParam("keyword") String keyword,
			@RequestParam("content") String content,
			@RequestParam(value = "parentPageId", required = false) Integer parentPageId) {

		// Khởi tạo Page mới, truyền 'null' vào vị trí của ID
		Page newPage = new Page(null, pageName, keyword, content, parentPageId);

		// Lưu vào Database (JPA sẽ tự động dùng lệnh INSERT)
		pageRepository.save(newPage);
		return "redirect:/page/all";
	}

	@GetMapping("/view/{id}")
	public String viewPage(@PathVariable("id") Integer id, ModelMap model) {
		// Tìm Page theo ID trong Database
		Page page = pageRepository.findById(id).orElse(null);
		model.addAttribute("page", page);
		return "page_view";
	}

	@GetMapping("/edit/{id}")
	public String showEditPageForm(@PathVariable("id") Integer id, ModelMap model) {
		Page page = pageRepository.findById(id).orElse(null);
		model.addAttribute("page", page);
		return "page_edit";
	}

	@PostMapping("/edit")
	public String editPage(@RequestParam("id") Integer id, @RequestParam("pageName") String pageName,
			@RequestParam("keyword") String keyword, @RequestParam("content") String content,
			@RequestParam(value = "parentPageId", required = false) Integer parentPageId) {

		// Tìm Page cũ trong Database để cập nhật
		Page p = pageRepository.findById(id).orElse(null);

		if (p != null) {
			// Thay đổi các thông tin mới
			p.setPageName(pageName);
			p.setKeyword(keyword);
			p.setContent(content);
			p.setParentPageId(parentPageId);

			// Lưu lại (JPA nhận thấy ID đã tồn tại nên sẽ tự động dùng lệnh UPDATE)
			pageRepository.save(p);
		}
		return "redirect:/page/all";
	}
}