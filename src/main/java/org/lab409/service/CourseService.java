package org.lab409.service;

import org.lab409.entity.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface CourseService
{
    Integer addNewCourse(CourseInfo courseInfo);
    Integer addClass(CourseClass courseClass);
    Integer alertClassInfo(CourseClass courseClass);
    ArrayList<CourseAndClass> getStuCourseList(Integer studentID)throws CloneNotSupportedException;
    CourseAndClass getCourseByCode(String courseCode)throws CloneNotSupportedException;
    Integer joinCourse(Integer studentID,Integer courseID);
    Integer addCourseNotice(CourseNotice courseNotice);
    CourseNotice getNoticeByCouID(Integer courseID);
    CourseInfo getCourseInfoByID(Integer courseID);
    CourseClass getClassInfoByID(Integer courseClassID);
    Integer deleteCourse(Integer courseID);
    Integer deleteCourseNotice(Integer courseID);
    ChapterNode addChapter(ChapterNode chapterNode);
    ChapterNode getChapterByID(Integer chapterID);
    ArrayList<CourseCatalog> getCourseCatalog(Integer courseID);
    ArrayList<StudentChapter> getCourseScoreAndComment(Integer courseID,Integer studentID);
    Takes getCurrentProgress(Integer courseID,Integer studentID);
    Integer alertCurrentProgress(Integer courseID,Integer studentID,Integer chapterID);
    void deleteChapter(CourseCatalog courseCatalog);
    ArrayList<CourseClass>getClassesByCourseID(Integer courseID);
    Integer deleteClass(Integer courseClassID);
    ArrayList<CourseAndClass> getCoursesByTeacherID(Integer teacherID)throws CloneNotSupportedException;
    ArrayList<UserInfo>getStudentsByClassID(Integer courseClassId);
    List<CourseInfo> getAllCourses();
    List<CourseRelationEntity>getAllCoursesRelation();
    List<ChapterRelationEntity>getChapterRelationByCourseID(Integer courseID);
    CourseName getCourseNameByNameID(Integer courseNameID);
    CourseName addCourseName(String courseName);
    List<CourseName>getCourseList();
    Integer alertCourseName(CourseName courseName);
    ArrayList<CourseAndClassList>getAllCoursesByNameID(String nameID);
    Integer addCourseRelation(Integer courseNameID,Integer preCourseNameID);
    Integer deleteCourseRelation(Integer courseNameID,Integer preCourseNameID);
    Integer addChapterRelation(Integer chapterID,Integer preChapterID);
    Integer deleteChapterRelation(Integer chapterID,Integer preChapterID);
    Map getStudentNumByTeacher(Integer teacherID)throws CloneNotSupportedException;
    Map getStudentNumBySemester(String semester)throws CloneNotSupportedException;
    Map getStudentNumByYear(Integer year)throws CloneNotSupportedException;
    Map getRateBySemesterAndYear(String courseName);
    ArrayList<CourseAndClass>getClassesByNIDAndTID(String courseNameID,Integer teacherID)throws CloneNotSupportedException;
    Map getTeacherListByNID(String courseNameID);
    Integer addStudentComment(Integer chapterID,Integer studentID,String comment,Integer rate);
}
