package com.julian.OnThiGK.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.julian.OnThiGK.models.Page;
import com.julian.OnThiGK.models.Post;

@Service
public class MockDataService {

	private List<Page> pages = new ArrayList<>();
	private List<Post> posts = new ArrayList<>();

	public MockDataService() {
		pages.add(new Page(1, "Trang Chủ", "home, index", "Nội dung trang chủ", null));
		pages.add(new Page(2, "Giới Thiệu", "about, info", "Nội dung giới thiệu", 1));

		posts.add(new Post(1, "Thông báo thi GK", "Sinh viên thi lúc 7h...", 10, "thumb_exam.png"));
		posts.add(new Post(2, "Hướng dẫn Spring Boot", "Cài đặt Spring Tool Suite...", 11, "thumb_spring.png"));
	}

	public List<Page> getAllPages() {
		return pages;
	}

	public List<Post> getAllPosts() {
		return posts;
	}

	public Page getPageById(int id) {
		return pages.stream().filter(p -> p.getId() == id).findFirst().orElse(null);
	}

	public void addPage(Page page) {
		int newId = pages.isEmpty() ? 1 : pages.get(pages.size() - 1).getId() + 1;
		page.setId(newId);
		pages.add(page);
	}

	public void deletePage(int id) {
		pages.removeIf(p -> p.getId() == id);
	}

	public void updatePage(Page updatedPage) {
		for (int i = 0; i < pages.size(); i++) {
			if (pages.get(i).getId() == updatedPage.getId()) {
				pages.set(i, updatedPage);
				break;
			}
		}
	}
}