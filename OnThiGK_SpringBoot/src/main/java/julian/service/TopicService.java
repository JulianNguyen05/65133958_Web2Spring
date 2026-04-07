package julian.service;

import java.util.List;

import org.springframework.stereotype.Service;

import julian.model.Topic;
import julian.repository.TopicRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TopicService {

	private final TopicRepository topicRepository;

	public List<Topic> getAll() {
		return topicRepository.findAll();
	}

	public Topic getById(String id) {
		return topicRepository.findById(id).orElse(null);
	}

	public void add(Topic topic) {
		topicRepository.save(topic);
	}

	public void delete(String id) {
		topicRepository.deleteById(id);
	}
}