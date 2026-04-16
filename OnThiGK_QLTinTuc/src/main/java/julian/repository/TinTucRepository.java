package julian.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import julian.model.TinTuc;

public interface TinTucRepository extends JpaRepository<TinTuc, Integer> {
}