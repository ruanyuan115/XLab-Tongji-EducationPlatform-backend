package org.lab409.dao;
import org.lab409.entity.StudentExerciseScore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface StudentExerciseScoreDao extends JpaRepository<StudentExerciseScore,Integer>{
    StudentExerciseScore findById(int id);
    StudentExerciseScore findByExerciseIdAndStudentId(int exerciseId,int studentId);
}
