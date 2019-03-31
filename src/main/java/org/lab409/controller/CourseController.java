package org.lab409.controller;

import org.lab409.entity.ChapterNode;
import org.lab409.entity.CourseInfo;
import org.lab409.entity.CourseNotice;
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
        resultEntity.setMessage(resultEntity.getData()!=null?"":"不存在该课程！");
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
    @PostMapping(value = "/addCourseNotice")
    public ResultEntity addCourseNotice(Integer courseID,String courseNotice)
    {
        CourseNotice couNotice=courseService.getNoticeByCouID(courseID);
        if(couNotice==null)//未曾有过课程介绍
        {
            couNotice=new CourseNotice();
            couNotice.setCourseID(courseID);
        }
        couNotice.setCourseNotice(courseNotice);

        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.addCourseNotice(couNotice));
        resultEntity.setMessage(resultEntity.getState()==1?"公告发布成功！":"公告发布失败！");
        return resultEntity;
    }
    @GetMapping(value = "/getNoticeByCouID")
    public ResultEntity getNoticeByCouID(Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getNoticeByCouID(courseID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        return resultEntity;
    }
    @PostMapping(value = "/alterCourseInfo")
    public ResultEntity alterCourseInfo(CourseInfo courseInfo)
    {
        ResultEntity resultEntity=new ResultEntity();
        CourseInfo temp=courseService.getCourseInfoByID(courseInfo.getCourseID());
        if (temp!=null)
        {
            courseInfo.setCreateTime(temp.getCreateTime());
            //courseInfo.setUpdateTime(temp.getUpdateTime());
            resultEntity.setState(courseService.addNewCourse(courseInfo));
            resultEntity.setMessage(resultEntity.getState()==1?"修改成功！":"修改失败！");
        }
        else
        {
            resultEntity.setState(0);
            resultEntity.setMessage("该课程不存在！");
        }
        return resultEntity;
    }
    @GetMapping(value = "/getCourseInfoByID")
    public ResultEntity getCourseInfoByID(Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCourseInfoByID(courseID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"不存在该课程！");
        return resultEntity;
    }
    @GetMapping(value = "/deleteCourse")
    public ResultEntity deleteCourse(Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.deleteCourse(courseID));
        courseService.deleteCourseNotice(courseID);                        //删除对应的课程公告
        resultEntity.setMessage(resultEntity.getState()==1?"删除成功！":"该课程不存在，删除失败！");
        return resultEntity;
    }
    @PostMapping(value="/addChapter")
    public ResultEntity addChapter(ChapterNode chapterNode)
    {
        ResultEntity resultEntity=new ResultEntity();
        if(courseService.getCourseInfoByID(chapterNode.getCourseID())==null)
        {
            resultEntity.setState(0);
            resultEntity.setMessage("不存在该课程！");
        }
        resultEntity.setData(courseService.addChapter(chapterNode));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        return resultEntity;
    }
    @PostMapping(value = "/alertChapter")
    public ResultEntity alertChapter(ChapterNode chapterNode)
    {
        ResultEntity resultEntity=new ResultEntity();
        ChapterNode temp=courseService.getChapterByID(chapterNode.getId());
        if(temp!=null)//如果有该章节
        {
            chapterNode.setCreateTime(temp.getCreateTime());
            resultEntity.setData(courseService.addChapter(chapterNode));
            resultEntity.setState(1);
            resultEntity.setMessage("修改成功！");
        }
        else
        {
            resultEntity.setState(0);
            resultEntity.setMessage("该章节不存在！");
        }
        return resultEntity;
    }
    @GetMapping(value = "/getChapterByID")
    public ResultEntity getChapterByID(Integer chapterID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getChapterByID(chapterID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"不存在该章节！");
        return resultEntity;
    }
    @GetMapping(value = "/getCourseCatalog")
    public ResultEntity getCourseCatalog(Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCourseCatalog(courseID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"该课程不存在目录！");
        return resultEntity;
    }
}
