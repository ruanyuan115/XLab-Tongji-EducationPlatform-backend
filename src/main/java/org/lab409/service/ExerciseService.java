package org.lab409.service;

import org.lab409.entity.Exercise;
import org.lab409.entity.ExerciseChoice;
import org.lab409.entity.StudentExerciseScore;
import org.lab409.entity.ResultEntity;

import java.util.List;

public interface ExerciseService {
    ResultEntity findOneExerice(Integer exerciseId);
    ResultEntity addExercise(Exercise exercise);
    ResultEntity answerAll(List<String> answers, Integer studentId, Integer chapterId,String type, String comment,Integer rate);
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
    ResultEntity correctAll(List<Integer> scores, Integer studentId,Integer chapterId,String type);
    ResultEntity viewExercise(Integer chapterId,String type);
    ResultEntity viewSomeAnswer(Integer chapterId,Integer studentId,String type);
    int calculateScore(Integer chapterId,Integer studentId);
}
