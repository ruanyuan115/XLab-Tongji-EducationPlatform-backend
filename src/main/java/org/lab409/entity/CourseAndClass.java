package org.lab409.entity;

import lombok.Data;

@Data
public class CourseAndClass
{
    private CourseInfo courseInfo;
    private CourseClass courseClass;
    public CourseAndClass(CourseInfo courseInfo,CourseClass courseClass)
    {
        this.courseInfo=courseInfo;
        this.courseClass=courseClass;
    }
}
