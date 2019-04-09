package org.lab409.entity;
import java.util.List;
public class ExerciseSet {
    private Exercise exercise;
    private List<ExerciseChoice> exerciseChoiceList;
    private String answer;
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

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public ExerciseSet() {
    }

    public ExerciseSet(Exercise exercise, List<ExerciseChoice> exerciseChoiceList) {
        this.exercise = exercise;
        this.exerciseChoiceList = exerciseChoiceList;
    }

    public ExerciseSet(Exercise exercise, List<ExerciseChoice> exerciseChoiceList, String answer) {
        this.exercise = exercise;
        this.exerciseChoiceList = exerciseChoiceList;
        this.answer = answer;
    }

    public ExerciseSet(Exercise exercise, String answer) {
        this.exercise = exercise;
        this.answer = answer;
    }

    public ExerciseSet(Exercise exercise) {
        this.exercise = exercise;
    }
}
