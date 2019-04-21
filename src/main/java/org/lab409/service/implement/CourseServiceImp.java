package org.lab409.service.implement;

import org.lab409.dao.*;
import org.lab409.entity.*;
import org.lab409.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.lang.reflect.Array;
import java.util.*;

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
    @Autowired
    private StudentChapterDao studentChapterDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private CourseClassDao courseClassDao;
    @Autowired
    private CourseRelationDao courseRelationDao;
    @Autowired
    private CourseNameDao courseNameDao;
    @Autowired
    private ChapterRelationDao chapterRelationDao;
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
    public Integer addClass(CourseClass courseClass)
    {
        if (courseClass!=null)
        {
            return courseClassDao.saveAndFlush(courseClass).getId()!=null?1:0;
        }
        else
            return 0;
    }

    @Override
    public ArrayList<CourseAndClass> getStuCourseList(Integer studentID)
    {
        if(studentID>0)
        {
            ArrayList<CourseAndClass> courseList=new ArrayList<>();
            List<Takes> takesList=takesDao.findByStudentID(studentID);
            if(takesList!=null)
            {
                for(Takes i:takesList)
                {
                    CourseClass courseClass=courseClassDao.findById(i.getCourseClassID()).get();
                    CourseInfo temp=courseInfoDao.findByCourseID(courseClass.getCourseID());
                    if(temp!=null)
                        courseList.add(new CourseAndClass(temp,courseClass));
                }
            }
            return courseList;
        }
        return null;
    }

    @Override
    public CourseAndClass getCourseByCode(String courseCode)
    {
        CourseClass temp=courseClassDao.findByClassCode(courseCode);

        return temp!=null?new CourseAndClass(courseInfoDao.findByCourseID(temp.getCourseID()),temp):null;
    }

    @Override
    public Integer joinCourse(Integer studentID, Integer courseClassID)
    {
        Takes takes=new Takes();
        takes.setCourseClassID(courseClassID);
        takes.setStudentID(studentID);
        if(takesDao.findByStudentIDAndCourseClassID(studentID,courseClassID)==null)//该学生之前没选过这门课,且该课程存在
            return (courseClassDao.findById(courseClassID).isPresent()&&takesDao.saveAndFlush(takes).getId()!=null)?1:0;
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
    public CourseClass getClassInfoByID(Integer courseClassID)
    {
        Optional<CourseClass>temp=courseClassDao.findById(courseClassID);
        return courseClassID>0?(temp.isPresent()?temp.get():null):null;
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
        Integer parentID=courseCatalog.getId();
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

    @Override
    public ArrayList<StudentChapter> getCourseScoreAndComment(Integer courseID, Integer studentID)
    {
        ArrayList<ChapterNode>chapterNodes=chapterContentDao.findByCourseIDAndParentID(courseID,0);
        if(chapterNodes!=null&&chapterNodes.size()>0&&userDao.findById(studentID).isPresent())
        {
            CourseCatalog bookCatalog = new CourseCatalog();
            ChapterNode book = new ChapterNode();
            book.setId(0);
            bookCatalog.setChapterNode(book);

            getSubNodes(bookCatalog,chapterNodes);

            ArrayList<StudentChapter>arrayList=new ArrayList<>();
            for(CourseCatalog i:bookCatalog.getSubCatalog())
            {
                StudentChapter temp=studentChapterDao.findByChapterIDAndStudentID(i.getId(),studentID);
                if (temp!=null)
                    arrayList.add(temp);
            }
            return arrayList.size()>0?arrayList:null;
        }
        else
            return null;
    }

    @Override
    public Takes getCurrentProgress(Integer courseClassID, Integer studentID)
    {
        return takesDao.findByStudentIDAndCourseClassID(studentID,courseClassID);
    }

    @Override
    public Integer alertCurrentProgress(Integer courseClassID, Integer studentID, Integer chapterID)
    {
        Takes t=takesDao.findByStudentIDAndCourseClassID(studentID,courseClassID);
        if(t!=null)
        {
            t.setCurrentProgress(chapterID);
            takesDao.saveAndFlush(t);
            return 1;
        }
        else
            return 0;
    }

    @Override
    public void deleteChapter(CourseCatalog courseCatalog)
    {
        ArrayList<ChapterNode>chapterNodes=chapterContentDao.findByCourseID(courseCatalog.getCourseID());
        getSubNodes(courseCatalog,chapterNodes);
        Iterator<CourseCatalog>it=courseCatalog.getSubCatalog().iterator();
        while (it.hasNext())
        {
            deleteChapter(it.next());
        }
        if(courseCatalog.getId()>0)
            chapterContentDao.deleteById(courseCatalog.getId());
        if(courseCatalog.getParentID()==0)//为章节点 需要删除习题
        {
            //删除习题
        }
    }

    @Override
    public ArrayList<CourseClass> getClassesByCourseID(Integer courseID)
    {
        if(courseInfoDao.findByCourseID(courseID)!=null)
        {
            return courseClassDao.findByCourseID(courseID);
        }
        else
            return null;
    }

    @Override
    public Integer deleteClass(Integer courseClassID)
    {
        if(courseClassDao.findById(courseClassID).isPresent())
        {
            courseClassDao.deleteById(courseClassID);
            return 1;
        }
        else
            return 0;
    }

    @Override
    public ArrayList<CourseAndClass> getCoursesByTeacherID(Integer teacherID)
    {
        ArrayList<CourseInfo>courseInfos=courseInfoDao.findByTeacherID(teacherID);
        if (courseInfos.size()>0)
        {
            ArrayList<CourseAndClass>courseAndClasses=new ArrayList<>();
            for (CourseInfo i:courseInfos)
            {
                ArrayList<CourseClass>classes=courseClassDao.findByCourseID(i.getCourseID());
                for (CourseClass j:classes)
                {
                    courseAndClasses.add(new CourseAndClass(i,j));
                }
            }
            return courseAndClasses;
        }
        else
        {
            return null;
        }
    }

    @Override
    public ArrayList<UserInfo> getStudentsByClassID(Integer courseClassId)
    {
        ArrayList<Takes>takes=takesDao.findByCourseClassID(courseClassId);
        if (takes.size()>0)
        {
            ArrayList<UserInfo>userInfos=new ArrayList<>();
            for (Takes i:takes)
            {
                UserInfo userInfo=new UserInfo(userDao.findById(i.getStudentID()).get());
                userInfos.add(userInfo);
            }
            return userInfos;
        }
        else
            return null;
    }

    @Override
    public List<CourseInfo> getAllCourses()
    {
        return courseInfoDao.findAll();
    }

    @Override
    public List<CourseRelationEntity> getAllCoursesRelation()
    {
        List<CourseRelationEntity>list=new ArrayList<>();
        List<CourseRelation> courseRelations=courseRelationDao.findAll();
        Map<CourseName,ArrayList<CourseName>> courseMap=new HashMap<>();
        for(CourseRelation i:courseRelations)
        {
            CourseName temp=getCourseNameByNameID(i.getCourseNameID());
            courseMap.computeIfAbsent(temp,k->new ArrayList<>());
            courseMap.get(temp).add(getCourseNameByNameID(i.getPreCourseNameID()));
        }
        Set<CourseName>courseNames=courseMap.keySet();
        for(CourseName i:courseNames)
            list.add(new CourseRelationEntity(i,courseMap.get(i)));
        return list;
    }

    @Override
    public List<ChapterRelationEntity> getChapterRelationByCourseID(Integer courseID)
    {
        List<ChapterRelationEntity>list=new ArrayList<>();
        List<ChapterRelation> chapterRelations=new ArrayList<>();
        List<ChapterNode>courseChapters=chapterContentDao.findByCourseID(courseID);
        for(ChapterNode i:courseChapters)
        {
            chapterRelations.addAll(chapterRelationDao.findByChapterID(i.getId()));
        }
        Map<Integer,ArrayList<ChapterNode>> courseMap=new HashMap<>();
        for(ChapterRelation i:chapterRelations)
        {
            courseMap.computeIfAbsent(i.getChapterID(),k->new ArrayList<>());
            courseMap.get(i.getChapterID()).add(getChapterByID(i.getPreChapterID()));
        }
        Set<Integer>chapterIDs=courseMap.keySet();
        for(Integer i:chapterIDs)
            list.add(new ChapterRelationEntity(chapterContentDao.findById(i).get(),courseMap.get(i)));
        return list;
    }

    @Override
    public CourseName getCourseNameByNameID(Integer courseNameID)
    {
        Optional<CourseName> temp=courseNameDao.findById(courseNameID);
        return temp.isPresent()?temp.get():null;
    }

    @Override
    public CourseName addCourseName(String courseName)
    {
        if (courseNameDao.getByCourseName(courseName)==null)//检查是否名称冲突
        {
            CourseName temp=new CourseName();
            temp.setCourseName(courseName);
            return courseNameDao.saveAndFlush(temp);
        }
        else
            return null;
    }

    @Override
    public List<CourseName> getCourseList()
    {
        return courseNameDao.findAll();
    }

    @Override
    public Integer alertCourseName(CourseName courseName)
    {
        Optional<CourseName> temp=courseNameDao.findById(courseName.getCourseNameID());
        if (temp.isPresent())
        {
            if (courseNameDao.getByCourseName(courseName.getCourseName())==null)//检查是否名称冲突
            {
                temp.get().setCourseName(courseName.getCourseName());
                courseNameDao.saveAndFlush(temp.get());
                return 1;
            }
            else
                return 0;
        }
        else
            return -1;
    }

    @Override
    public ArrayList<CourseAndClassList> getAllCoursesByNameID(String nameID)
    {
        ArrayList<CourseAndClassList>courseAndClasses=new ArrayList<>();
        ArrayList<CourseInfo>courseInfos=courseInfoDao.findByCourseName(nameID);
        for(CourseInfo i:courseInfos)
        {
            ArrayList<CourseClass>classes=courseClassDao.findByCourseID(i.getCourseID());
            courseAndClasses.add(new CourseAndClassList(i,classes));
        }
        return courseAndClasses;
    }

    @Override
    public Integer addCourseRelation(Integer courseNameID, Integer preCourseNameID)
    {
        if(courseRelationDao.findByCourseNameIDAndPreCourseNameID(courseNameID,preCourseNameID)==null)//如果不存在该关系
        {
            CourseRelation courseRelation=new CourseRelation();
            courseRelation.setCourseNameID(courseNameID);
            courseRelation.setPreCourseNameID(preCourseNameID);
            courseRelationDao.saveAndFlush(courseRelation);
            return 1;
        }
        else
            return 0;

    }

    @Override
    public Integer addChapterRelation(Integer chapterID, Integer preChapterID)
    {
        if(chapterRelationDao.findByChapterIDAndPreChapterID(chapterID,preChapterID)==null)//如果不存在该关系
        {
            ChapterRelation chapterRelation=new ChapterRelation();
            chapterRelation.setChapterID(chapterID);
            chapterRelation.setPreChapterID(preChapterID);
            chapterRelationDao.saveAndFlush(chapterRelation);
            return 1;
        }
        else
            return 0;
    }

    @Override
    public Integer deleteChapterRelation(Integer chapterID, Integer preChapterID)
    {
        ChapterRelation temp=chapterRelationDao.findByChapterIDAndPreChapterID(chapterID,preChapterID);
        if(temp!=null)//检查关系是否已经存在
        {
            chapterRelationDao.delete(temp);
            return 1;
        }
        else
            return 0;
    }

    @Override
    public Integer deleteCourseRelation(Integer courseNameID, Integer preCourseNameID)
    {
        CourseRelation temp=courseRelationDao.findByCourseNameIDAndPreCourseNameID(courseNameID,preCourseNameID);
        if(temp!=null)//检查关系是否已经存在
        {
            courseRelationDao.delete(temp);
            return 1;
        }
        else
            return 0;
    }

    @Override
    public StudyInfo getStudyInfo(Integer studentID, Integer courseClassID)
    {
         return null;
    }
}
