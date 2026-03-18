package julian.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import julian.models.Post;
import julian.repository.PostRepository;

@Service
public class PostService {

	@Autowired
	private PostRepository postRepository;

	public List<Post> getAllPosts() {
		return postRepository.findAll();
	}

	public Post getPostById(Integer id) {
		Optional<Post> optionalPost = postRepository.findById(id);
		return optionalPost.orElse(null);
	}

	public Post savePost(Post post) {
		return postRepository.save(post);
	}

	public void deletePostById(Integer id) {
		if (postRepository.existsById(id)) {
			postRepository.deleteById(id);
		}
	}
}