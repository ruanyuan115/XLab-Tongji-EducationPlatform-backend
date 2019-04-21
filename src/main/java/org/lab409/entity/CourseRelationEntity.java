package org.lab409.entity;

import lombok.Data;

import java.util.ArrayList;

@Data
public class CourseRelationEntity
{
    private CourseName courseName;
    private ArrayList<CourseName>preCoursesName;
    public CourseRelationEntity(CourseName courseName,ArrayList<CourseName>preCoursesName)
    {
        this.courseName=courseName;
        this.preCoursesName=preCoursesName;
    }
}
