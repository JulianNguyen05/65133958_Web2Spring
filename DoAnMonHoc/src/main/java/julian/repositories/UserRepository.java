package julian.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import julian.models.User;

public interface UserRepository extends JpaRepository<User, Long> {
	Optional<User> findByUsername(String username);
}
