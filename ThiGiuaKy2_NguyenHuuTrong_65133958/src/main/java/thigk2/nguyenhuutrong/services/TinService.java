package thigk2.nguyenhuutrong.services;

import java.util.List;

import thigk2.nguyenhuutrong.models.Tin;

public interface TinService {
	List<Tin> layTatCaTin();

	List<Tin> layTinTheoTheLoai(Long theLoaiId);

	Tin layChiTietTin(Long id);
}