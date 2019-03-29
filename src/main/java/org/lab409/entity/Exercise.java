package org.lab409.entity;
import javax.persistence.*;

@Entity
@Table(name="exercise")
public class Exercise {
    @Id
    @Column(name = "exercise_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer exerciseId;
    @Column(name = "chapter_Id")
    private Integer chapterId;
    @Column(name = "exercise_type")
    private String exerciseType;
    @Column(name = "exercise_number")
    private Integer exerciseNumber;
    @Column(name = "exercise_content")
    private String exerciseContent;
    @Column(name = "exercise_answer")
    private String exerciseAnswer;
    @Column(name = "exercise_analysis")
    private String exerciseAnalysis;
    @Column(name = "exercise_point")
    private Integer exercisePoint;

    public Integer getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(Integer exerciseId) {
        this.exerciseId = exerciseId;
    }

    public Integer getChapterId() {
        return chapterId;
    }

    public void setChapterId(Integer chapterId) {
        this.chapterId = chapterId;
    }

    public String getExerciseType() {
        return exerciseType;
    }

    public void setExerciseType(String exerciseType) {
        this.exerciseType = exerciseType;
    }

    public Integer getExerciseNumber() {
        return exerciseNumber;
    }

    public void setExerciseNumber(Integer exerciseNumber) {
        this.exerciseNumber = exerciseNumber;
    }

    public String getExerciseContent() {
        return exerciseContent;
    }

    public void setExerciseContent(String exerciseContent) {
        this.exerciseContent = exerciseContent;
    }

    public String getExerciseAnswer() {
        return exerciseAnswer;
    }

    public void setExerciseAnswer(String exerciseAnswer) {
        this.exerciseAnswer = exerciseAnswer;
    }

    public String getExerciseAnalysis() {
        return exerciseAnalysis;
    }

    public void setExerciseAnalysis(String exerciseAnalysis) {
        this.exerciseAnalysis = exerciseAnalysis;
    }

    public Integer getExercisePoint() {
        return exercisePoint;
    }

    public void setExercisePoint(Integer exercisePoint) {
        this.exercisePoint = exercisePoint;
    }

    public Exercise() {
    }

    public Exercise(Integer chapterId, String exerciseType, Integer exerciseNumber, String exerciseContent, String exerciseAnswer, String exerciseAnalysis, Integer exercisePoint) {
        this.chapterId = chapterId;
        this.exerciseType = exerciseType;
        this.exerciseNumber = exerciseNumber;
        this.exerciseContent = exerciseContent;
        this.exerciseAnswer = exerciseAnswer;
        this.exerciseAnalysis = exerciseAnalysis;
        this.exercisePoint = exercisePoint;
    }
}
