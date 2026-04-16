package julian.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import julian.model.TinTuc;
import julian.repository.TinTucRepository;

@Service
public class TinTucServiceImpl implements TinTucService {
	@Autowired
	private TinTucRepository repo;

	@Override
	public List<TinTuc> findAll() {
		return repo.findAll();
	}

	@Override
	public TinTuc save(TinTuc tin) {
		return repo.save(tin);
	}

	@Override
	public void deleteById(Integer id) {
		repo.deleteById(id);
	}
}