package julian.service;

import java.util.List;

import julian.model.TinTuc;

public interface TinTucService {
	List<TinTuc> findAll();

	TinTuc save(TinTuc loai);

	void deleteById(Integer id);

	TinTuc findById(Integer id);
}
