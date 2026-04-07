package julian.config;

import java.util.List;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import julian.model.Student;
import julian.model.Topic;
import julian.repository.StudentRepository;
import julian.repository.TopicRepository;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class DataSeeder implements CommandLineRunner {

	private final TopicRepository topicRepository;
	private final StudentRepository studentRepository;

	@Override
	public void run(String... args) throws Exception {
		if (topicRepository.count() == 0) {
			Topic t1 = new Topic("T01", "Website Quản lý Bán Hàng", "Dùng Spring Boot và React", "GV01", "Đồ án");
			Topic t2 = new Topic("T02", "App Điểm Danh Sinh Viên", "Nhận diện khuôn mặt với AI", "GV02",
					"Nghiên cứu khoa học");
			Topic t3 = new Topic("T03", "Hệ thống IOT Nông nghiệp", "Giám sát độ ẩm tự động", "GV01", "Bài tập lớn");

			topicRepository.saveAll(List.of(t1, t2, t3));
			System.out.println("✅ Đã nạp dữ liệu mẫu cho bảng Topic!");
		}

		if (studentRepository.count() == 0) {
			Student s1 = new Student("SV01", "Nguyễn Văn A", "Nhom_01");
			Student s2 = new Student("SV02", "Trần Thị B", "Nhom_01");
			Student s3 = new Student("SV03", "Lê Văn C", "Nhom_02");

			studentRepository.saveAll(List.of(s1, s2, s3));
			System.out.println("✅ Đã nạp dữ liệu mẫu cho bảng Student!");
		}
	}
}