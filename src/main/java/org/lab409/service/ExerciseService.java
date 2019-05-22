package org.lab409.service;

import org.lab409.entity.*;

import java.util.List;
import java.util.Map;

public interface ExerciseService {
    ResultEntity findOneExerice(Integer exerciseId);
    ResultEntity addExercise(Exercise exercise);
    ResultEntity answerAll(List<String> answers, Integer studentId, Integer chapterId,String type, String comment,Integer rate) throws Exception;
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
    ResultEntity rateNumber(Integer chapterId);
    List<CourseInfo> findCourses(String courseName,int teacherId);
    List<CourseInfo> findCoursesById(int courseId,int teacherId);
    List<ChapterNode> copyChapter(int sourceCourseId,int aimCourseId);
    boolean copyExercise(int sourceChapterId,int aimChapterId,String type);
    List<Integer> exerciseScore(int studentId,int chapterId,String type);
    int calculateScore(Integer chapterId,Integer studentId);
    List<List<String>> getPrecourse(String courseName);
    List<String> getPrecouseName(String courseName);
    List<String> getCoursesName(List<CourseRelation> courseRelations);
    boolean learnBad(int studentId,int courseId);
    String getCourseName(int courseId);
    Map<String,Float> userLabel(int studentId);
    List<CourseInfo> currentCourse(int year,String semester);
    List<UnratedChapter> getUnratedChapters(int classId);
}
