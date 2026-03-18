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

import julian.models.Post;
import julian.repository.PostRepository;

@Controller
@RequestMapping("/post")
public class PostController {

	// Tiêm (Inject) PostRepository để giao tiếp với CSDL
	@Autowired
	private PostRepository postRepository;

	@GetMapping("/all")
	public String listPosts(ModelMap model) {
		// Lấy tất cả bài viết từ MySQL thay vì MockData
		List<Post> posts = postRepository.findAll();
		model.addAttribute("posts", posts);
		return "post_list";
	}

	@GetMapping("/delete/{id}")
	public String deletePost(@PathVariable("id") Integer id) {
		// Xóa thẳng trong MySQL bằng ID
		postRepository.deleteById(id);
		return "redirect:/post/all";
	}

	@GetMapping("/new")
	public String showNewPostForm() {
		return "post_new";
	}

	@PostMapping("/new")
	public String addNewPost(
			// LƯU Ý: Đã bỏ @RequestParam("id") vì MySQL sẽ tự động tăng ID
			@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam("categoryId") Integer categoryId,
			@RequestParam(value = "thumbnailImage", required = false) String thumbnailImage) {

		// Tạo đối tượng Post mới (truyền null cho ID để DB tự tạo)
		Post newPost = new Post(null, title, content, categoryId, thumbnailImage);

		// Lưu vào MySQL
		postRepository.save(newPost);
		return "redirect:/post/all";
	}

	@GetMapping("/view/{id}")
	public String viewPost(@PathVariable("id") Integer id, ModelMap model) {
		// Tìm bài viết theo ID trong DB
		Post post = postRepository.findById(id).orElse(null);
		model.addAttribute("post", post);
		return "post_view";
	}

	@GetMapping("/edit/{id}")
	public String showEditPostForm(@PathVariable("id") Integer id, ModelMap model) {
		Post post = postRepository.findById(id).orElse(null);
		model.addAttribute("post", post);
		return "post_edit";
	}

	@PostMapping("/edit")
	public String editPost(@RequestParam("id") Integer id, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam("categoryId") Integer categoryId,
			@RequestParam(value = "thumbnailImage", required = false) String thumbnailImage) {

		// Tìm bài viết cũ trong DB
		Post p = postRepository.findById(id).orElse(null);

		if (p != null) {
			// Cập nhật thông tin mới
			p.setTitle(title);
			p.setContent(content);
			p.setCategoryId(categoryId);
			p.setThumbnailImage(thumbnailImage);

			// Hàm save() nếu thấy ID đã tồn tại thì nó sẽ tự động UPDATE thay vì INSERT
			postRepository.save(p);
		}
		return "redirect:/post/all";
	}
}