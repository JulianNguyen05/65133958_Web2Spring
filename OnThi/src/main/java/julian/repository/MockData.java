package julian.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import julian.models.Page;
import julian.models.Post;

@Service
public class MockData {
	public static List<Page> pages = new ArrayList<>();
	public static List<Post> posts = new ArrayList<>();

	public MockData() {
		pages.add(new Page(1, "Trang chủ", "home, main", "Nội dung trang chủ", null));
		pages.add(new Page(2, "Giới thiệu", "about", "Nội dung giới thiệu", 1));

		posts.add(new Post(1, "Bài viết 1", "Nội dung bài viết 1", 10));
		posts.add(new Post(2, "Bài viết 2", "Nội dung bài viết 2", 10));
	}
}
