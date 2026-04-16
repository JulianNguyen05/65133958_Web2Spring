package julian.model;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "tin_tuc")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TinTuc {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private String tieuDe;
	private String noiDung;
	private LocalDateTime ngayDang = LocalDateTime.now();

	@ManyToOne
	@JoinColumn(name = "loai_tin_tuc_id")
	private LoaiTinTuc loaiTinTuc;
}
