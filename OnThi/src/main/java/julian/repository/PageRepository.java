package julian.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import julian.models.Page;

@Repository
public interface PageRepository extends JpaRepository<Page, Integer> {
}