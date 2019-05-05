package org.lab409.entity;

import lombok.Data;
import org.lab409.service.CourseService;
import org.lab409.util.SpringContextUtil;

@Data
public class CourseAndClass
{
    private CourseInfo courseInfo;
    private CourseClass courseClass;
    private String courseNameID;
    public CourseAndClass(CourseInfo courseInfo,CourseClass courseClass)throws CloneNotSupportedException
    {
        CourseService courseService= SpringContextUtil.getBean(CourseService.class);
        CourseInfo temp=courseInfo.clone();
        temp.setCourseName(courseService.getCourseNameByNameID(Integer.parseInt(courseInfo.getCourseName())).getCourseName());
        this.courseInfo=temp;
        this.courseClass=courseClass;
        this.courseNameID=courseInfo.getCourseName();
    }
}
