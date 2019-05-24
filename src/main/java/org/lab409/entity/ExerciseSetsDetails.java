package org.lab409.entity;

import lombok.Data;

import java.util.List;

@Data
public class ExerciseSetsDetails {
    private List<ExerciseSet> exerciseSets;
    private Integer score;

    public ExerciseSetsDetails() {
    }

    public ExerciseSetsDetails(List<ExerciseSet> exerciseSets, Integer score) {
        this.exerciseSets = exerciseSets;
        this.score = score;
    }
}
