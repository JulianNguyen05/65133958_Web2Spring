package julian.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import julian.models.Page;
import julian.repository.PageRepository;

@RestController
@RequestMapping("/api/page")
public class APIController {

	// Tiêm PageRepository để làm việc với MySQL
	@Autowired
	private PageRepository pageRepository;

	@GetMapping("/all")
	public List<Page> getAllPages() {
		// Trả về toàn bộ dữ liệu từ bảng Page dưới dạng JSON
		return pageRepository.findAll();
	}

	@PostMapping("/add")
	public Page addPage(@RequestBody Page newPage) {
		// Đặt ID thành null để đảm bảo MySQL sẽ tự động tăng ID (tránh lỗi nếu người
		// dùng cố tình gửi kèm ID)
		newPage.setId(null);

		// Lưu vào Database và trả về chính object vừa được lưu (đã có ID mới)
		return pageRepository.save(newPage);
	}

	@PutMapping("/edit/{id}")
	public Page editPage(@PathVariable("id") Integer id, @RequestBody Page updatedPage) {
		// Tìm Page theo ID trong cơ sở dữ liệu
		Optional<Page> optionalPage = pageRepository.findById(id);

		if (optionalPage.isPresent()) {
			Page p = optionalPage.get(); // Lấy object thật ra

			// Cập nhật thông tin mới từ updatedPage
			p.setPageName(updatedPage.getPageName());
			p.setKeyword(updatedPage.getKeyword());
			p.setContent(updatedPage.getContent());
			p.setParentPageId(updatedPage.getParentPageId());

			// Lưu đè lại vào MySQL và trả về kết quả
			return pageRepository.save(p);
		}

		return null; // Nếu không tìm thấy ID thì trả về null
	}

	@DeleteMapping("/delete/{id}")
	public String deletePage(@PathVariable("id") Integer id) {
		// Kiểm tra xem ID có tồn tại trong CSDL không trước khi xóa
		if (pageRepository.existsById(id)) {
			pageRepository.deleteById(id);
			return "Đã xóa thành công Page có ID: " + id;
		} else {
			return "Không tìm thấy Page có ID: " + id;
		}
	}
}