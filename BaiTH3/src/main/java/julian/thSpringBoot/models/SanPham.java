package julian.thSpringBoot.models;

public class SanPham {
	private String maSP;
	private String tenSP;
	private double gia;

	public SanPham(String maSP, String tenSP, double gia) {
		this.maSP = maSP;
		this.tenSP = tenSP;
		this.gia = gia;
	}

	public String getMaSP() {
		return maSP;
	}

	public String getTenSP() {
		return tenSP;
	}

	public double getGia() {
		return gia;
	}
}
