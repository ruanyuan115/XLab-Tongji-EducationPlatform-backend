package org.lab409.entity;
import javax.persistence.*;

@Entity
@Table(name="student_exercise_score")
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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(Integer exerciseId) {
        this.exerciseId = exerciseId;
    }

    public String getStudentAnswer() {
        return studentAnswer;
    }

    public void setStudentAnswer(String studentAnswer) {
        this.studentAnswer = studentAnswer;
    }

    public Integer getExerciseScore() {
        return exerciseScore;
    }

    public void setExerciseScore(Integer exerciseScore) {
        this.exerciseScore = exerciseScore;
    }

    public StudentExerciseScore() {
    }

    public StudentExerciseScore(Integer studentId, Integer exerciseId, String studentAnswer, Integer exerciseScore) {
        this.studentId = studentId;
        this.exerciseId = exerciseId;
        this.studentAnswer = studentAnswer;
        this.exerciseScore = exerciseScore;
    }
}
