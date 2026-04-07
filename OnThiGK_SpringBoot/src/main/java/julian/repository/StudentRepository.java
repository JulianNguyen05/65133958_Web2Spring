package julian.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import julian.model.Student;

@Repository
public interface StudentRepository extends JpaRepository<Student, String> {
}