package julian.service;

import java.util.List;

import org.springframework.stereotype.Service;

import julian.model.Student;
import julian.repository.StudentRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StudentService {

	private final StudentRepository studentRepository;

	public List<Student> getAll() {
		return studentRepository.findAll();
	}

	public Student getById(String id) {
		return studentRepository.findById(id).orElse(null);
	}

	public void add(Student student) {
		studentRepository.save(student);
	}

	public void delete(String id) {
		studentRepository.deleteById(id);
	}
}