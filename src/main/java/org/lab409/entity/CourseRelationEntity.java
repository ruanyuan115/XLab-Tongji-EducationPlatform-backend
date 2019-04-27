package org.lab409.entity;

import lombok.Data;

import java.util.ArrayList;

@Data
public class CourseRelationEntity
{
    private CourseName courseName;
    private ArrayList<CourseName>preCoursesName;
    private ArrayList<CourseName>subCoursesName;
    public CourseRelationEntity(CourseName courseName,ArrayList<CourseName>preCoursesName,ArrayList<CourseName>subCoursesName)
    {
        this.courseName=courseName;
        this.preCoursesName=preCoursesName;
        this.subCoursesName=subCoursesName;
    }
}
