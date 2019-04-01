package org.lab409.entity;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Table(name="exercise_choice")
@DynamicInsert
@Data
@EntityListeners(AuditingEntityListener.class)
public class ExerciseChoice {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "exercise_id")
    private Integer exerciseId;
    @Column(name = "exercice_choice_id")
    private String exerciceChoiceId;
    @Column(name = "choice")
    private String choice;
    public ExerciseChoice() {
    }

    public ExerciseChoice(Integer exerciseId, String exerciceChoiceId, String choice) {
        this.exerciseId = exerciseId;
        this.exerciceChoiceId = exerciceChoiceId;
        this.choice = choice;
    }
}
