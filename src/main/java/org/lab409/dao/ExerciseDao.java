package org.lab409.dao;
import org.lab409.entity.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ExerciseDao extends JpaRepository<Exercise,Integer>{
    List<Exercise> findByChapterIdAndExerciseTypeOrderByExerciseNumber(int chapterId,int exerciseType);
    Exercise findByExerciseId(int id);
    List<Exercise> findByChapterId(int id);
}
