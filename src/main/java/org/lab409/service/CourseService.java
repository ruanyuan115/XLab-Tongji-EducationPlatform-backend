package org.lab409.service;

import org.lab409.entity.*;

import java.util.ArrayList;

public interface CourseService
{
    Integer addNewCourse(CourseInfo courseInfo);
    ArrayList<CourseInfo> getStuCourseList(Integer studentID);
    CourseInfo getCourseByCode(String courseCode);
    Integer joinCourse(Integer studentID,Integer courseID);
    Integer addCourseNotice(CourseNotice courseNotice);
    CourseNotice getNoticeByCouID(Integer courseID);
    CourseInfo getCourseInfoByID(Integer courseID);
    Integer deleteCourse(Integer courseID);
    Integer deleteCourseNotice(Integer courseID);
    ChapterNode addChapter(ChapterNode chapterNode);
    ChapterNode getChapterByID(Integer chapterID);
    ArrayList<CourseCatalog> getCourseCatalog(Integer courseID);
    ArrayList<StudentChapter> getCourseScoreAndComment(Integer courseID,Integer studentID);
    Takes getCurrentProgress(Integer courseID,Integer studentID);
    Integer alertCurrentProgress(Integer courseID,Integer studentID,Integer chapterID);
}
