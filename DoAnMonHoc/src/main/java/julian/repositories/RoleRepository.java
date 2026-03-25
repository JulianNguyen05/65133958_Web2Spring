package julian.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import julian.models.Role;

public interface RoleRepository extends JpaRepository<Role, Long> {
	Optional<Role> findByName(String name);
}
