package org.lab409.service.implement;
import org.lab409.dao.*;
import org.lab409.entity.*;
import org.lab409.service.CourseService;
import org.lab409.service.ExerciseService;
import org.lab409.util.NLPUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.*;

@Service(value="exerciseService")
public class ExerciseServiceImp implements ExerciseService{
    @Autowired
    private ExerciseDao  exerciseDao;
    @Autowired
    private ExerciseChoiceDao  exerciseChoiceDao;
    @Autowired
    private StudentExerciseScoreDao  studentExerciseScoreDao;
    @Autowired
    private StudentChapterDao studentChapterDao;
    @Autowired
    private CourseInfoDao courseInfoDao;
    @Autowired
    private CourseNameDao courseNameDao;
    @Autowired
    private ChapterContentDao chapterContentDao;
    @Autowired
    private ChapterRelationDao chapterRelationDao;
    @Autowired
    private CourseRelationDao courseRelationDao;
    @Autowired
    private TakesDao takesDao;
    @Autowired
    private CourseClassDao courseClassDao;
    @Autowired
    private CourseService courseService;
    @Override
    @Transactional
    public ResultEntity findOneExerice(Integer exerciseId){
        ResultEntity resultEntity=new ResultEntity();
        if(exerciseId!=null){
            Exercise exercise=exerciseDao.findByExerciseId(exerciseId);
            if (exercise!=null)
            {
                if(exercise.getExerciseType()%3!=0){
                    List<ExerciseChoice> exerciseChoices=exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exerciseId);
                    resultEntity.setData(new ExerciseSet(exercise,exerciseChoices));
                }
                else
                    resultEntity.setData(new ExerciseSet(exercise));
                resultEntity.setState(1);
                resultEntity.setMessage("搜索习题成功！");
            }
            else
            {
                resultEntity.setMessage("搜索习题失败！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity addExercise(Exercise exercise){
        ResultEntity resultEntity=new ResultEntity();
        if(exercise!=null){
            resultEntity.setData(exerciseDao.saveAndFlush(exercise));
            if (resultEntity.getData()!=null)
            {
                if(exercise.getExerciseType()<=3)
                    setTotalScore(exercise.getChapterId(),"preview");
                else
                    setTotalScore(exercise.getChapterId(),"review");
                resultEntity.setState(1);
                resultEntity.setMessage("创建习题成功！");
            }
            else
            {
                resultEntity.setMessage("创建习题失败！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity deleteExercise(Integer exerciseId){
        ResultEntity resultEntity=new ResultEntity();
        if(exerciseId!=null){
            Exercise exercise=exerciseDao.findByExerciseId(exerciseId);
            if (exercise!=null)
            {
                exerciseDao.delete(exercise);
                exerciseDao.flush();
                resultEntity.setState(1);
                resultEntity.setMessage("习题删除成功！");
            }
            else
            {
                resultEntity.setMessage("未找到对应习题！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity alterExercise(Exercise exercise){
        ResultEntity resultEntity=new ResultEntity();
        if(exercise!=null){
            Exercise exercise1=exerciseDao.findByExerciseId(exercise.getExerciseId().intValue());
            if (exercise1!=null)
            {
                resultEntity.setData(exerciseDao.saveAndFlush(exercise));
                resultEntity.setState(1);
                resultEntity.setMessage("习题修改成功！");
            }
            else
            {
                resultEntity.setMessage("未找到对应习题！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity addExerciseChoice(ExerciseChoice exerciseChoice){
        ResultEntity resultEntity=new ResultEntity();
        if(exerciseChoice!=null){
            resultEntity.setData(exerciseChoiceDao.saveAndFlush(exerciseChoice));
            if (resultEntity.getData()!=null)
            {
                resultEntity.setState(1);
                resultEntity.setMessage("创建选项成功！");
            }
            else
            {
                resultEntity.setMessage("创建选项失败！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity deleteExerciseChoice(Integer exerciseChoiceId){
        ResultEntity resultEntity=new ResultEntity();
        if(exerciseChoiceId!=null){
            ExerciseChoice exerciseChoice=exerciseChoiceDao.findById(exerciseChoiceId.intValue());
            if (exerciseChoice!=null)
            {
                exerciseChoiceDao.delete(exerciseChoice);
                exerciseChoiceDao.flush();
                resultEntity.setState(1);
                resultEntity.setMessage("选项删除成功！");
            }
            else
            {
                resultEntity.setMessage("未找到对应选项！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity alterExerciseChoice(ExerciseChoice exerciseChoice){
        ResultEntity resultEntity=new ResultEntity();
        if(exerciseChoice!=null){
            ExerciseChoice exerciseChoice1=exerciseChoiceDao.findById(exerciseChoice.getId().intValue());
            if (exerciseChoice1!=null)
            {
                resultEntity.setData(exerciseChoiceDao.saveAndFlush(exerciseChoice));
                resultEntity.setState(1);
                resultEntity.setMessage("选项修改成功！");
            }
            else
            {
                resultEntity.setMessage("未找到对应选项！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity findOneAnswerById(Integer studentExerciseScoreId){
        ResultEntity resultEntity=new ResultEntity();
        if(studentExerciseScoreId!=null){
            StudentExerciseScore studentExerciseScore=studentExerciseScoreDao.findById(studentExerciseScoreId.intValue());
            if (studentExerciseScore!=null)
            {
                resultEntity.setData(studentExerciseScore);
                resultEntity.setState(1);
                resultEntity.setMessage("学生答案搜寻成功！");
            }
            else
            {
                resultEntity.setMessage("未找到对应学生答案！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity findOneAnswer(Integer exerciseId,Integer studentId){
        ResultEntity resultEntity=new ResultEntity();
        if(exerciseId!=null&&studentId!=null){
            StudentExerciseScore studentExerciseScore=studentExerciseScoreDao.findByExerciseIdAndStudentId(exerciseId,studentId);
            if (studentExerciseScore!=null)
            {
                resultEntity.setData(studentExerciseScore);
                resultEntity.setState(1);
                resultEntity.setMessage("学生答案搜寻成功！");
            }
            else
            {
                resultEntity.setMessage("未找到对应学生答案！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity answerOne(String answer,Integer exerciseId,Integer studentId){
        ResultEntity resultEntity=new ResultEntity();
        StudentExerciseScore studentExerciseScore=new StudentExerciseScore(studentId,exerciseId,answer,0);
        studentExerciseScore.setCorrected(0);
        Exercise exercise=exerciseDao.findByExerciseId(exerciseId);
        if(studentExerciseScore!=null){
            if(exercise.getExerciseType()%3!=0){
                if(answer.equals(exercise.getExerciseAnswer())){
                    studentExerciseScore.setCorrected(1);
                    studentExerciseScore.setExerciseScore(exercise.getExercisePoint());
                }
            }
            resultEntity.setData(studentExerciseScoreDao.saveAndFlush(studentExerciseScore));
            if (resultEntity.getData()!=null)
            {
                resultEntity.setState(1);
                resultEntity.setMessage("答题成功 ！");
            }
            else
            {
                resultEntity.setMessage("答题失败！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;

    }
    @Override
    @Transactional
    public ResultEntity answerAll(List<String> answers, Integer studentId, Integer chapterId,String type, String comment,Integer rate) throws Exception{
        ResultEntity resultEntity=new ResultEntity();
        if(answers!=null&&type!=null&&chapterId!=null&&studentId!=null){
            List<ExerciseSet> exerciseSets=new ArrayList<>();
            int type1=0;
            int type2=0;
            int type3=0;
            if(type.equals("preview")){
                type1=1;
                type3=2;
                type2=3;
            }
            else{
                type1=4;
                type3=5;
                type2=6;
            }
            List<Integer> exerciseIds=new ArrayList<>();
            List<Exercise> exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type1);
            for (Exercise exercise:exercises){
                exerciseSets.add(new ExerciseSet(exercise,exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId())));
                exerciseIds.add(exercise.getExerciseId());
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type3);
            for (Exercise exercise:exercises){
                exerciseSets.add(new ExerciseSet(exercise,exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId())));
                exerciseIds.add(exercise.getExerciseId());
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type2);
            for (Exercise exercise:exercises){
                exerciseSets.add(new ExerciseSet(exercise));
            }
            for(int i=0;i<answers.size();i++){
                answerOne(answers.get(i),exerciseSets.get(i).getExercise().getExerciseId(),studentId);
            }
            int score=0;
            for(Integer exerciseId:exerciseIds){
                score+=studentExerciseScoreDao.findByExerciseIdAndStudentId(exerciseId,studentId).getExerciseScore();
            }
            StudentChapter studentChapter;
            if(!studentChapterDao.existsByChapterIDAndStudentID(chapterId,studentId)){
                studentChapter=new StudentChapter();
                studentChapter.setChapterID(chapterId);
                studentChapter.setStudentID(studentId);
                studentChapterDao.saveAndFlush(studentChapter);
            }
            if(!type.equals("preview")){
                studentChapter=studentChapterDao.findByChapterIDAndStudentID(chapterId,studentId);
                studentChapter.setRate(rate);
                studentChapter.setComment(comment);
                studentChapter.setTotalScore_2(score);
                studentChapter.setScored_2(0);
                studentChapterDao.saveAndFlush(studentChapter);
                new NLPUtil().setCommentNLPRate(comment,chapterId,studentId);
            }
            else{
                studentChapter=studentChapterDao.findByChapterIDAndStudentID(chapterId,studentId);
                studentChapter.setTotalScore_1(score);
                studentChapter.setScored_1(0);
                studentChapterDao.saveAndFlush(studentChapter);
            }
            resultEntity.setState(1);
            resultEntity.setMessage("答题成功 ！");
        }
        else
        {
            resultEntity.setMessage("传入参数有空值！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity alterAnswer(String answer,Integer exerciseId,Integer studentId){
        ResultEntity resultEntity=new ResultEntity();
        if(exerciseId!=null&&studentId!=null){
            StudentExerciseScore studentExerciseScore=studentExerciseScoreDao.findByExerciseIdAndStudentId(exerciseId,studentId);
            if (studentExerciseScore!=null)
            {
                studentExerciseScore.setStudentAnswer(answer);
                resultEntity.setData(studentExerciseScoreDao.saveAndFlush(studentExerciseScore));
                resultEntity.setState(1);
                resultEntity.setMessage("学生答案修改成功！");
            }
            else
            {
                resultEntity.setMessage("未找到对应学生答案！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity correctOne(Integer studentExerciseScoreId,Integer score){
        ResultEntity resultEntity=new ResultEntity();
        StudentExerciseScore studentExerciseScore=studentExerciseScoreDao.findById(studentExerciseScoreId.intValue());
        if(studentExerciseScore!=null){
            studentExerciseScore.setExerciseScore(score);
            resultEntity.setData(studentExerciseScoreDao.saveAndFlush(studentExerciseScore));
            if (resultEntity.getData()!=null)
            {
                resultEntity.setState(1);
                resultEntity.setMessage("批改成功 ！");
            }
            else
            {
                resultEntity.setMessage("批改失败！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity correctAll(List<Integer> scores, Integer studentId,Integer chapterId,String type){
        ResultEntity resultEntity=new ResultEntity();
        if(studentId!=null&&chapterId!=null&&type!=null){
            int trueType=0;
            int type1=0;
            int type2=0;
            if(type.equals("preview")){
                trueType=3;
                type1=1;
                type2=2;
            }
            else{
                trueType=6;
                type1=4;
                type2=5;
            }
            List<Exercise> exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,trueType);
            List<Integer> exerciseIds=new ArrayList<>();
            for(Exercise exercise:exercises){
                exerciseIds.add(exercise.getExerciseId());
            }
            StudentExerciseScore studentExerciseScore;
            for(int i=0;i<scores.size();i++){
                studentExerciseScore=studentExerciseScoreDao.findByExerciseIdAndStudentId(exerciseIds.get(i),studentId);
                studentExerciseScore.setExerciseScore(scores.get(i));
                studentExerciseScore.setCorrected(1);
                studentExerciseScoreDao.saveAndFlush(studentExerciseScore);
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type1);
            for(Exercise exercise:exercises){
                exerciseIds.add(exercise.getExerciseId());
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type2);
            for(Exercise exercise:exercises){
                exerciseIds.add(exercise.getExerciseId());
            }
            int score=0;
            for(Integer exerciseId:exerciseIds){
                score+=studentExerciseScoreDao.findByExerciseIdAndStudentId(exerciseId,studentId).getExerciseScore();
            }
            if(type.equals("preview")){
                StudentChapter studentChapter=studentChapterDao.findByChapterIDAndStudentID(chapterId,studentId);
                studentChapter.setTotalScore_1(score);
                studentChapter.setScored_1(1);
                studentChapterDao.saveAndFlush(studentChapter);
            }
            else {
                StudentChapter studentChapter=studentChapterDao.findByChapterIDAndStudentID(chapterId,studentId);
                studentChapter.setTotalScore_2(score);
                studentChapter.setScored_2(1);
                studentChapterDao.saveAndFlush(studentChapter);
            }
            resultEntity.setState(1);
            resultEntity.setMessage("批改成功 ！");
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @Override
    @Transactional
    public ResultEntity viewExercise(Integer chapterId,String type){
        ResultEntity resultEntity=new ResultEntity();
        if(chapterId!=null){
            List<ExerciseSet> exerciseSets=new ArrayList<>();
            int type1=0;
            int type2=0;
            int type3=0;
            if(type.equals("preview")){
                type1=1;
                type3=2;
                type2=3;
            }
            else{
                type1=4;
                type3=5;
                type2=6;
            }
            List<Exercise> exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type1);
            for (Exercise exercise:exercises){
                exerciseSets.add(new ExerciseSet(exercise,exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId())));
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type3);
            for (Exercise exercise:exercises){
                exerciseSets.add(new ExerciseSet(exercise,exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId())));
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type2);
            for (Exercise exercise:exercises){
                exerciseSets.add(new ExerciseSet(exercise));
            }
            resultEntity.setData(exerciseSets);
            if (resultEntity.getData()!=null)
            {
                if(type.equals("preview")){
                    if(chapterContentDao.findById(chapterId).get().getExerciseVisible_1()!=null&&chapterContentDao.findById(chapterId).get().getExerciseVisible_1())
                    {
                        Timestamp now = new Timestamp(new Date().getTime());
                        if(chapterContentDao.findById(chapterId).get().getExerciseDeadline_1()!=null&&now.after(chapterContentDao.findById(chapterId).get().getExerciseDeadline_1())){
                            resultEntity.setState(4);
                            resultEntity.setMessage("习题已过deadline！");
                        }
                        else{
                            resultEntity.setState(1);
                            resultEntity.setMessage("查看成功！");
                        }
                    }
                    else {
                        resultEntity.setState(2);
                        resultEntity.setMessage("习题当前设置为不可见！");
                    }
                }
                else{
                    if(chapterContentDao.findById(chapterId).get().getExerciseDeadline_2()!=null&&chapterContentDao.findById(chapterId).get().getExerciseVisible_2())
                    {
                        Timestamp now = new Timestamp(new Date().getTime());
                        if(chapterContentDao.findById(chapterId).get().getExerciseDeadline_2()!=null&&now.after(chapterContentDao.findById(chapterId).get().getExerciseDeadline_2())){
                            resultEntity.setState(4);
                            resultEntity.setMessage("习题已过deadline！");
                        }
                        else{
                            resultEntity.setState(1);
                            resultEntity.setMessage("查看成功！");
                        }
                    }
                    else {
                        resultEntity.setState(2);
                        resultEntity.setMessage("习题当前设置为不可见！");
                    }
                }
            }
            else
            {
                resultEntity.setMessage("无题目！");
                resultEntity.setState(3);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
    @Override
    @Transactional
    public ResultEntity viewSomeAnswer(Integer chapterId,Integer studentId,String type){
        ResultEntity resultEntity=new ResultEntity();
        if(chapterId!=null&&studentId!=null){
            List<ExerciseSet> exerciseSets=new ArrayList<>();
            int type1=0;
            int type2=0;
            int type3=0;
            if(type.equals("preview")){
                type1=1;
                type2=3;
                type3=2;
            }
            else{
                type1=4;
                type2=6;
                type3=5;
            }
            List<Exercise> exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type1);
            for (Exercise exercise:exercises){
                if(studentExerciseScoreDao.existsByExerciseIdAndStudentId(exercise.getExerciseId(),studentId)==false){
                    resultEntity.setMessage("学生未答题！");
                    resultEntity.setState(0);
                    return resultEntity;
                }
                exerciseSets.add(new ExerciseSet(exercise,exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId()),studentExerciseScoreDao.findByExerciseIdAndStudentId(exercise.getExerciseId(),studentId).getStudentAnswer()));
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type3);
            for (Exercise exercise:exercises){
                if(studentExerciseScoreDao.existsByExerciseIdAndStudentId(exercise.getExerciseId(),studentId)==false){
                    resultEntity.setMessage("学生未答题！");
                    resultEntity.setState(0);
                    return resultEntity;
                }
                exerciseSets.add(new ExerciseSet(exercise,exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId()),studentExerciseScoreDao.findByExerciseIdAndStudentId(exercise.getExerciseId(),studentId).getStudentAnswer()));
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type2);
            for (Exercise exercise:exercises){
                if(studentExerciseScoreDao.existsByExerciseIdAndStudentId(exercise.getExerciseId(),studentId)==false){
                    resultEntity.setMessage("学生未答题！");
                    resultEntity.setState(0);
                    return resultEntity;
                }
                exerciseSets.add(new ExerciseSet(exercise,studentExerciseScoreDao.findByExerciseIdAndStudentId(exercise.getExerciseId(),studentId).getStudentAnswer()));
            }
            List<Integer> scores=exerciseScore(studentId,chapterId,type);
            resultEntity.setData(new ExerciseSetsDetails(exerciseSets,scores));
            if (resultEntity.getData()!=null)
            {
                resultEntity.setState(1);
                resultEntity.setMessage("查看成功！");
            }
            else
            {
                resultEntity.setMessage("查看失败！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @Override
    @Transactional
    public int calculateScore(Integer chapterId,Integer studentId){
        List<Exercise> exercises=exerciseDao.findByChapterId(chapterId);
        int score=0;
        for(Exercise exercise:exercises){
            score+=studentExerciseScoreDao.findByExerciseIdAndStudentId(exercise.getExerciseId(),studentId).getExerciseScore();
        }
        return score;
    }

    @Override
    @Transactional
     public ResultEntity rateNumber(Integer chapterId){
        ResultEntity resultEntity=new ResultEntity();
        if(chapterId!=null){
            List<Integer> numbers=new ArrayList<>();
            for(int i=1;i<=5;i++){
                numbers.add(studentChapterDao.countByChapterIDAndRate(chapterId,i));
            }
            resultEntity.setData(numbers);
            resultEntity.setState(1);
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @Override
    @Transactional
    public List<CourseInfo> findCourses(String courseName,int teacherId){
        List<CourseInfo> courseInfos=courseInfoDao.findByCourseNameAndTeacherID(courseName,teacherId);
        return courseInfos;
    }
    @Override
    @Transactional
    public List<CourseInfo> findCoursesById(int courseId,int teacherId){
        String courseName=courseInfoDao.findByCourseID(courseId).getCourseName();
        return findCourses(courseName,teacherId);
    }

    @Override
    @Transactional
    public List<ChapterNode> copyChapter(int sourceCourseId,int aimCourseId){
        List<ChapterNode> chapterNodes=chapterContentDao.findByCourseID(sourceCourseId);
        List<ChapterNode> deleteNodes=chapterContentDao.findByCourseID(aimCourseId);
        chapterContentDao.deleteAll(deleteNodes);
        chapterContentDao.flush();
        Map<Integer,Integer> mapper=new HashMap<Integer, Integer>();
        mapper.put(0,0);
        for(ChapterNode chapterNode:chapterNodes){
            ChapterNode temp=new ChapterNode();
            temp.setContentName(chapterNode.getContentName());
            temp.setContent(chapterNode.getContent());
            temp.setCourseID(aimCourseId);
            temp.setParentID(mapper.get(chapterNode.getParentID()));
            temp.setSiblingID(mapper.get(chapterNode.getSiblingID()));
            temp.setExerciseTitle(chapterNode.getExerciseTitle());
            chapterContentDao.saveAndFlush(temp);
            mapper.put(chapterNode.getId(),temp.getId());
        }
        List<ChapterRelation> chapterRelations=new ArrayList<>();
        for(ChapterNode chapterNode:chapterNodes){
            Integer chapterId=chapterNode.getId();
            chapterRelations=chapterRelationDao.findByChapterID(chapterId);
            for(ChapterRelation chapterRelation:chapterRelations){
                ChapterRelation temp=new ChapterRelation();
                temp.setChapterID(mapper.get(chapterId));
                temp.setPreChapterID(mapper.get(chapterRelation.getPreChapterID()));
                chapterRelationDao.save(temp);
            }
            chapterRelationDao.flush();
        }
        return chapterNodes;
    }

    @Override
    @Transactional
    public boolean copyExercise(int sourceChapterId,int aimChapterId,String type){
        int type1=0;
        int type2=0;
        int type3=0;
        if(type.equals("preview")){
            type1=1;
            type3=2;
            type2=3;
        }
        else{
            type1=4;
            type3=5;
            type2=6;
        }
        List<Exercise> exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(aimChapterId,type1);
        exerciseDao.deleteAll(exercises);
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(aimChapterId,type3);
        exerciseDao.deleteAll(exercises);
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(aimChapterId,type2);
        exerciseDao.deleteAll(exercises);
        exerciseDao.flush();
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(sourceChapterId,type1);
        List<ExerciseChoice> exerciseChoices=new ArrayList<>();
        for (Exercise exercise:exercises){
            Exercise temp=new Exercise(aimChapterId,exercise.getExerciseType(),exercise.getExerciseNumber(),exercise.getExerciseContent(),exercise.getExerciseAnswer(),exercise.getExerciseAnalysis(),exercise.getExercisePoint());
            exerciseDao.saveAndFlush(temp);
            exerciseChoices=exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId());
            for(ExerciseChoice exerciseChoice:exerciseChoices){
                ExerciseChoice anotherTemp=new ExerciseChoice(temp.getExerciseId(),exerciseChoice.getExerciceChoiceId(),exerciseChoice.getChoice());
                exerciseChoiceDao.save(anotherTemp);
            }
            exerciseChoiceDao.flush();
        }
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(sourceChapterId,type3);
        for (Exercise exercise:exercises){
            Exercise temp=new Exercise(aimChapterId,exercise.getExerciseType(),exercise.getExerciseNumber(),exercise.getExerciseContent(),exercise.getExerciseAnswer(),exercise.getExerciseAnalysis(),exercise.getExercisePoint());
            exerciseDao.saveAndFlush(temp);
            exerciseChoices=exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId());
            for(ExerciseChoice exerciseChoice:exerciseChoices){
                ExerciseChoice anotherTemp=new ExerciseChoice(temp.getExerciseId(),exerciseChoice.getExerciceChoiceId(),exerciseChoice.getChoice());
                exerciseChoiceDao.save(anotherTemp);
            }
            exerciseChoiceDao.flush();
        }
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(sourceChapterId,type2);
        for (Exercise exercise:exercises){
            Exercise temp=new Exercise(aimChapterId,exercise.getExerciseType(),exercise.getExerciseNumber(),exercise.getExerciseContent(),exercise.getExerciseAnswer(),exercise.getExerciseAnalysis(),exercise.getExercisePoint());
            exerciseDao.saveAndFlush(temp);
        }
        return true;
    }

    @Override
    @Transactional
    public List<Integer> exerciseScore(int studentId,int chapterId,String type){
        int type1=0;
        int type2=0;
        int type3=0;
        if(type.equals("preview")){
            type1=1;
            type3=2;
            type2=3;
        }
        else{
            type1=4;
            type3=5;
            type2=6;
        }

        List<Exercise> exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type1);
        List<Integer> scores=new ArrayList<>();
        for (Exercise exercise:exercises){
            if(!studentExerciseScoreDao.existsByExerciseIdAndStudentId(exercise.getExerciseId(),studentId))
                return null;
            scores.add(studentExerciseScoreDao.findByExerciseIdAndStudentId(exercise.getExerciseId(),studentId).getExerciseScore());
        }
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type3);
        for (Exercise exercise:exercises){
            scores.add(studentExerciseScoreDao.findByExerciseIdAndStudentId(exercise.getExerciseId(),studentId).getExerciseScore());
        }
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type2);
        for (Exercise exercise:exercises){
            if(studentExerciseScoreDao.findByExerciseIdAndStudentId(exercise.getExerciseId(),studentId).getCorrected()!=0)
                scores.add(studentExerciseScoreDao.findByExerciseIdAndStudentId(exercise.getExerciseId(),studentId).getExerciseScore());
        }
        return scores;
    }

    @Override
    @Transactional
    public List<List<String>> getPrecourse(String courseName){
        List<List<String>> preCourseSet=new ArrayList<>();
        if(!courseNameDao.existsByCourseName(courseName)){
            return null;
        }
        else {
            List<String> temp=getPrecouseName(courseName);
            List<String> temp1=new ArrayList<>();
            List<String> temp2=new ArrayList<>();
            preCourseSet.add(temp);
            for(String i:temp){
                temp1=getPrecouseName(i);
                for(String j:temp1){
                    if(!temp2.contains(j))
                        temp2.add(j);
                }
            }
            preCourseSet.add(temp2);
        }
        return preCourseSet;
    }

    @Override
    @Transactional
    public List<String> getPrecouseName(String courseName){
        if(!courseNameDao.existsByCourseName(courseName)){
            return null;
        }
        else {
            int couseId = courseNameDao.findByCourseName(courseName).getCourseNameID();
            List<CourseRelation> courseRelations = courseRelationDao.findByCourseNameID(couseId);
            return getCoursesName(courseRelations);
        }
    }

    @Override
    @Transactional
    public List<String> getCoursesName(List<CourseRelation> courseRelations){
        List<String> temp=new ArrayList<>();
        for(CourseRelation courseRelation:courseRelations){
            if(courseRelation.getPreCourseNameID()!=0)
                temp.add(courseNameDao.findByCourseNameID(courseRelation.getPreCourseNameID()).getCourseName());
        }
        return temp;
    }

    @Override
    @Transactional
    public boolean learnBad(int studentId,int courseId){
        List<ChapterNode> chapterNodes=chapterContentDao.findByCourseID(courseId);
        List<StudentChapter> studentChapters=studentChapterDao.findByChapterIDBetweenAndStudentIDOrderByChapterIDDesc(chapterNodes.get(0).getId(),chapterNodes.get(chapterNodes.size()-1).getId(),studentId);
        int chapterId1=0;
        int chapterId2=0;
        for(int i=0;i<studentChapters.size();i++){
            if(studentChapters.get(i).getComment()!=null){
                chapterId1=studentChapters.get(i).getChapterID();
                chapterId2=chapterId1;
                for(int j=i+1;j<studentChapters.size();j++){
                    if(studentChapters.get(j).getComment()!=null){
                        chapterId2=studentChapters.get(j).getChapterID();
                        break;
                    }
                }
                break;
            }
        }
        if(chapterId1==0)
            return false;
        List<StudentChapter> temp1=studentChapterDao.findByChapterID(chapterId1);
        List<Integer> scores1=new ArrayList<>();
        for(StudentChapter i:temp1){
            scores1.add(i.getTotalScore_2());
        }
        List<StudentChapter> temp2=studentChapterDao.findByChapterID(chapterId2);
        List<Integer> scores2=new ArrayList<>();
        for(StudentChapter i:temp2){
            scores2.add(i.getTotalScore_2());
        }
        Collections.sort(scores1);
        Collections.sort(scores2);
        if(scores1.get((int)(0.4*temp1.size()))>studentChapterDao.findByChapterIDAndStudentID(chapterId1,studentId).getTotalScore_2()&&scores2.get((int)(0.4*temp2.size()))>studentChapterDao.findByChapterIDAndStudentID(chapterId2,studentId).getTotalScore_2())
            return true;
        return false;
    }

    @Override
    @Transactional
    public String getCourseName(int courseId){
        return courseNameDao.findByCourseNameID(Integer.parseInt(courseInfoDao.findByCourseID(courseId).getCourseName())).getCourseName();
    }

    @Override
    @Transactional
    public Map<String,Float> userLabel(int studentId){
        List<Takes> takesList=takesDao.findByStudentID(studentId);
        List<List<Integer>> courseList=new ArrayList<>();
        List<Float> scores=new ArrayList<>();
        TypeMapper typeMapper=new TypeMapper();
        for(int i=0;i<4;i++){
            courseList.add(new ArrayList<>());
        }
        for(Takes takes:takesList){
            int temp=courseClassDao.findById(takes.getCourseClassID().intValue()).getCourseID();
            int anotherTemp=Integer.parseInt(courseInfoDao.findByCourseID(temp).getCourseName());
            if(typeMapper.getMapper().containsKey(anotherTemp)){
                courseList.get(typeMapper.getMapper().get(anotherTemp)-1).add(temp);
            }
        }
        for(int i=0;i<4;i++){
            if(courseList.get(i).isEmpty()){
                scores.add(-1.0f);
                continue;
            }
            List<Integer> chapterList=new ArrayList<>();
            for(Integer courseId:courseList.get(i)){
                List<ChapterNode> chapterNodes=chapterContentDao.findByCourseID(courseId);
                for(ChapterNode chapterNode:chapterNodes)
                    chapterList.add(chapterNode.getId());
            }
            float count=0;
            float total=0;
            for(Integer integer:chapterList){
                StudentChapter studentChapter=studentChapterDao.findByChapterIDAndStudentID(integer,studentId);
                if(studentChapter!=null&&studentChapter.getScored_2()!=null&&studentChapter.getScored_2()==1){
                    count++;
                    total+=100*studentChapter.getTotalScore_2()/chapterContentDao.findById(integer).get().getExerciseTotal_2();
                }
            }
            if(count==0)
                scores.add(-1.0f);
            else
                scores.add(total/count);
        }
        Map<String,Float> label=new HashMap<>();
        label.put("软件工程理论能力",scores.get(0));
        label.put("基本编程能力",scores.get(1));
        label.put("实践能力",scores.get(2));
        label.put("专业方向能力",scores.get(3));
        return label;
    }

    @Override
    @Transactional
    public List<CourseInfo> currentCourse(int year,String semester){
        return courseInfoDao.findByCourseYearAndCourseSemester(year,semester);
    }

    @Override
    @Transactional
    public List<UnratedChapter> getUnratedChapters(int classId){
        List<UserInfo> userInfos=courseService.getStudentsByClassID(classId);
        List<ChapterNode> chapterNodes=chapterContentDao.findByCourseID(courseClassDao.findById(classId).getCourseID());
        List<ChapterNode> chapterNodeList=new ArrayList<>();
        for(ChapterNode chapterNode:chapterNodes){
            if(chapterNode.getExerciseTitle()!=null)
                chapterNodeList.add(chapterNode);
        }
        List<UnratedChapter> unratedChapters=new ArrayList<>();
        for(ChapterNode chapterNode:chapterNodeList){
            for(UserInfo userInfo:userInfos){
                StudentChapter studentChapter=studentChapterDao.findByChapterIDAndStudentID(chapterNode.getId(),userInfo.getUserID());
                if(studentChapter!=null){
                    Integer temp=studentChapter.getScored_2();
                    if(temp!=null){
                        if(temp==0){
                            unratedChapters.add(new UnratedChapter(chapterNode,userInfo.getUserID()));
                            break;
                        }
                    }
                }
            }
        }
        return unratedChapters;
    }

    @Override
    @Transactional
    public  List<CourseAndClassList> currentCourseByTeacherId(int teacherId){
        Calendar calendar=Calendar.getInstance();
        int month = calendar.get(Calendar.MONTH) + 1;
        int year = calendar.get(Calendar.YEAR);
        if(month<=2)
            year--;
        String semester="";
        if(month>=3&&month<=8)
            semester="春季";
        else
            semester="秋季";
        List<CourseInfo> courseInfos=courseInfoDao.findByTeacherIDAndCourseYearAndCourseSemester(teacherId,year,semester);
        List<CourseAndClassList> courseAndClassLists=new ArrayList<>();
        for(CourseInfo courseInfo:courseInfos)
            courseAndClassLists.add(new CourseAndClassList(courseInfo,courseClassDao.findByCourseID(courseInfo.getCourseID()),courseNameDao.findByCourseNameID(Integer.parseInt(courseInfo.getCourseName())).getCourseName()));
        return courseAndClassLists;
    }

    @Override
    @Transactional
    public List<CourseAndClassList> currentCourseByStudentId(int studentId){
        Calendar calendar=Calendar.getInstance();
        int month = calendar.get(Calendar.MONTH) + 1;
        int year = calendar.get(Calendar.YEAR);
        if(month<=2)
            year--;
        String semester="";
        if(month>=3&&month<=8)
            semester="春季";
        else
            semester="秋季";
        List<Takes> takesList=takesDao.findByStudentID(studentId);
        List<CourseClass> courseClasses=new ArrayList<>();
        for(Takes takes:takesList)
            courseClasses.add(courseClassDao.findById(takes.getCourseClassID()).get());
        List<CourseAndClassList> courseAndClassLists=new ArrayList<>();
        for(CourseClass courseClass:courseClasses){
            CourseInfo courseInfo=courseInfoDao.findByCourseID(courseClass.getCourseID());
            if(courseInfo.getCourseYear().equals(year)&&courseInfo.getCourseSemester().equals(semester)){
                courseAndClassLists.add(new CourseAndClassList(courseInfo,courseClass,courseNameDao.findByCourseNameID(Integer.parseInt(courseInfo.getCourseName())).getCourseName()));
            }
        }
        return courseAndClassLists;
    }

    @Override
    @Transactional
    public void setTotalScore(int chapterId,String type){
        int type1=0;
        int type2=0;
        int type3=0;
        if(type.equals("preview")){
            type1=1;
            type3=2;
            type2=3;
        }
        else{
            type1=4;
            type3=5;
            type2=6;
        }
        List<Exercise> exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type1);
        List<Exercise> temp=new ArrayList<>();
        temp.addAll(exercises);
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type3);
        temp.addAll(exercises);
        exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type2);
        temp.addAll(exercises);
        int total=0;
        for(Exercise exercise:temp)
            total+=exercise.getExercisePoint();
        if(type.equals("preview")){
            ChapterNode chapterNode=chapterContentDao.findById(chapterId).get();
            chapterNode.setExerciseTotal_1(total);
            chapterContentDao.saveAndFlush(chapterNode);
        }
        else{
            ChapterNode chapterNode=chapterContentDao.findById(chapterId).get();
            chapterNode.setExerciseTotal_2(total);
            chapterContentDao.saveAndFlush(chapterNode);
        }
    }
}
