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
import julian.services.PostService;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	private PostService postService;

	@GetMapping("/all")
	public String listPosts(ModelMap model) {
		List<Post> posts = postService.getAllPosts();
		model.addAttribute("posts", posts);
		return "post_list";
	}

	@GetMapping("/delete/{id}")
	public String deletePost(@PathVariable("id") Integer id) {
		postService.deletePostById(id);
		return "redirect:/post/all";
	}

	@GetMapping("/new")
	public String showNewPostForm() {
		return "post_new";
	}

	@PostMapping("/new")
	public String addNewPost(@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam("categoryId") Integer categoryId,
			@RequestParam(value = "thumbnailImage", required = false) String thumbnailImage) {

		Post newPost = new Post(null, title, content, categoryId, thumbnailImage);

		postService.savePost(newPost);
		return "redirect:/post/all";
	}

	@GetMapping("/view/{id}")
	public String viewPost(@PathVariable("id") Integer id, ModelMap model) {
		Post post = postService.getPostById(id);
		model.addAttribute("post", post);
		return "post_view";
	}

	@GetMapping("/edit/{id}")
	public String showEditPostForm(@PathVariable("id") Integer id, ModelMap model) {
		Post post = postService.getPostById(id);
		model.addAttribute("post", post);
		return "post_edit";
	}

	@PostMapping("/edit")
	public String editPost(@RequestParam("id") Integer id, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam("categoryId") Integer categoryId,
			@RequestParam(value = "thumbnailImage", required = false) String thumbnailImage) {

		Post p = postService.getPostById(id);

		if (p != null) {
			p.setTitle(title);
			p.setContent(content);
			p.setCategoryId(categoryId);
			p.setThumbnailImage(thumbnailImage);

			postService.savePost(p);
		}
		return "redirect:/post/all";
	}
}