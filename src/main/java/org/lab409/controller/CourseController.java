package org.lab409.controller;

import org.lab409.entity.CourseInfo;
import org.lab409.entity.ResultEntity;
import org.lab409.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CourseController
{
    @Autowired
    private CourseService courseService;

    @PostMapping(value = "/addCourse")
    public ResultEntity addNewCourse(CourseInfo courseInfo)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.addNewCourse(courseInfo));
        resultEntity.setData(courseInfo);
        resultEntity.setMessage(resultEntity.getState()==1?"新增课程成功！":"新增课程失败！");
        return resultEntity;
    }
    @GetMapping(value = "/getCourseByCode")
    public ResultEntity getCourseByCode(String courseCode)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCourseByCode(courseCode));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        return resultEntity;
    }
    @GetMapping(value = "/joinCourse")
    public ResultEntity joinCourse(Integer studentID,Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.joinCourse(studentID,courseID));
        resultEntity.setMessage(resultEntity.getState()==1?"选课成功！":"选课失败！");
        return resultEntity;
    }
    @GetMapping(value = "/getStuCourseList")
    public ResultEntity getStuCourseList(Integer studentID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getStuCourseList(studentID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        return resultEntity;
    }
}
