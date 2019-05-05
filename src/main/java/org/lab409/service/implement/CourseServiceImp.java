package org.lab409.service.implement;

import org.apache.bcel.generic.FLOAD;
import org.apache.commons.lang.math.NumberUtils;
import org.lab409.dao.*;
import org.lab409.entity.*;
import org.lab409.model.security.User;
import org.lab409.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
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
        if (courseClass!=null&&courseClassDao.findByCourseIDAndClassNum(courseClass.getCourseID(),courseClass.getClassNum())==null)
        {
            courseClass.setClassCode(""+new Date().hashCode());
            return courseClassDao.saveAndFlush(courseClass).getId()!=null?1:0;
        }
        else
            return 0;
    }

    @Override
    public Integer alertClassInfo(CourseClass courseClass)
    {
        if (courseClass!=null)
        {
            CourseClass temp=courseClassDao.findByCourseIDAndClassNum(courseClass.getCourseID(),courseClass.getClassNum());
            if(temp==null||temp.getId().equals(courseClass.getId()))//要么是更改第几班 要么更改当前作业进度
                return courseClassDao.saveAndFlush(courseClass).getId()!=null?1:0;
            else
                return -1;
        }
        else
            return 0;
    }

    @Override
    public ArrayList<CourseAndClass> getStuCourseList(Integer studentID)throws CloneNotSupportedException
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
    public CourseAndClass getCourseByCode(String courseCode)throws CloneNotSupportedException
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
    public ArrayList<StudentChapterEntity> getCourseScoreAndComment(Integer courseID, Integer studentID)
    {
        ArrayList<ChapterNode>chapterNodes=chapterContentDao.findByCourseIDAndParentID(courseID,0);
        Optional<UserInfo> userTemp=userDao.findById(studentID);
        if(chapterNodes!=null&&chapterNodes.size()>0&&userTemp.isPresent())
        {
            CourseCatalog bookCatalog = new CourseCatalog();
            ChapterNode book = new ChapterNode();
            book.setId(0);
            bookCatalog.setChapterNode(book);

            getSubNodes(bookCatalog,chapterNodes);

            ArrayList<StudentChapterEntity>arrayList=new ArrayList<>();
            for(CourseCatalog i:bookCatalog.getSubCatalog())
            {
                StudentChapter temp=studentChapterDao.findByChapterIDAndStudentID(i.getId(),studentID);
                if (temp!=null)
                {
                    StudentChapterEntity tempEntity=new StudentChapterEntity(temp,getChapterByID(temp.getChapterID()).getContentName());
                    arrayList.add(tempEntity);
                }
            }
            return arrayList.size()>0?arrayList:null;
        }
        else
            return null;
    }

    @Override
    public Map getCourseClassAvgScore(Integer courseID)
    {
        ArrayList<CourseClass>courseClasses=getClassesByCourseID(courseID);
        ArrayList<ChapterNode>chapterNodes=chapterContentDao.findByCourseIDAndParentID(courseID,0);

        if(courseClasses!=null&&courseClasses.size()>0)
        {
            int courseBoyNum=0;
            int courseGirlNum=0;
            float courseBoyScoreSum1=0;
            int courseBoyScoreNum1=0;
            float courseBoyScoreSum2=0;
            int courseBoyScoreNum2=0;
            float courseGirlScoreSum1=0;
            int courseGirlScoreNum1=0;
            float courseGirlScoreSum2=0;
            int courseGirlScoreNum2=0;
            float courseBoyScoreSum=0;
            int courseBoyScoreNum=0;
            float courseGirlScoreSum=0;
            int courseGirlScoreNum=0;
            float courseBoyRateSum=0;
            int courseBoyRateNum=0;
            float courseGirlRateSum=0;
            int courseGirlRateNum=0;
            ArrayList<Integer>courseBoyScore1=new ArrayList<>(Arrays.asList(0,0,0,0,0));
            ArrayList<Integer>courseGirlScore1=new ArrayList<>(Arrays.asList(0,0,0,0,0));
            ArrayList<Integer>courseBoyScore2=new ArrayList<>(Arrays.asList(0,0,0,0,0));
            ArrayList<Integer>courseGirlScore2=new ArrayList<>(Arrays.asList(0,0,0,0,0));
            ArrayList<Integer>courseBoyScoreAvgDis=new ArrayList<>(Arrays.asList(0,0,0,0,0));
            ArrayList<Integer>courseGirlScoreAvgDis=new ArrayList<>(Arrays.asList(0,0,0,0,0));

            ArrayList<Integer>courseBoyRateDis=new ArrayList<>(Arrays.asList(0,0,0,0,0));
            ArrayList<Integer>courseGirlRateDis=new ArrayList<>(Arrays.asList(0,0,0,0,0));

            ArrayList<Map>resultMap=new ArrayList<>();

            for(CourseClass i:courseClasses)
            {
                int boyNum=0;
                int girlNum=0;
                float boyScoreSum1=0;      //男生各个章节课前成绩求和
                int boyScoreNum1=0;
                float boyScoreSum2=0;      //男生各个章节课后成绩求和
                int boyScoreNum2=0;
                float girlScoreSum1=0;      //女生各个章节课前成绩求和
                int girlScoreNum1=0;
                float girlScoreSum2=0;      //女生各个章节课后成绩求和
                int girlScoreNum2=0;
                float boyScoreSum=0;       //男生各个章节课前课后平均成绩求和
                int boyScoreNum=0;
                float girlScoreSum=0;       //女生各个章节课前课后平均成绩求和
                int girlScoreNum=0;
                float boyRateSum=0;        //男生各个章节评分求和
                int boyRateNum=0;
                float girlRateSum=0;        //女生各个章节评分求和
                int girlRateNum=0;
                ArrayList<Integer>boyScore1=new ArrayList<>(Arrays.asList(0,0,0,0,0));
                ArrayList<Integer>girlScore1=new ArrayList<>(Arrays.asList(0,0,0,0,0));
                ArrayList<Integer>boyScore2=new ArrayList<>(Arrays.asList(0,0,0,0,0));
                ArrayList<Integer>girlScore2=new ArrayList<>(Arrays.asList(0,0,0,0,0));
                ArrayList<Integer>boyScoreAvgDis=new ArrayList<>(Arrays.asList(0,0,0,0,0));
                ArrayList<Integer>girlScoreAvgDis=new ArrayList<>(Arrays.asList(0,0,0,0,0));

                ArrayList<Integer>boyRateDis=new ArrayList<>(Arrays.asList(0,0,0,0,0));
                ArrayList<Integer>girlRateDis=new ArrayList<>(Arrays.asList(0,0,0,0,0));
                ArrayList<UserInfo> students=getStudentsByClassID(i.getId());
                if(students!=null)
                for(UserInfo u:students)
                {
                    float studentScoreSum1=0;
                    int studentScoreNum1=0;
                    float studentScoreSum2=0;
                    int studentScoreNum2=0;
                    float studentScoreSum=0;
                    int studentScoreNum=0;
                    float studentRateSum=0;
                    int studentRateNum=0;
                    ArrayList<StudentChapter>temp=new ArrayList<>();
                    for(ChapterNode c:chapterNodes)
                    {
                        StudentChapter t=studentChapterDao.findByChapterIDAndStudentID(c.getId(),u.getUserID());
                        if (t!=null)
                            temp.add(t);
                    }
                    for(StudentChapter s:temp)
                    {
                        if(s.getTotalScore_1()!=null)
                        {
                            studentScoreSum1 += s.getTotalScore_1();
                            studentScoreNum1+=1;
                        }
                        if(s.getTotalScore_2()!=null)
                        {
                            studentScoreSum2+=s.getTotalScore_2();
                            studentScoreNum2+=1;
                        }
                        if (s.getRate()!=null)
                        {
                            studentRateSum+=s.getRate();
                            studentRateNum+=1;
                        }
                        if(s.getTotalScore_1()!=null&&s.getTotalScore_2()!=null)
                        {
                            studentScoreSum+=(s.getTotalScore_1()+s.getTotalScore_2())/2;
                            studentScoreNum+=1;
                        }
                    }
                    int indexScore1=(int)(studentScoreSum1/studentScoreNum1/10<6?0:studentScoreSum1/studentScoreNum1==100?4:studentScoreSum1/studentScoreNum1/10-5);
                    int indexScore2=(int)(studentScoreSum2/studentScoreNum2/10<6?0:studentScoreSum2/studentScoreNum2==100?4:studentScoreSum2/studentScoreNum2/10-5);
                    int indexScore=(int)(studentScoreSum/studentScoreNum/10<6?0:studentScoreSum/studentScoreNum==100?4:studentScoreSum/studentScoreNum/10-5);
                    int indexRate=(int)(studentRateSum/studentRateNum==5?4:studentRateSum/studentRateNum);
                    if(userDao.findByMail(u.getMail()).getGender().equals("男"))
                    {
                        boyNum+=1;
                        courseBoyNum+=1;
                        if(studentScoreSum1!=0)
                        {
                            boyScoreSum1+=studentScoreSum1/studentScoreNum1;
                            boyScoreNum1+=1;
                            courseBoyScoreSum1+=studentScoreSum1/studentScoreNum1;
                            courseBoyScoreNum1+=1;
                        }
                        if(studentScoreSum2!=0)
                        {
                            boyScoreSum2+=studentScoreSum2/studentScoreNum2;
                            boyScoreNum2+=1;
                            courseBoyScoreSum2+=studentScoreSum2/studentScoreNum2;
                            courseBoyScoreNum2+=1;
                        }
                        if (studentScoreSum!=0)
                        {
                            boyScoreSum+=studentScoreSum/studentScoreNum;
                            boyScoreNum+=1;
                            courseBoyScoreSum+=studentScoreSum/studentScoreNum;
                            courseBoyScoreNum+=1;
                        }
                        if (studentRateSum!=0)
                        {
                            boyRateSum+=studentRateSum/studentRateNum;
                            boyRateNum+=1;
                            courseBoyRateSum+=studentRateSum/studentRateNum;
                            courseBoyRateNum+=1;
                        }
                        boyScore1.set(indexScore1,boyScore1.get(indexScore1)+1);
                        boyScore2.set(indexScore2,boyScore2.get(indexScore2)+1);
                        boyScoreAvgDis.set(indexScore,boyScoreAvgDis.get(indexScore)+1);
                        boyRateDis.set(indexRate,boyRateDis.get(indexRate)+1);

                        courseBoyScore1.set(indexScore1,courseBoyScore1.get(indexScore1)+1);
                        courseBoyScore2.set(indexScore2,courseBoyScore2.get(indexScore2)+1);
                        courseBoyScoreAvgDis.set(indexScore,courseBoyScoreAvgDis.get(indexScore)+1);
                        courseBoyRateDis.set(indexRate,courseBoyRateDis.get(indexRate)+1);
                    }
                    else
                    {
                        courseGirlNum+=1;
                        girlNum+=1;
                        if(studentScoreSum1!=0)
                        {
                            girlScoreSum1+=studentScoreSum1/studentScoreNum1;
                            girlScoreNum1+=1;
                            courseGirlScoreSum1+=studentScoreSum1/studentScoreNum1;
                            courseGirlScoreNum1+=1;
                        }
                        if(studentScoreSum2!=0)
                        {
                            girlScoreSum2+=studentScoreSum2/studentScoreNum2;
                            girlScoreNum2+=1;
                            courseGirlScoreSum2+=studentScoreSum2/studentScoreNum2;
                            courseGirlScoreNum2+=1;
                        }
                        if (studentScoreSum!=0)
                        {
                            girlScoreSum+=studentScoreSum/studentScoreNum;
                            girlScoreNum+=1;
                            courseGirlScoreSum+=studentScoreSum/studentScoreNum;
                            courseGirlScoreNum+=1;
                        }
                        if (studentRateSum!=0)
                        {
                            girlRateSum+=studentRateSum/studentRateNum;
                            girlRateNum+=1;
                            courseGirlRateSum+=studentRateSum/studentRateNum;
                            courseGirlRateNum+=1;
                        }
                        girlScore1.set(indexScore1,girlScore1.get(indexScore1)+1);
                        girlScore2.set(indexScore2,girlScore2.get(indexScore2)+1);
                        girlScoreAvgDis.set(indexScore,girlScoreAvgDis.get(indexScore)+1);
                        girlRateDis.set(indexRate,girlRateDis.get(indexRate)+1);

                        courseGirlScore1.set(indexScore1,courseGirlScore1.get(indexScore1)+1);
                        courseGirlScore2.set(indexScore2,courseGirlScore2.get(indexScore2)+1);
                        courseGirlScoreAvgDis.set(indexScore,courseGirlScoreAvgDis.get(indexScore)+1);
                        courseGirlRateDis.set(indexRate,courseGirlRateDis.get(indexRate)+1);
                    }
                }
                Map<String,Object> classMap=new HashMap<>();


                classMap.put("classNum",i.getId());
                classMap.put("boyNum",boyNum);
                classMap.put("girlNum",girlNum);
                classMap.put("boyAvgScore1",boyScoreSum1==0?0:boyScoreSum1/boyScoreNum1);
                classMap.put("boyAvgScore2",boyScoreSum2==0?0:boyScoreSum2/boyScoreNum2);
                classMap.put("boyAvgScore",boyScoreSum==0?0:boyScoreSum/boyScoreNum);
                classMap.put("girlAvgScore1",girlScoreSum1==0?0:girlScoreSum1/girlScoreNum1);
                classMap.put("girlAvgScore2",girlScoreSum2==0?0:girlScoreSum2/girlScoreNum2);
                classMap.put("girlAgeScore",girlScoreSum==0?0:girlScoreSum/girlScoreNum);
                classMap.put("boyAvgRate",boyRateSum==0?0:boyRateSum/boyRateNum);
                classMap.put("girlAvgRate",girlRateSum==0?0:girlRateSum/girlRateNum);
                classMap.put("boyScoreDis1",boyScore1);
                classMap.put("boyScoreDis2",boyScore2);
                classMap.put("boyScoreDis",boyScoreAvgDis);
                classMap.put("girlScoreDis1",girlScore1);
                classMap.put("girlScoreDis2",girlScore2);
                classMap.put("girlScoreDis",girlScoreAvgDis);

                resultMap.add(classMap);
            }
            Map<String,Object>infoMap=new HashMap<>();
            infoMap.put("courseBoyNum",courseBoyNum);
            infoMap.put("courseGirlNum",courseGirlNum);
            infoMap.put("courseBoyAvgScore1",courseBoyScoreSum1==0?0:courseBoyScoreSum1/courseBoyScoreNum1);
            infoMap.put("courseBoyAvgScore2",courseBoyScoreSum2==0?0:courseBoyScoreSum2/courseBoyScoreNum2);
            infoMap.put("courseBoyAvgScore",courseBoyScoreSum==0?null:courseBoyScoreSum/courseBoyScoreNum);
            infoMap.put("courseGirlAvgScore1",courseGirlScoreSum1==0?0:courseGirlScoreSum1/courseGirlScoreNum1);
            infoMap.put("courseGirlAvgScore2",courseGirlScoreSum2==0?0:courseGirlScoreSum2/courseGirlScoreNum2);
            infoMap.put("courseGirlAgeScore",courseGirlScoreSum==0?null:courseGirlScoreSum/courseGirlScoreNum);
            infoMap.put("courseBoyAvgRate",courseBoyRateSum==0?null:courseBoyRateSum/courseBoyRateNum);
            infoMap.put("courseGirlAvgRate",courseGirlRateSum==0?null:courseGirlRateSum/courseGirlRateNum);
            infoMap.put("courseBoyScoreDis1",courseBoyScore1);
            infoMap.put("courseBoyScoreDis2",courseBoyScore2);
            infoMap.put("courseBoyScoreDis",courseBoyScoreAvgDis);
            infoMap.put("courseGirlScoreDis1",courseGirlScore1);
            infoMap.put("courseGirlScoreDis2",courseGirlScore2);
            infoMap.put("courseGirlScoreDis",courseGirlScoreAvgDis);
            infoMap.put("classInfo",resultMap);
            return infoMap;
        }
        else
            return null;
    }

    @Override
    public ArrayList<Map> getCourseScoreAndCommentByGender(Integer chapterID,Integer getDetail,Integer courseClassID)
    {
        //获取章节信息后 获取班级信息 然后获取学生在该章的信息(studentChapter) 遍历班级查找该班学生的性别 分类计算均值

        Optional<ChapterNode> chapterNode=chapterContentDao.findById(chapterID);
        if(chapterNode.isPresent())
        {
            ArrayList<Map>resultMap=new ArrayList<>();
            ArrayList<CourseClass>classesTemp=new ArrayList<>();

            if (courseClassID==null||courseClassID==0)
                classesTemp=getClassesByCourseID(chapterNode.get().getCourseID());
            else if (courseClassID>0)
            {
                Optional<CourseClass> classTemp=courseClassDao.findById(courseClassID);
                if (classTemp.isPresent())
                    classesTemp.add(classTemp.get());
            }
            ArrayList<StudentChapter>tempList=studentChapterDao.findByChapterID(chapterNode.get().getId());//该章节下所有的学生成绩

            for(CourseClass c:classesTemp)
            {
                Map<String,Object>classMap=new HashMap<>();
                ArrayList<UserInfo>classStudents=getStudentsByClassID(c.getId());
                ArrayList<Integer>studentIDs=new ArrayList<>();
                for(UserInfo u:classStudents)
                {
                    studentIDs.add(u.getUserID());
                }

                Map<String,Object>chapterMap=new HashMap<>();
                chapterMap.put("chapterName",chapterNode.get().getContentName());
                chapterMap.put("chapterID",chapterNode.get().getId());
                chapterMap.put("siblingID",chapterNode.get().getSiblingID());

                if (tempList!=null&&tempList.size()!=0)
                {
                    ArrayList<StudentChapter>boysList=new ArrayList<>();
                    ArrayList<StudentChapter>girlsList=new ArrayList<>();

                    ArrayList<Integer>boyScore1=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>girlScore1=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>totalScore1=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>totalScore2=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>boyScore2=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>girlScore2=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>boyScoreAvgDis=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>girlScoreAvgDis=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>totalScoreAvgDis=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));

                    ArrayList<Integer>boyRateDis=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>girlRateDis=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));
                    ArrayList<Integer>totalRateDis=new ArrayList<>(Arrays.asList(0,0,0,0,0,0));

                    int boyNum=0;
                    int girlNum=0;
                    int totalNum=0;
                    float boySum1=0;
                    int boyNum1=0;
                    float boySum2=0;
                    int boyNum2=0;
                    float girlSum1=0;
                    int girlNum1=0;
                    float girlSum2=0;
                    int girlNum2=0;
                    float boyRateSum=0;
                    int boyRateNum=0;
                    float girlRateSum=0;
                    int girlRateNum=0;

                    for(int j=tempList.size()-1;j>=0;j--)                                             //性别筛选
                    {
                        if (studentIDs.contains(tempList.get(j).getStudentID()))                   //如果在这个班
                        {
                            totalNum+=1;
                            int index1=tempList.get(j).getTotalScore_1()==null?5:tempList.get(j).getTotalScore_1() / 10 < 6 ? 0 : tempList.get(j).getTotalScore_1() / 10 == 10 ? 4 : tempList.get(j).getTotalScore_1() / 10 - 5;
                            int index2=tempList.get(j).getTotalScore_2()==null?5:tempList.get(j).getTotalScore_2()/10<6?0:tempList.get(j).getTotalScore_2()/10==10?4:tempList.get(j).getTotalScore_2()/10-5;
                            int rateIndex=tempList.get(j).getRate()==null?5:tempList.get(j).getRate()==5?4:tempList.get(j).getRate();
                            int avgScoreIndex=5;
                            if (tempList.get(j).getTotalScore_1()!=null&&tempList.get(j).getTotalScore_2()!=null)
                            {
                                int temp=(tempList.get(j).getTotalScore_1()+tempList.get(j).getTotalScore_2())/2;
                                avgScoreIndex=temp/10<6?0:temp/10==10?4:temp/10-5;
                            }

                            if(userDao.findById(tempList.get(j).getStudentID()).get().getGender().equals("男"))
                            {
                                boysList.add(tempList.get(j));
                                boyNum+=1;
                                if(tempList.get(j).getTotalScore_1()!=null)
                                {
                                    boySum1 += tempList.get(j).getTotalScore_1();
                                    boyNum1 += 1;
                                }
                                if (tempList.get(j).getTotalScore_2()!=null)
                                {
                                    boySum2+=tempList.get(j).getTotalScore_2();
                                    boyNum2+=1;
                                }
                                if (tempList.get(j).getRate()!=null)
                                {
                                    boyRateSum+=tempList.get(j).getRate();
                                    boyRateNum+=1;
                                }
                                boyScore1.set(index1,boyScore1.get(index1)+1);
                                boyScore2.set(index2,boyScore2.get(index2)+1);
                                boyRateDis.set(rateIndex,boyRateDis.get(rateIndex)+1);
                                boyScoreAvgDis.set(avgScoreIndex,boyScoreAvgDis.get(avgScoreIndex)+1);
                            }
                            else
                            {
                                girlsList.add(tempList.get(j));
                                girlNum+=1;
                                if(tempList.get(j).getTotalScore_1()!=null)
                                {
                                    girlSum1+=tempList.get(j).getTotalScore_1();
                                    girlNum1+=1;
                                }
                                if (tempList.get(j).getTotalScore_2()!=null)
                                {
                                    girlSum2+=tempList.get(j).getTotalScore_2();
                                    girlNum2+=1;
                                }
                                if(tempList.get(j).getRate()!=null)
                                {
                                    girlRateSum+=tempList.get(j).getRate();
                                    girlRateNum+=1;
                                }

                                girlScore1.set(index1,girlScore1.get(index1)+1);
                                girlScore2.set(index2,girlScore2.get(index2)+1);
                                girlRateDis.set(rateIndex,girlRateDis.get(rateIndex)+1);
                                girlScoreAvgDis.set(avgScoreIndex,girlScoreAvgDis.get(avgScoreIndex)+1);
                            }
                            totalScore1.set(index1,totalScore1.get(index1)+1);
                            totalScore2.set(index2,totalScore2.get(index2)+1);
                            totalRateDis.set(rateIndex,totalRateDis.get(rateIndex)+1);
                            totalScoreAvgDis.set(avgScoreIndex,totalScoreAvgDis.get(avgScoreIndex)+1);

                            tempList.remove(j);
                        }
                    }



                    chapterMap.put("boysNum",boyNum);
                    chapterMap.put("girlsNum",girlNum);
                    chapterMap.put("totalNum",totalNum);
                    chapterMap.put("boyAverage1",boySum1!=0?boySum1/boyNum1:0);
                    chapterMap.put("boyAverage2",boySum2!=0?boySum2/boyNum2:0);
                    chapterMap.put("girlAverage1",girlSum1!=0?girlSum1/girlNum1:0);
                    chapterMap.put("girlAverage2",girlSum2!=0?girlSum2/girlNum2:0);
                    chapterMap.put("totalAverage1",(boySum1+girlSum1)!=0?(boySum1+girlSum1)/(boyNum1+girlNum1):0);
                    chapterMap.put("totalAverage2",(boySum2+girlSum2)!=0?(boySum2+girlSum2)/(boyNum2+girlNum2):0);
                    chapterMap.put("boyScoreDistribute1",boyScore1);
                    chapterMap.put("boyScoreDistribute2",boyScore2);
                    chapterMap.put("girlScoreDistribute1",girlScore1);
                    chapterMap.put("girlScoreDistribute2",girlScore2);
                    chapterMap.put("totalScoreDistribute1",totalScore1);
                    chapterMap.put("totalScoreDistribute2",totalScore2);
                    chapterMap.put("boyScoreAvgDistribute",boyScoreAvgDis);
                    chapterMap.put("girlScoreAvgDistribute",girlScoreAvgDis);
                    chapterMap.put("totalScoreAvgDistribute",totalScoreAvgDis);
                    chapterMap.put("boyRateAvg",boyRateSum!=0?boyRateSum/boyRateNum:0);
                    chapterMap.put("girlRateAvg",girlRateSum!=0?girlRateSum/girlRateNum:0);
                    chapterMap.put("totalRateAvg",(boyRateSum+girlRateSum)!=0?(boyRateSum+girlRateSum)/(boyRateNum+girlRateNum):0);
                    chapterMap.put("boyRateDistribute",boyRateDis);
                    chapterMap.put("girlRateDistribute",girlRateDis);
                    chapterMap.put("totalRateDistribute",totalRateDis);

                    if(getDetail!=null&&getDetail>0)
                    {
                        chapterMap.put("boys",boysList);
                        chapterMap.put("girls",girlsList);
                    }

                }
                classMap.put("classNum",c.getClassNum());
                classMap.put("scoreInfo",chapterMap);
                resultMap.add(classMap);
            }
            return resultMap;
        }
        else
            return null;
    }

    @Override
    public ChapterNode getCurrentProgress(Integer courseClassID, Integer studentID)
    {
        Takes takeTemp=takesDao.findByStudentIDAndCourseClassID(studentID,courseClassID);

        return takeTemp==null?null:getChapterByID(takeTemp.getCurrentProgress());
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
    public ArrayList<CourseAndClass> getCoursesByTeacherID(Integer teacherID)throws CloneNotSupportedException
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
                Optional<UserInfo> temp=userDao.findById(i.getStudentID());
                if (temp.isPresent())
                {
                    UserInfo userInfo=new UserInfo(temp.get());
                    userInfos.add(userInfo);
                }
            }
            return userInfos;
        }
        else
            return null;
    }

    @Override
    public List<CourseInfo> getAllCourses()throws CloneNotSupportedException
    {
        List<CourseInfo>temp=courseInfoDao.findAll();
        List<CourseInfo>newList=new ArrayList<>();
        for(CourseInfo i:temp)
        {
            CourseInfo tempc=i.clone();
            tempc.setCourseName(getCourseNameByNameID(Integer.parseInt(i.getCourseName())).getCourseName());
            newList.add(tempc);
        }
        return newList;
    }

    @Override
    public List<CourseRelationEntity> getAllCoursesRelation()
    {
        List<CourseRelationEntity>list=new ArrayList<>();
        List<CourseRelation> courseRelations=courseRelationDao.findAll();
        Map<CourseName,ArrayList<CourseName>> courseMap=new HashMap<>();
        Map<CourseName,ArrayList<CourseName>>subCourseMap=new HashMap<>();
        for(CourseRelation i:courseRelations)
        {
            CourseName temp=getCourseNameByNameID(i.getCourseNameID());
            courseMap.computeIfAbsent(temp,k->new ArrayList<>());
            subCourseMap.computeIfAbsent(temp,k->new ArrayList<>());
            if(i.getPreCourseNameID()!=0)
                courseMap.get(temp).add(getCourseNameByNameID(i.getPreCourseNameID()));
            if(subCourseMap.get(temp).size()==0)
            {
                ArrayList<CourseRelation>subCoursesList=courseRelationDao.findByPreCourseNameID(i.getCourseNameID());
                if(subCoursesList!=null&&subCoursesList.size()!=0)
                {
                    ArrayList<CourseName>subCoursesName=new ArrayList<>();
                    for(CourseRelation j:subCoursesList)
                    {
                        subCoursesName.add(getCourseNameByNameID(j.getCourseNameID()));
                    }
                    subCourseMap.put(temp,subCoursesName);
                }
            }
        }
        Set<CourseName>courseNames=courseMap.keySet();

        while(courseNames.size()!=0)
        {
            ArrayList<CourseName>preList=new ArrayList<>();
            for(CourseName i:courseNames)
            {
                int num=0;
                for (CourseName j:courseMap.get(i))
                {
                    if (courseNames.contains(j))
                    {
                        num++;
                        break;
                    }
                }
                if (num==0)
                    preList.add(i);
            }
            for (CourseName i:preList)
            {
                list.add(new CourseRelationEntity(i,courseMap.get(i),subCourseMap.get(i)));
                courseNames.remove(i);
            }
            preList.clear();
        }
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
        Map<Integer,ArrayList<ChapterNode>> chapterMap=new HashMap<>();
        Map<Integer,ArrayList<ChapterNode>>subChapterMap=new HashMap<>();
        for(ChapterRelation i:chapterRelations)
        {
            chapterMap.computeIfAbsent(i.getChapterID(),k->new ArrayList<>());
            subChapterMap.computeIfAbsent(i.getChapterID(),k->new ArrayList<>());
            chapterMap.get(i.getChapterID()).add(getChapterByID(i.getPreChapterID()));
            if (subChapterMap.get(i.getChapterID()).size()==0)
            {
                ArrayList<ChapterRelation>subChaptersList=chapterRelationDao.findByPreChapterID(i.getChapterID());
                if(subChaptersList!=null&&subChaptersList.size()!=0)
                {
                    ArrayList<ChapterNode>subChapters=new ArrayList<>();
                    for(ChapterRelation j:subChaptersList)
                    {
                        subChapters.add(chapterContentDao.findById(j.getChapterID()).get());
                    }
                    subChapterMap.put(i.getChapterID(),subChapters);
                }
            }
        }
        Set<Integer>chapterIDs=chapterMap.keySet();
        for(Integer i:chapterIDs)
            list.add(new ChapterRelationEntity(chapterContentDao.findById(i).get(),chapterMap.get(i),subChapterMap.get(i)));
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
    public Map<String, Integer> getStudentNumByTeacher(Integer teacherID)throws CloneNotSupportedException
    {
        ArrayList<CourseAndClass>courseAndClass=getCoursesByTeacherID(teacherID);
        Map<String,Integer>courseToNum=new HashMap<>();
        if (courseAndClass!=null)
        {
            List<CourseName>courseNames=courseNameDao.findAll();
            for (CourseName i:courseNames)
                courseToNum.computeIfAbsent(i.getCourseName(),k->0);

            for(CourseAndClass i:courseAndClass)
            {
                String name=i.getCourseInfo().getCourseName();
                Integer num=courseToNum.get(name)+getStudentsByClassID(i.getCourseClass().getId()).size();
                courseToNum.put(name,num);
            }
        }
        return courseToNum;
    }

    @Override
    public Map getStudentNumBySemesterAndYear(Integer year,String semester)
    {
        ArrayList<CourseAndClassList>courseAndClassLists=new ArrayList<>();
        ArrayList<CourseInfo>courseInfos=courseInfoDao.findByCourseYearAndCourseSemester(year,semester);
        if(courseInfos!=null)
            for(CourseInfo i:courseInfos)
            {
                ArrayList<CourseClass>classes=courseClassDao.findByCourseID(i.getCourseID());
                courseAndClassLists.add(new CourseAndClassList(i,classes));
            }
        Map<String,Integer>courseToNum=new HashMap<>();

        for(CourseAndClassList i:courseAndClassLists)
        {
            String name=getCourseNameByNameID(Integer.parseInt(i.getCourseInfo().getCourseName())).getCourseName();
            courseToNum.computeIfAbsent(name,k->0);
            Integer num = 0;
            if(i.getCourseClasses()!=null)
            {

                for (CourseClass j : i.getCourseClasses())
                {
                    ArrayList<UserInfo>temp=getStudentsByClassID(j.getId());
                    if (temp!=null)
                        num += getStudentsByClassID(j.getId()).size();
                }
            }
            courseToNum.put(name,courseToNum.get(name)+num);
        }
        return courseToNum;
    }

    @Override
    public Map getStudentNumByYear(Integer year)
    {
        ArrayList<CourseAndClassList>courseAndClassLists=new ArrayList<>();
        ArrayList<CourseInfo>courseInfos=courseInfoDao.findByCourseYear(year);
        if(courseInfos!=null)
            for(CourseInfo i:courseInfos)
            {
                ArrayList<CourseClass>classes=courseClassDao.findByCourseID(i.getCourseID());
                courseAndClassLists.add(new CourseAndClassList(i,classes));
            }
        Map<String,Integer>courseToNum=new HashMap<>();

        for(CourseAndClassList i:courseAndClassLists)
        {
            String name=getCourseNameByNameID(Integer.parseInt(i.getCourseInfo().getCourseName())).getCourseName();
            courseToNum.computeIfAbsent(name,k->0);
            Integer num = 0;
            if(i.getCourseClasses()!=null)
            {

                for (CourseClass j : i.getCourseClasses())
                {
                    ArrayList<UserInfo>temp=getStudentsByClassID(j.getId());
                    if (temp!=null)
                        num += getStudentsByClassID(j.getId()).size();
                }
            }
            courseToNum.put(name,courseToNum.get(name)+num);
        }
        return courseToNum;
    }

    @Override
    public ArrayList<Map> getRateBySemesterAndYear(String courseNameID)
    {
        ArrayList<CourseInfo>courseInfos=courseInfoDao.findByCourseName(courseNameID);
        Map<SemesterAndYear,ArrayList<Float>>semYearToRateMap=new HashMap<>();
        for(CourseInfo i:courseInfos)
        {
            SemesterAndYear temp=new SemesterAndYear(i.getCourseSemester(),i.getCourseYear());
            semYearToRateMap.computeIfAbsent(temp,k->new ArrayList<>());
            semYearToRateMap.get(temp).add(i.getRate());
        }
        Set<SemesterAndYear>semesterAndYears=semYearToRateMap.keySet();

        ArrayList<Map>resultMap=new ArrayList<>();
        for(SemesterAndYear i:semesterAndYears)
        {
            Map<String,Object>rateMap=new HashMap<>();
            Float sum=0F;
            for(Float j:semYearToRateMap.get(i))
                sum+=j;
            if (semYearToRateMap.get(i).size()!=0)
                sum/=semYearToRateMap.get(i).size();
            rateMap.put("semesterAndYear",i);
            rateMap.put("avgRate",sum);
            resultMap.add(rateMap);
        }
        return resultMap;
    }

    @Override
    public ArrayList<Map> getClassesByNIDAndTID(String courseNameID, Integer teacherID)throws CloneNotSupportedException
    {
        ArrayList<Map>resultMap=new ArrayList<>();
        ArrayList<CourseInfo>courseInfos=courseInfoDao.findByCourseNameAndTeacherID(courseNameID,teacherID);
        if (courseInfos!=null)
            for(CourseInfo i:courseInfos)
            {
                ArrayList<CourseClass>temp=getClassesByCourseID(i.getCourseID());
                if (temp!=null)
                {
                    Map<String,Object>courseClassMap=new HashMap<>();
                    courseClassMap.put("courseInfo",i);
                    courseClassMap.put("classes",temp);
                    resultMap.add(courseClassMap);
                }
            }
        return resultMap;
    }
    public ArrayList<Map> getTeacherListByNID(String courseNameID)
    {
        if(courseNameID!=null&&!NumberUtils.isNumber(courseNameID))
        {
            CourseName nameTemp=courseNameDao.getByCourseName(courseNameID);
            if (nameTemp!=null)
                courseNameID=nameTemp.getCourseNameID().toString();
            else
                return null;
        }
        List<CourseInfo>courseInfos=courseNameID==null?courseInfoDao.findAll():courseInfoDao.findByCourseName(courseNameID);
        //if (courseInfos!=null)
        ArrayList<Map>teacherInfoMap=new ArrayList<>();
        for(CourseInfo i:courseInfos)
        {
            Map<String,Object>tempMap=new HashMap<>();
            tempMap.put("courseInfo",i);
            teacherInfoMap.add(tempMap);
        }
        return teacherInfoMap;
    }

    @Override
    public Integer addStudentComment(Integer chapterID, Integer studentID, String comment, Integer rate)
    {
        StudentChapter studentChapter=studentChapterDao.findByChapterIDAndStudentID(chapterID,studentID);
        if(studentChapter==null)
        {
            studentChapter=new StudentChapter();
            studentChapter.setChapterID(chapterID);
            studentChapter.setStudentID(studentID);
        }
            studentChapter.setComment(comment);
            studentChapter.setRate(rate);
        studentChapterDao.saveAndFlush(studentChapter);
        return 1;
    }

    @Override
    public Integer addClassComment(Integer courseClassID, Integer studentID, String comment, Integer rate)
    {
        Takes takes=takesDao.findByStudentIDAndCourseClassID(studentID,courseClassID);
        if (takes!=null)
        {
            takes.setComment(comment);
            takes.setRate(rate);
            takesDao.saveAndFlush(takes);
            return 1;
        }
        else
            return 0;
    }
    @Override
    public Map getCourseYearAvgScoreRate(Integer courseNameID,Integer teacherID)
    {
        ArrayList<CourseInfo>courseInfos=new ArrayList<>();
        Map<Integer,Map<String,Object>>yearMap=new HashMap<>();
        Map<String,Map<String,Object>>semesterMap=new HashMap<>();
        if (teacherID!=null)
            courseInfos=courseInfoDao.findByCourseNameAndTeacherID(courseNameID.toString(),teacherID);
        else
            courseInfos=courseInfoDao.findByCourseName(courseNameID.toString());
        if (courseInfos!=null&&courseInfos.size()!=0)
        {
            for (CourseInfo i:courseInfos)
            {
                Map temp=getCourseClassAvgScore(i.getCourseID());
                if(temp==null)
                    continue;

                yearMap.computeIfAbsent(i.getCourseYear(),k->{Map tempMap=new HashMap();tempMap.put("score",new ArrayList<>());tempMap.put("rate",new ArrayList<>());return tempMap;});
                semesterMap.computeIfAbsent(i.getCourseYear()+i.getCourseSemester(),k->{Map tempMap=new HashMap();tempMap.put("score",new ArrayList<>());tempMap.put("rate",new ArrayList<>());return tempMap;});

                Float boyScore=(Float) temp.get("courseBoyAvgScore");
                Float girlScore=(Float) temp.get("courseGirlAvgScore");
                Float boyRate=(Float) temp.get("courseBoyAvgRate");
                Float girlRate=(Float) temp.get("courseGirlAvgRate");
                if (boyScore==null)
                    boyScore=girlScore;
                if (girlScore==null)
                    girlScore=boyScore;
                if (boyRate==null)
                    boyRate=girlRate;
                if (girlRate==null)
                    girlRate=boyRate;

                if(boyScore!=null)
                {
                    Map tempMap=yearMap.get(i.getCourseYear());
                    ArrayList<Float>tempList=(ArrayList<Float>)tempMap.get("score");
                    tempList.add(0.5F*boyScore+0.5F*girlScore);
                    tempMap=semesterMap.get(i.getCourseYear()+i.getCourseSemester());
                    tempList=(ArrayList<Float>)tempMap.get("score");
                    tempList.add(0.5F*boyScore+0.5F*girlScore);
                }
                if(boyRate!=null)
                {
                    Map tempMap=yearMap.get(i.getCourseYear());
                    ArrayList<Float>tempList=(ArrayList<Float>)tempMap.get("rate");
                    tempList.add(0.5F*boyRate+0.5F*girlRate);
                    tempMap=semesterMap.get(i.getCourseYear()+i.getCourseSemester());
                    tempList=(ArrayList<Float>)tempMap.get("rate");
                    tempList.add(0.5F*boyRate+0.5F*girlRate);
                }
            }
            Map<String,Map>resultMap=new HashMap<>();

            Set<Integer> yearKey=yearMap.keySet();
            Set<String> semesterKey=semesterMap.keySet();
            Float num=0F;
            for (Integer i:yearKey)
            {
                num=0F;
                Map tempMap=yearMap.get(i);
                ArrayList<Float>tempList=(ArrayList<Float>)tempMap.get("score");
                for (Float j:tempList)
                    num+=j;
                tempMap.put("score",num/tempList.size());
                num=0F;
                tempList=(ArrayList<Float>)tempMap.get("rate");
                for (Float j:tempList)
                    num+=j;
                tempMap.put("rate",num/tempList.size());

            }
            for (String i:semesterKey)
            {
                num=0F;
                Map tempMap=semesterMap.get(i);
                ArrayList<Float>tempList=(ArrayList<Float>)tempMap.get("score");
                for (Float j:tempList)
                    num+=j;
                tempMap.put("score",num/tempList.size());
                num=0F;
                tempList=(ArrayList<Float>)tempMap.get("rate");
                for (Float j:tempList)
                    num+=j;
                tempMap.put("rate",num/tempList.size());
            }

            resultMap.put("year",yearMap);
            resultMap.put("semester",semesterMap);
            return resultMap;
        }
        else
            return null;
    }
}
