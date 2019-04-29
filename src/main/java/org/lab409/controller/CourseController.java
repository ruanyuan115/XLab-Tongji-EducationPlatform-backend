package org.lab409.controller;

import org.lab409.entity.*;
import org.lab409.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

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
        courseInfo.setCourseName(courseService.getCourseNameByNameID(Integer.parseInt(courseInfo.getCourseName())).getCourseName());
        resultEntity.setData(courseInfo);
        resultEntity.setMessage(resultEntity.getState()==1?"新增课程成功！":"新增课程失败！");
        return resultEntity;
    }
    @PostMapping(value = "/addClass")
    public ResultEntity addClass(CourseClass courseClass)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.addClass(courseClass));
        resultEntity.setData(courseClass);
        resultEntity.setMessage(resultEntity.getState()==1?"新增班级成功！":"该班级已经存在！");
        return resultEntity;
    }
    @GetMapping(value = "/getCourseByCode")
    public ResultEntity getCourseByCode(String courseCode)throws CloneNotSupportedException
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCourseByCode(courseCode));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"不存在该课程！");
        return resultEntity;
    }
    @GetMapping(value = "/joinCourse")
    public ResultEntity joinCourse(Integer studentID,Integer courseClassID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.joinCourse(studentID,courseClassID));
        resultEntity.setMessage(resultEntity.getState()==1?"选课成功！":"选课失败！");
        return resultEntity;
    }
    @GetMapping(value = "/getStuCourseList")
    public ResultEntity getStuCourseList(Integer studentID)throws CloneNotSupportedException
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
    @PostMapping(value = "/alterClassInfo")
    public ResultEntity alterClassInfo(CourseClass courseClass)
    {
        ResultEntity resultEntity=new ResultEntity();
        CourseClass temp=courseService.getClassInfoByID(courseClass.getId());
        if (temp!=null)
        {
            courseClass.setCreateTime(temp.getCreateTime());
            //courseInfo.setUpdateTime(temp.getUpdateTime());
            resultEntity.setState(courseService.alertClassInfo(courseClass));
            resultEntity.setMessage(resultEntity.getState()==1?"修改成功！":resultEntity.getState()==-1?"修改内容已经存在！":"修改失败！");
        }
        else
        {
            resultEntity.setState(0);
            resultEntity.setMessage("该班级不存在！");
        }
        return resultEntity;
    }
    @GetMapping(value = "/getCourseInfoByID")
    public ResultEntity getCourseInfoByID(Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();
        CourseInfo temp=courseService.getCourseInfoByID(courseID);
        if(temp!=null)
            temp.setCourseName(courseService.getCourseNameByNameID(Integer.parseInt(temp.getCourseName())).getCourseName());
        resultEntity.setData(temp);
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"不存在该课程！");
        return resultEntity;
    }
    @GetMapping(value = "/getClassInfoByID")
    public ResultEntity getClassInfoByID(Integer courseClassID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getClassInfoByID(courseClassID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"不存在该班级！");
        return resultEntity;
    }
    @GetMapping(value = "/deleteCourse")
    public ResultEntity deleteCourse(Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();

        courseService.deleteCourseNotice(courseID);                        //删除对应的课程公告

        CourseCatalog courseCatalog=new CourseCatalog();
        courseCatalog.setId(0);
        courseCatalog.setParentID(-1);
        courseService.deleteChapter(courseCatalog);                        //级联删除章节和习题

        ArrayList<CourseClass>arrayList=courseService.getClassesByCourseID(courseID);
        if (arrayList!=null)
            for(CourseClass i:arrayList)
                courseService.deleteClass(i.getId());                      //删除班级信息
        resultEntity.setState(courseService.deleteCourse(courseID));       //最后删除课程信息
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
        else
        {
            resultEntity.setData(courseService.addChapter(chapterNode));
            resultEntity.setState(resultEntity.getData()!=null?1:0);
        }
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
    @GetMapping(value = "/getCourseScoreAndComment")
    public ResultEntity getCourseScoreAndComment(Integer courseID,Integer studentID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCourseScoreAndComment(courseID,studentID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"该学生尚未作出评论！");
        return resultEntity;
    }
    @GetMapping(value = "/getCurrentProgress")
    public ResultEntity getCurrentProgress(Integer courseClassID,Integer studentID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCurrentProgress(courseClassID,studentID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"选课状态有误！");
        return resultEntity;
    }
    @GetMapping(value = "/alertCurrentProgress")
    public ResultEntity alertCurrentProgress(Integer courseClassID,Integer studentID,Integer chapterID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.alertCurrentProgress(courseClassID,studentID,chapterID));
        resultEntity.setMessage(resultEntity.getState()==1?"修改成功！":"无该选课记录！");
        return resultEntity;
    }
    @GetMapping(value = "/deleteChapter")
    public ResultEntity deleteChapter(Integer chapterID)
    {
        ResultEntity resultEntity=new ResultEntity();
        ChapterNode temp=courseService.getChapterByID(chapterID);
        if(temp!=null)
        {
            CourseCatalog courseCatalog=new CourseCatalog();
            courseCatalog.setChapterNode(temp);
            courseService.deleteChapter(courseCatalog);
            resultEntity.setState(courseService.getChapterByID(chapterID)==null?1:0);
        }
        else
            resultEntity.setState(0);
        resultEntity.setMessage(resultEntity.getState()==1?"删除成功！":"删除失败,该章节不存在！");
        return resultEntity;
    }
    @GetMapping(value = "/getClassesByCourseID")
    public ResultEntity getClassesByCourseID(Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getClassesByCourseID(courseID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        return resultEntity;
    }
    @GetMapping(value = "/deleteClass")
    public ResultEntity deleteClass(Integer courseClassID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.deleteClass(courseClassID));
        resultEntity.setMessage(resultEntity.getState()==1?"删除成功！":"该班级并不存在！");
        return resultEntity;
    }
    @GetMapping(value = "/getCoursesByTeacherID")
    public ResultEntity getCoursesByTeacherID(Integer teacherID)throws CloneNotSupportedException
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCoursesByTeacherID(teacherID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"无该老师的课程！");
        return resultEntity;
    }
    @GetMapping(value = "/getStudentsByClassID")
    public ResultEntity getStudentsByClassID(Integer courseClassID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getStudentsByClassID(courseClassID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        resultEntity.setMessage(resultEntity.getData()!=null?"":"尚无学生进入该班级！");
        return resultEntity;
    }
    @PostMapping(value = "/alertChapterExerciseTitle")
    public ResultEntity alertChapterExerciseTitle(Integer chapterID,String title)
    {
        ResultEntity resultEntity=new ResultEntity();
        ChapterNode temp=courseService.getChapterByID(chapterID);
        if(temp!=null)//如果有该章节
        {
            temp.setExerciseTitle(title);
            resultEntity.setData(courseService.addChapter(temp));
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
    @GetMapping(value = "/getAllCourses")
    public ResultEntity getAllCourses()throws CloneNotSupportedException
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getAllCourses());
        resultEntity.setState(1);
        return resultEntity;
    }
    @GetMapping(value = "/getAllCoursesRelation")
    public ResultEntity getAllCoursesRelation()
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getAllCoursesRelation());
        resultEntity.setState(1);
        return resultEntity;
    }
    @GetMapping(value = "/getChapterRelationByCourseID")
    public ResultEntity getChapterRelationByCourseID(Integer courseID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getChapterRelationByCourseID(courseID));
        resultEntity.setState(1);
        return resultEntity;
    }
    @PostMapping(value = "/addCourseName")
    public ResultEntity addCourseName(String courseName)
    {
        ResultEntity resultEntity=new ResultEntity();
        if (courseName!=null)
        {
            resultEntity.setData(courseService.addCourseName(courseName));
            resultEntity.setState(resultEntity.getData()!=null?1:0);
            resultEntity.setMessage(resultEntity.getState()==1?"添加课程成功！":"该课程已经存在！");
            if(resultEntity.getState()==1)
            {
                CourseName temp=(CourseName) resultEntity.getData();
                courseService.addCourseRelation(temp.getCourseNameID(),0);
            }
        }
        else
        {
            resultEntity.setState(-1);
            resultEntity.setMessage("课程名不能为空！");
        }
        return resultEntity;
    }
    @GetMapping(value = "/getCourseList")
    public ResultEntity getCourseList()
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCourseList());
        resultEntity.setState(1);
        return resultEntity;
    }
    @PostMapping(value = "/alertCourseName")
    public ResultEntity alertCourseName(Integer courseNameID,String courseName)
    {
        CourseName temp=new CourseName(courseNameID,courseName);
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.alertCourseName(temp));
        resultEntity.setMessage(resultEntity.getState()==1?"修改成功！":resultEntity.getState()==0?"该课程名已经存在！":"无该课程信息！");
        return resultEntity;
    }
    @GetMapping(value = "/getAllCoursesByNameID")
    public ResultEntity getAllCoursesByNameID(Integer courseNameID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getAllCoursesByNameID(courseNameID.toString()));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        return resultEntity;
    }
    @GetMapping(value = "/addCourseRelation")
    public ResultEntity addCourseRelation(Integer courseNameID,Integer preCourseNameID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.addCourseRelation(courseNameID,preCourseNameID));
        resultEntity.setMessage(resultEntity.getState()==1?"新增成功！":"该关系已经存在！");
        return resultEntity;
    }
    @GetMapping(value = "/deleteCourseRelation")
    public ResultEntity deleteCourseRelation(Integer courseNameID,Integer preCourseNameID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.deleteCourseRelation(courseNameID,preCourseNameID));
        resultEntity.setMessage(resultEntity.getState()==1?"删除成功！":"删除失败，该关系并不存在！");
        return resultEntity;
    }
    @GetMapping(value = "/addChapterRelation")
    public ResultEntity addChapterRelation(Integer chapterID,Integer preChapterID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.addChapterRelation(chapterID,preChapterID));
        resultEntity.setMessage(resultEntity.getState()==1?"新增成功！":"该关系已经存在！");
        return resultEntity;
    }
    @GetMapping(value = "/deleteChapterRelation")
    public ResultEntity deleteChapterRelation(Integer chapterID,Integer preChapterID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.deleteChapterRelation(chapterID,preChapterID));
        resultEntity.setMessage(resultEntity.getState()==1?"删除成功！":"删除失败，该关系并不存在！");
        return resultEntity;
    }
    @GetMapping(value = "/getStudentNumByTeacher")
    public ResultEntity getStudentNumByTeacher(Integer teacherID)throws CloneNotSupportedException
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getStudentNumByTeacher(teacherID));
        resultEntity.setState(1);
        return resultEntity;
    }
    @GetMapping(value = "/getStudentNumBySemester")
    public ResultEntity getStudentNumBySemester(String semester)throws CloneNotSupportedException
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getStudentNumBySemester(semester));
        resultEntity.setState(1);
        return resultEntity;
    }
    @GetMapping(value = "/getStudentNumByYear")
    public ResultEntity getStudentNumByYear(Integer year)throws CloneNotSupportedException
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getStudentNumByYear(year));
        resultEntity.setState(1);
        return resultEntity;
    }
    @GetMapping(value = "/getRateBySemesterAndYear")
    public ResultEntity getRateBySemesterAndYear(String courseNameID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getRateBySemesterAndYear(courseNameID));
        resultEntity.setState(1);
        return resultEntity;
    }
    @GetMapping(value = "/getClassesByNIDAndTID")
    public ResultEntity getAllClasses(String courseNameID,Integer teacherID)throws CloneNotSupportedException
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getClassesByNIDAndTID(courseNameID,teacherID));
        resultEntity.setState(1);
        return resultEntity;
    }
    @GetMapping(value = "/getTeacherInfoByNID")
    public ResultEntity getTeacherInfoByNID(String courseNameID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getTeacherListByNID(courseNameID));
        resultEntity.setState(1);
        return resultEntity;
    }
    @PostMapping(value = "/addStudentComment")
    public ResultEntity addStudentComment(Integer chapterID, Integer studentID, String comment, Integer rate)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.addStudentComment(chapterID,studentID,comment,rate));
        resultEntity.setMessage(resultEntity.getState()==1?"评价成功！":"评价失败！");
        return resultEntity;
    }
    @PostMapping(value = "/addClassComment")
    public ResultEntity addClassComment(Integer courseClassID, Integer studentID, String comment, Integer rate)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setState(courseService.addClassComment(courseClassID,studentID,comment,rate));
        resultEntity.setMessage(resultEntity.getState()==1?"评论成功！":"该学生未曾选过这门课！");
        return resultEntity;
    }
    @GetMapping(value="/getCourseScoreAndCommentByGender")
    public ResultEntity getCourseScoreAndCommentByGender(Integer courseID,Integer chapterID,Integer courseClassID)
    {
        ResultEntity resultEntity=new ResultEntity();
        resultEntity.setData(courseService.getCourseScoreAndCommentByGender(courseID,chapterID,courseClassID));
        resultEntity.setState(resultEntity.getData()!=null?1:0);
        return resultEntity;
    }
}
