package org.lab409.entity;

import lombok.Data;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

@Data
public class CourseAndClassList
{
    private CourseInfo courseInfo;
    private ArrayList<CourseClass>courseClasses;
    private String courseName;
    public CourseAndClassList(CourseInfo courseInfo,ArrayList<CourseClass>courseClasses)
    {
        this.courseInfo=courseInfo;
        this.courseClasses=courseClasses;
    }

    public CourseAndClassList(CourseInfo courseInfo, ArrayList<CourseClass> courseClasses, String courseName) {
        this.courseInfo = courseInfo;
        this.courseClasses = courseClasses;
        this.courseName = courseName;
    }

    public CourseAndClassList(CourseInfo courseInfo,CourseClass courseClass,String courseName) {
        this.courseInfo = courseInfo;
        courseClasses=new ArrayList<>();
        this.courseClasses.add(courseClass);
        this.courseName=courseName;
    }
}
