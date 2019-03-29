package org.lab409.entity;
import javax.persistence.*;

@Entity
@Table(name="exercise_choice")
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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(Integer exerciseId) {
        this.exerciseId = exerciseId;
    }

    public String getExerciceChoiceId() {
        return exerciceChoiceId;
    }

    public void setExerciceChoiceId(String exerciceChoiceId) {
        this.exerciceChoiceId = exerciceChoiceId;
    }

    public String getChoice() {
        return choice;
    }

    public void setChoice(String choice) {
        this.choice = choice;
    }

    public ExerciseChoice() {
    }

    public ExerciseChoice(Integer exerciseId, String exerciceChoiceId, String choice) {
        this.exerciseId = exerciseId;
        this.exerciceChoiceId = exerciceChoiceId;
        this.choice = choice;
    }
}
