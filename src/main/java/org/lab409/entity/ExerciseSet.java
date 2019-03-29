package org.lab409.entity;
import java.util.List;
public class ExerciseSet {
    private Exercise exercise;
    private List<ExerciseChoice> exerciseChoiceList;

    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }

    public List<ExerciseChoice> getExerciseChoiceList() {
        return exerciseChoiceList;
    }

    public void setExerciseChoiceList(List<ExerciseChoice> exerciseChoiceList) {
        this.exerciseChoiceList = exerciseChoiceList;
    }

    public ExerciseSet() {
    }

    public ExerciseSet(Exercise exercise, List<ExerciseChoice> exerciseChoiceList) {
        this.exercise = exercise;
        this.exerciseChoiceList = exerciseChoiceList;
    }

    public ExerciseSet(Exercise exercise) {
        this.exercise = exercise;
    }
}
