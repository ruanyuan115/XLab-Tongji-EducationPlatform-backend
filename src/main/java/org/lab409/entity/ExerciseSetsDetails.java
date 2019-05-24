package org.lab409.entity;

import lombok.Data;

import java.util.List;

@Data
public class ExerciseSetsDetails {
    private List<ExerciseSet> exerciseSets;
    private List<Integer> scores;

    public ExerciseSetsDetails() {
    }

    public ExerciseSetsDetails(List<ExerciseSet> exerciseSets, List<Integer> scores) {
        this.exerciseSets = exerciseSets;
        this.scores = scores;
    }
}
