package julian.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import julian.models.Post;
import julian.repository.MockData;

@Controller
@RequestMapping("/post")
public class PostController {

	@GetMapping("/all")
	public String listPosts(ModelMap model) {
		model.addAttribute("posts", MockData.posts);
		return "post_list";
	}

	@GetMapping("/delete/{id}")
	public String deletePost(@PathVariable("id") int id) {
		MockData.posts.removeIf(p -> p.getId() == id);
		return "redirect:/post/all";
	}

	@GetMapping("/new")
	public String showNewPostForm() {
		return "post_new";
	}

	@PostMapping("/new")
	public String addNewPost(@RequestParam("id") int id, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam("categoryId") int categoryId) {

		Post newPost = new Post(id, title, content, categoryId);
		MockData.posts.add(newPost);
		return "redirect:/post/all";
	}

	@GetMapping("/view/{id}")
	public String viewPost(@PathVariable("id") int id, ModelMap model) {
		Post post = MockData.posts.stream().filter(p -> p.getId() == id).findFirst().orElse(null);
		model.addAttribute("post", post);
		return "post_view";
	}

	@GetMapping("/edit/{id}")
	public String showEditPostForm(@PathVariable("id") int id, ModelMap model) {
		Post post = MockData.posts.stream().filter(p -> p.getId() == id).findFirst().orElse(null);
		model.addAttribute("post", post);
		return "post_edit";
	}

	@PostMapping("/edit")
	public String editPost(@RequestParam("id") int id, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam("categoryId") int categoryId) {

		for (Post p : MockData.posts) {
			if (p.getId() == id) {
				p.setTitle(title);
				p.setContent(content);
				p.setCategoryId(categoryId);
				break;
			}
		}
		return "redirect:/post/all";
	}
}