package thigk2.nguyenhuutrong.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import thigk2.nguyenhuutrong.models.TheLoaiTin;
import thigk2.nguyenhuutrong.repositories.TheLoaiTinRepository;

@Service
public class TheLoaiTinServiceImpl implements TheLoaiTinService {

	@Autowired
	private TheLoaiTinRepository theLoaiTinRepository;

	@Override
	public List<TheLoaiTin> layTatCaTheLoai() {
		return theLoaiTinRepository.findAll();
	}
}