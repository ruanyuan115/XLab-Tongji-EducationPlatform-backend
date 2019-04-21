package org.lab409.entity;

import lombok.Data;

import java.lang.reflect.Array;
import java.util.ArrayList;

@Data
public class CourseAndClassList
{
    private CourseInfo courseInfo;
    private ArrayList<CourseClass>courseClasses;
    public CourseAndClassList(CourseInfo courseInfo,ArrayList<CourseClass>courseClasses)
    {
        this.courseInfo=courseInfo;
        this.courseClasses=courseClasses;
    }
}
