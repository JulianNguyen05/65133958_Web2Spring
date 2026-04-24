package thigk2.nguyenhuutrong.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import thigk2.nguyenhuutrong.models.Tin;
import thigk2.nguyenhuutrong.repositories.TinRepository;

@Service
public class TinServiceImpl implements TinService {

	@Autowired
	private TinRepository tinRepository;

	@Override
	public List<Tin> layTatCaTin() {
		return tinRepository.findAll();
	}

	@Override
	public List<Tin> layTinTheoTheLoai(Long theLoaiId) {
		return tinRepository.findByTheLoaiTinId(theLoaiId);
	}

	@Override
	public Tin layChiTietTin(Long id) {
		return tinRepository.findById(id).orElse(null);
	}
}