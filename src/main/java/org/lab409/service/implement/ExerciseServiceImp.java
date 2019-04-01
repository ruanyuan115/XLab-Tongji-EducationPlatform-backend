package org.lab409.service.implement;
import org.lab409.dao.ExerciseDao;
import org.lab409.dao.ExerciseChoiceDao;
import org.lab409.dao.StudentExerciseScoreDao;
import org.lab409.entity.ResultEntity;
import org.lab409.entity.Exercise;
import org.lab409.entity.ExerciseChoice;
import org.lab409.entity.StudentExerciseScore;
import org.lab409.entity.ExerciseSet;
import org.lab409.service.ExerciseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public ResultEntity answerOne(String answer,Integer exerciseId,Integer studentId){
        ResultEntity resultEntity=new ResultEntity();
        StudentExerciseScore studentExerciseScore=new StudentExerciseScore(studentId,exerciseId,answer,0);
        Exercise exercise=exerciseDao.findByExerciseId(exerciseId);
        if(studentExerciseScore!=null){
            if(exercise.getExerciseType()%2!=0){
                if(answer==exercise.getExerciseAnswer())
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
    public ResultEntity viewExercise(Integer chapterId,String type){
        ResultEntity resultEntity=new ResultEntity();
        if(chapterId!=null){
            List<ExerciseSet> exerciseSets=new ArrayList<>();
            int type1=0;
            int type2=0;
            if(type=="preview"){
                type1=1;
                type2=2;
            }
            else{
                type1=3;
                type2=4;
            }
            List<Exercise> exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type1);
            for (Exercise exercise:exercises){
                exerciseSets.add(new ExerciseSet(exercise,exerciseChoiceDao.findByExerciseIdOrderByExerciceChoiceId(exercise.getExerciseId())));
            }
            exercises=exerciseDao.findByChapterIdAndExerciseTypeOrderByExerciseNumber(chapterId,type2);
            for (Exercise exercise:exercises){
                exerciseSets.add(new ExerciseSet(exercise));
            }
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
}
