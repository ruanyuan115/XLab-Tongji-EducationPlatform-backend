package org.lab409.service.implement;

import io.netty.channel.ChannelOption;
import org.lab409.dao.ChapterContentDao;
import org.lab409.dao.CourseInfoDao;
import org.lab409.dao.CourseNoticeDao;
import org.lab409.dao.TakesDao;
import org.lab409.entity.*;
import org.lab409.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

@Service(value = "courseService")
@Transactional
public class CourseServiceImp implements CourseService
{
    @Autowired
    private CourseInfoDao courseInfoDao;
    @Autowired
    private TakesDao takesDao;
    @Autowired
    private CourseNoticeDao courseNoticeDao;
    @Autowired
    private ChapterContentDao chapterContentDao;
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
    @Override
    public Integer addCourseNotice(CourseNotice courseNotice)
    {
        if(courseNotice!=null&&courseInfoDao.findByCourseID(courseNotice.getCourseID())!=null)//如果有该课程
            return courseNoticeDao.saveAndFlush(courseNotice).getId()!=null?1:0;
        else
            return -1;
    }

    @Override
    public CourseNotice getNoticeByCouID(Integer courseID)
    {
        return courseID>0?courseNoticeDao.findByCourseID(courseID):null;
    }

    @Override
    public CourseInfo getCourseInfoByID(Integer courseID)
    {
        return courseID>0?courseInfoDao.findByCourseID(courseID):null;
    }

    @Override
    public Integer deleteCourse(Integer courseID)
    {
        if(courseInfoDao.findByCourseID(courseID)!=null)
        {
            courseInfoDao.deleteById(courseID);
            return 1;
        }
        else
            return 0;
    }

    @Override
    public Integer deleteCourseNotice(Integer courseID)
    {
        if(courseNoticeDao.findByCourseID(courseID)!=null)
        {
            courseNoticeDao.deleteByCourseID(courseID);
            return 1;
        }
        else
            return 0;
    }

    @Override
    public ChapterNode addChapter(ChapterNode chapterNode)
    {
        if(chapterNode!=null)
        {
            ChapterNode temp=chapterContentDao.saveAndFlush(chapterNode);
            return temp.getId()!=null?temp:null;
        }
        else
            return null;
    }

    @Override
    public ChapterNode getChapterByID(Integer chapterID)
    {
        Optional<ChapterNode> temp=chapterContentDao.findById(chapterID);
        return temp.isPresent()?temp.get():null;
    }

    @Override
    public ArrayList<CourseCatalog> getCourseCatalog(Integer courseID)
    {
        ArrayList<ChapterNode>chapterNodes=chapterContentDao.findByCourseID(courseID);
        if(chapterNodes!=null&&chapterNodes.size()>0)
        {
            CourseCatalog bookCatalog=new CourseCatalog();
            ChapterNode book=new ChapterNode();
            book.setId(0);
            bookCatalog.setChapterNode(book);

            makeCatalog(bookCatalog,chapterNodes);
            return bookCatalog.getSubCatalog();
        }
        else
            return null;
    }
    private void getSubNodes(CourseCatalog courseCatalog,ArrayList<ChapterNode>chapterNodes)
    {
        Integer parentID=courseCatalog.getChapterNode().getId();
        Integer siblingID=0;
        Iterator<ChapterNode> it=chapterNodes.iterator();
        while (it.hasNext())//如果还有没被加入的节点
        {
            ChapterNode temp=it.next();
            if(temp.getParentID().equals(parentID)&&temp.getSiblingID().equals(siblingID))//如果该节点符合要求
            {
                CourseCatalog subCatalog=new CourseCatalog();
                subCatalog.setChapterNode(temp);

                courseCatalog.getSubCatalog().add(subCatalog);

                chapterNodes.remove(temp);        //将该节点从数组中移除
                siblingID=temp.getId();

                it=chapterNodes.iterator();       //再次遍历获取兄弟节点
            }
        }
    }
    private void makeCatalog(CourseCatalog courseCatalog,ArrayList<ChapterNode>chapterNodes)
    {
        getSubNodes(courseCatalog,chapterNodes);    //先获取该节点的子节点 再递归操作获取子子节点
        Iterator<CourseCatalog> it=courseCatalog.getSubCatalog().iterator();
        while(it.hasNext()&&!chapterNodes.isEmpty())
        {
            makeCatalog(it.next(),chapterNodes);
        }
    }
}