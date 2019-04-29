package org.lab409.service.implement;
import org.lab409.dao.ExerciseDao;
import org.lab409.dao.ExerciseChoiceDao;
import org.lab409.dao.StudentChapterDao;
import org.lab409.dao.StudentExerciseScoreDao;
import org.lab409.entity.*;
import org.lab409.service.ExerciseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

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
        Exercise exercise=exerciseDao.findByExerciseId(exerciseId);
        if(studentExerciseScore!=null){
            if(exercise.getExerciseType()%3!=0){
                if(answer.equals(exercise.getExerciseAnswer()))
                    studentExerciseScore.setExerciseScore(exercise.getExercisePoint());
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
    public ResultEntity answerAll(List<String> answers, Integer studentId, Integer chapterId,String type, String comment,Integer rate){
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
            int count=0;
            for(String answer:answers){
                answerOne(answer,exerciseSets.get(count).getExercise().getExerciseId(),studentId);
                count++;
            }
            StudentChapter studentChapter;
            if(type.equals("preview")){
                studentChapter=new StudentChapter();
                studentChapter.setChapterID(chapterId);
                studentChapter.setStudentID(studentId);
            }
            else{
                studentChapter=studentChapterDao.findByChapterIDAndStudentID(chapterId,studentId);
                studentChapter.setRate(rate);
                studentChapter.setComment(comment);
            }
            studentChapterDao.saveAndFlush(studentChapter);
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
                studentChapterDao.saveAndFlush(studentChapter);
            }
            else {
                StudentChapter studentChapter=studentChapterDao.findByChapterIDAndStudentID(chapterId,studentId);
                studentChapter.setTotalScore_2(score);
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
}
