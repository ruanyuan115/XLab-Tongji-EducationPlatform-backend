package org.lab409.entity;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Table(name="exercise")
@DynamicInsert
@Data
@EntityListeners(AuditingEntityListener.class)
public class Exercise {
    @Id
    @Column(name = "exercise_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer exerciseId;
    @Column(name = "chapter_Id")
    private Integer chapterId;
    @Column(name = "exercise_type")
    private Integer exerciseType;
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

    public Exercise() {
    }

    public Exercise(Integer chapterId, Integer exerciseType, Integer exerciseNumber, String exerciseContent, String exerciseAnswer, String exerciseAnalysis, Integer exercisePoint) {
        this.chapterId = chapterId;
        this.exerciseType = exerciseType;
        this.exerciseNumber = exerciseNumber;
        this.exerciseContent = exerciseContent;
        this.exerciseAnswer = exerciseAnswer;
        this.exerciseAnalysis = exerciseAnalysis;
        this.exercisePoint = exercisePoint;
    }
}
