package org.lab409.service;

import org.lab409.entity.Exercise;
import org.lab409.entity.ExerciseChoice;
import org.lab409.entity.StudentExerciseScore;
import org.lab409.entity.ResultEntity;

public interface ExerciseService {
    ResultEntity findOneExerice(Integer exerciseId);
    ResultEntity addExercise(Exercise exercise);
    ResultEntity deleteExercise(Integer exerciseId);
    ResultEntity alterExercise(Exercise exercise);
    ResultEntity addExerciseChoice(ExerciseChoice exerciseChoice);
    ResultEntity deleteExerciseChoice(Integer exerciseChoiceId);
    ResultEntity alterExerciseChoice(ExerciseChoice exerciseChoice);
    ResultEntity findOneAnswer(Integer exerciseId,Integer studentId);
    ResultEntity findOneAnswerById(Integer studentExerciseScoreId);
    ResultEntity answerOne(String answer,Integer exerciseId,Integer studentId);
    ResultEntity alterAnswer(String answer,Integer exerciseId,Integer studentId);
    ResultEntity correctOne(Integer studentExerciseScoreId,Integer score);
    ResultEntity viewExercise(Integer chapterId,String type);
    int calculateScore(Integer chapterId,Integer studentId);
}
