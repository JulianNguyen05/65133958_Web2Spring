package julian.controller;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import julian.models.Page;
import julian.repository.MockData;

@RestController
@RequestMapping("/api/page")
public class APIController {

	@GetMapping("/all")
	public List<Page> getAllPages() {
		return MockData.pages;
	}

	@PostMapping("/add")
	public Page addPage(@RequestBody Page newPage) {
		MockData.pages.add(newPage);
		return newPage;
	}

	@PutMapping("/edit/{id}")
	public Page editPage(@PathVariable("id") int id, @RequestBody Page updatedPage) {
		for (Page p : MockData.pages) {
			if (p.getId() == id) {
				p.setPageName(updatedPage.getPageName());
				p.setKeyword(updatedPage.getKeyword());
				p.setContent(updatedPage.getContent());
				p.setParentPageId(updatedPage.getParentPageId());
				return p;
			}
		}
		return null;
	}

	@DeleteMapping("/delete/{id}")
	public String deletePage(@PathVariable("id") int id) {
		boolean isRemoved = MockData.pages.removeIf(p -> p.getId() == id);
		if (isRemoved) {
			return "Đã xóa thành công Page có ID: " + id;
		} else {
			return "Không tìm thấy Page có ID: " + id;
		}
	}
}