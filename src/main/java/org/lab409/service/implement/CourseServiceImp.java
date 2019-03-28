package org.lab409.service.implement;

import org.lab409.dao.CourseInfoDao;
import org.lab409.dao.TakesDao;
import org.lab409.entity.CourseInfo;
import org.lab409.entity.Takes;
import org.lab409.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service(value = "courseService")
public class CourseServiceImp implements CourseService
{
    @Autowired
    private CourseInfoDao courseInfoDao;
    @Autowired
    private TakesDao takesDao;
    @Override
    public Integer addNewCourse(CourseInfo courseInfo)
    {
        if(courseInfo!=null)
        {
            return courseInfoDao.saveAndFlush(courseInfo).getCourseID()!=null?1:0;
        }
        else
            return 0;
    }

    @Override
    public ArrayList<CourseInfo> getStuCourseList(Integer studentID)
    {
        if(studentID>0)
        {
            ArrayList<CourseInfo> courseList=new ArrayList<>();
            List<Takes> takesList=takesDao.findByStudentID(studentID);
            if(takesList!=null)
            {
                for(Takes i:takesList)
                {
                    CourseInfo temp=courseInfoDao.findByCourseID(i.getCourseID());
                    if(temp!=null)
                        courseList.add(temp);
                }
            }
            return courseList;
        }
        return null;
    }

    @Override
    public CourseInfo getCourseByCode(String courseCode)
    {
        return courseCode!=null?courseInfoDao.findByCourseCode(courseCode):null;
    }

    @Override
    public Integer joinCourse(Integer studentID, Integer courseID)
    {
        Takes takes=new Takes();
        takes.setCourseID(courseID);
        takes.setStudentID(studentID);
        if(takesDao.findByStudentIDAndCourseID(studentID,courseID)==null)//该学生之前没选过这门课,且该课程存在
            return courseInfoDao.findByCourseID(courseID)!=null&&takesDao.saveAndFlush(takes).getId()!=null?1:0;
        else
            return -1;
    }
}
