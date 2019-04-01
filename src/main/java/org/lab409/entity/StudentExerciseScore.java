package org.lab409.entity;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Table(name="student_exercise_score")
@DynamicInsert
@Data
@EntityListeners(AuditingEntityListener.class)
public class StudentExerciseScore {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "student_id")
    private Integer studentId;
    @Column(name = "exercise_id")
    private Integer exerciseId;
    @Column(name = "student_answer")
    private String studentAnswer;
    @Column(name = "exercise_score")
    private Integer exerciseScore;
    public StudentExerciseScore() {
    }

    public StudentExerciseScore(Integer studentId, Integer exerciseId, String studentAnswer, Integer exerciseScore) {
        this.studentId = studentId;
        this.exerciseId = exerciseId;
        this.studentAnswer = studentAnswer;
        this.exerciseScore = exerciseScore;
    }
}
