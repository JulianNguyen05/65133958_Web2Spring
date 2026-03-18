package julian.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import julian.models.Page;
import julian.repository.PageRepository;

@Service
public class PageService {

	@Autowired
	private PageRepository pageRepository;

	public List<Page> getAllPages() {
		return pageRepository.findAll();
	}

	public Page getPageById(Integer id) {
		Optional<Page> optionalPage = pageRepository.findById(id);
		return optionalPage.orElse(null);
	}

	public Page savePage(Page page) {
		return pageRepository.save(page);
	}

	public void deletePageById(Integer id) {
		if (pageRepository.existsById(id)) {
			pageRepository.deleteById(id);
		}
	}
}