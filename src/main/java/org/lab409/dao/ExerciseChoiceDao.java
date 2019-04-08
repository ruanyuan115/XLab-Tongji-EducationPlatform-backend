package org.lab409.dao;
import org.lab409.entity.ExerciseChoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ExerciseChoiceDao extends JpaRepository<ExerciseChoice,Integer>{
    List<ExerciseChoice> findByExerciseIdOrderByExerciceChoiceId(int exerciseId);
    ExerciseChoice findById(int id);
}
