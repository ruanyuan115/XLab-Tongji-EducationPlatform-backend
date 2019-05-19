package org.lab409.service.implement;
import org.lab409.dao.*;
import org.lab409.entity.*;
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
        if(answers!=null&&rate!=null&&chapterId!=null&&studentId!=null){
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
                    if(chapterContentDao.findById(chapterId).get().getExerciseVisible_1())
                    {
                        Timestamp now = new Timestamp(new Date().getTime());
                        if(chapterContentDao.findById(chapterId).get().getExerciseDeadline_1()!=null&&now.before(chapterContentDao.findById(chapterId).get().getExerciseDeadline_1())){
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
                        if(now.before(chapterContentDao.findById(chapterId).get().getExerciseDeadline_2())){
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
            resultEntity.setData(exerciseSets);
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
                if(i+1>=studentChapters.size())
                    chapterId2=chapterId1;
                else
                    chapterId2=studentChapters.get(i+1).getChapterID();
            }
        }
        if(chapterId1==0)
            return true;
        List<StudentChapter> temp=studentChapterDao.findByChapterID(chapterId1);
        List<Integer> scores1=new ArrayList<>();
        for(StudentChapter i:temp){
            scores1.add(i.getTotalScore_2());
        }
        temp=studentChapterDao.findByChapterID(chapterId2);
        List<Integer> scores2=new ArrayList<>();
        for(StudentChapter i:temp){
            scores2.add(i.getTotalScore_2());
        }
        Collections.sort(scores1);
        Collections.sort(scores2);
        if(scores1.get((int)(0.4*studentChapterDao.countByChapterID(chapterId1)))>studentChapterDao.findByChapterIDAndStudentID(chapterId1,studentId).getTotalScore_2()&&scores2.get((int)(0.4*studentChapterDao.countByChapterID(chapterId2)))>studentChapterDao.findByChapterIDAndStudentID(chapterId2,studentId).getTotalScore_2())
            return true;
        return false;
    }

    @Override
    @Transactional
    public String getCourseName(int courseId){
        return courseNameDao.findByCourseNameID(Integer.parseInt(courseInfoDao.findByCourseID(courseId).getCourseName())).getCourseName();
    }
}
