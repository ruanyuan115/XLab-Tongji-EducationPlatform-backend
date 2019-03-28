package org.lab409.service;

import org.lab409.entity.CourseInfo;
import org.lab409.entity.ResultEntity;

import java.util.ArrayList;

public interface CourseService
{
    Integer addNewCourse(CourseInfo courseInfo);
    ArrayList<CourseInfo> getStuCourseList(Integer studentID);
    CourseInfo getCourseByCode(String courseCode);
    Integer joinCourse(Integer studentID,Integer courseID);
}
