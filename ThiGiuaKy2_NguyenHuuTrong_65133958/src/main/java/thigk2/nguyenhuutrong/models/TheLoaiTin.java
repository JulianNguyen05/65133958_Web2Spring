package thigk2.nguyenhuutrong.models;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "categories")
public class TheLoaiTin {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "name")
	private String tenLoai;

	@JsonIgnore
	@OneToMany(mappedBy = "theLoaiTin", cascade = CascadeType.ALL)
	private List<Tin> dsTin;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTenLoai() {
		return tenLoai;
	}

	public void setTenLoai(String tenLoai) {
		this.tenLoai = tenLoai;
	}

	public List<Tin> getDsTin() {
		return dsTin;
	}

	public void setDsTin(List<Tin> dsTin) {
		this.dsTin = dsTin;
	}

}