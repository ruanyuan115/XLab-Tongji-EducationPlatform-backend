package org.lab409.controller;
import org.lab409.dao.UserDao;
import org.lab409.entity.*;
import org.lab409.service.ExerciseService;
import org.lab409.security.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/question")
public class ExerciseController {
    @Autowired
    private UserDao userDao;
    @Autowired
    private ExerciseService exerciseService;
    @Value("${jwt.header}")
    private String tokenHeader;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private HttpServletRequest request;

    @GetMapping(value = "/findOneExercise")
    public ResultEntity findOneExercise(Integer exerciseId){
        return exerciseService.findOneExerice(exerciseId);
    }

    @PostMapping(value = "/addExercise")
    public ResultEntity addExercise(Exercise exercise){
        return exerciseService.addExercise(exercise);
    }

    @PutMapping(value = "/deleteExercise")
    public ResultEntity deleteExercise(Integer exerciseId){
        return exerciseService.deleteExercise(exerciseId);
    }

    @PostMapping(value = "/alterExercise")
    public ResultEntity alterExercise(Exercise exercise){
        return exerciseService.alterExercise(exercise);
    }

    @PostMapping(value = "/addChoice")
    public ResultEntity addChoice(ExerciseChoice exerciseChoice){
        return exerciseService.addExerciseChoice(exerciseChoice);
    }

    @PutMapping(value = "/deleteChoice")
    public ResultEntity deleteChoice(Integer exerciseChoiceId){
        return exerciseService.deleteExerciseChoice(exerciseChoiceId);
    }

    @PostMapping(value = "/alterChoice")
    public ResultEntity alterChoice(ExerciseChoice exerciseChoice){
        return exerciseService.alterExerciseChoice(exerciseChoice);
    }

    @GetMapping(value = "/findOneAnswer")
    public ResultEntity findOneAnswer(Integer exerciseId,Integer studentId){
        return exerciseService.findOneAnswer(exerciseId,studentId);
    }

    @GetMapping(value = "/findOneAnswerById")
    public ResultEntity findOneAnswerById(Integer studentExerciseScoreId){
        return exerciseService.findOneAnswerById(studentExerciseScoreId);
    }

    @PostMapping(value = "/addAnswer")
    public ResultEntity addAnswer(String answer,Integer exerciseId,Integer userId){
        return exerciseService.answerOne(answer,exerciseId,userId);
    }

    @PostMapping(value= "/answerAll")
    public ResultEntity answerAll(@RequestParam(value = "answers")List<String> answers, Integer studentId, Integer chapterId,String type, String comment,Integer rate) throws Exception{
        return exerciseService.answerAll(answers,studentId,chapterId,type,comment,rate);
    }

    @PutMapping(value = "/alterAnswer")
    public ResultEntity alterAnswer(String answer,Integer exerciseId,Integer studentId){
        return exerciseService.alterAnswer(answer,exerciseId,studentId);
    }

    @PutMapping(value = "/correctOne")
    public ResultEntity correctOne(Integer studentExerciseScoreId,Integer score){
        return exerciseService.correctOne(studentExerciseScoreId,score);
    }

    @PostMapping(value = "/correctAll")
    public ResultEntity correctAll(@RequestParam(value = "scores")List<Integer> scores, Integer studentId,Integer chapterId,String type){
        return exerciseService.correctAll(scores,studentId,chapterId,type);
    }

    @GetMapping(value = "/view")
    public ResultEntity viewExercise(Integer chapterId,String type){
        return exerciseService.viewExercise(chapterId,type);
    }

    @GetMapping(value = "/viewSomeAnswer")
    public ResultEntity viewSomeAnswer(Integer chapterId,Integer studentId,String type){
        return exerciseService.viewSomeAnswer(chapterId,studentId,type);
    }

    @GetMapping(value = "/getScore")
    public ResultEntity getScore(Integer chapterId,Integer studentId){
        ResultEntity resultEntity=new ResultEntity();
        if(chapterId!=null&&studentId!=null){
            resultEntity.setData(exerciseService.calculateScore(chapterId,studentId));
            resultEntity.setState(1);
            resultEntity.setMessage("查看成功！");
        }
        else{
            resultEntity.setMessage("有输入为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @GetMapping(value = "/rateNumber")
    public ResultEntity rateNumber(Integer chapterId){
        return exerciseService.rateNumber(chapterId);
    }

    @GetMapping(value = "/sameCoursesByName")
    public ResultEntity sameCoursesByName(String courseName,Integer teacherId){
        ResultEntity resultEntity=new ResultEntity();
        if(courseName!=null&&teacherId!=null){
           List<CourseInfo> courseInfos=exerciseService.findCourses(courseName,teacherId);
           if(courseInfos.isEmpty()){
               resultEntity.setMessage("未找到对应课程！");
               resultEntity.setState(0);
           }
           else{
               resultEntity.setData(courseInfos);
               resultEntity.setState(1);
           }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @GetMapping(value = "/sameCoursesById")
    public ResultEntity sameCoursesById(Integer courseId,Integer teacherId){
        ResultEntity resultEntity=new ResultEntity();
        if(courseId!=null&&teacherId!=null){
            List<CourseInfo> courseInfos=exerciseService.findCoursesById(courseId,teacherId);
            if(courseInfos.isEmpty()){
                resultEntity.setMessage("未找到对应课程！");
                resultEntity.setState(0);
            }
            else{
                resultEntity.setData(courseInfos);
                resultEntity.setState(1);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @PostMapping(value = "/copyNodes")
    public ResultEntity copyNodes(Integer sourceCourseId,Integer aimCourseId){
        ResultEntity resultEntity=new ResultEntity();
        if(sourceCourseId!=null&&aimCourseId!=null){
            List<ChapterNode> chapterNodes=exerciseService.copyChapter(sourceCourseId,aimCourseId);
            if(chapterNodes.isEmpty()){
                resultEntity.setMessage("没有要拷贝的章节！");
                resultEntity.setState(0);
            }
            else {
                resultEntity.setData(chapterNodes);
                resultEntity.setState(1);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数不全！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @PostMapping(value = "/copyExercise")
    public ResultEntity copyExercise(Integer sourceChapterId,Integer aimChapterId,String type){
        ResultEntity resultEntity=new ResultEntity();
        if(sourceChapterId!=null&&aimChapterId!=null&&type!=null){
            exerciseService.copyExercise(sourceChapterId,aimChapterId,type);
            resultEntity.setMessage("复制习题成功！");
            resultEntity.setState(1);
        }
        else
        {
            resultEntity.setMessage("传入参数不全！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @GetMapping(value="/exerciseScore")
    public ResultEntity exerciseScore(Integer studentId,Integer chapterId,String type){
        ResultEntity resultEntity=new ResultEntity();
        if(studentId!=null&&chapterId!=null&&type!=null){
            List<Integer> temp=exerciseService.exerciseScore(studentId,chapterId,type);
            if(temp!=null){
                resultEntity.setData(temp);
                resultEntity.setState(1);
            }
            else{
                resultEntity.setMessage("学生未答题");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数不全！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @GetMapping(value = "/getPrecourse")
    public ResultEntity getPrecourse(Integer courseId,Integer studentId){
        ResultEntity resultEntity=new ResultEntity();
        if(courseId!=null&&studentId!=null){
            if(exerciseService.learnBad(studentId,courseId)){
                List<List<String>> temp=exerciseService.getPrecourse(exerciseService.getCourseName(courseId));
                if(temp!=null)
                {
                    resultEntity.setData(temp);
                    resultEntity.setState(1);
                    resultEntity.setMessage("你需要学习一些前置课程");
                }
                else
                {
                    resultEntity.setMessage("未找到对应课程！");
                    resultEntity.setState(0);
                }
            }
            else{
                resultEntity.setMessage("你此课程最近学习状况尚可！");
                resultEntity.setState(1);
            }

        }
        else
        {
            resultEntity.setMessage("传入参数不全！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @GetMapping(value = "/userLabel")
    public ResultEntity userLabel(Integer studentId){
        ResultEntity resultEntity=new ResultEntity();
        if(studentId!=null){
            resultEntity.setState(1);
            resultEntity.setData(exerciseService.userLabel(studentId));
        }
        else
        {
            resultEntity.setMessage("传入参数不全！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @GetMapping(value = "/currentCourse")
    public ResultEntity currentCourse(Integer year,String semester){
        ResultEntity resultEntity=new ResultEntity();
        if(year!=null&&semester!=null){
            List<CourseInfo> courseInfos=exerciseService.currentCourse(year,semester);
            if (!courseInfos.isEmpty()){
                resultEntity.setState(1);
                resultEntity.setData(courseInfos);
            }
            else{
                resultEntity.setState(0);
                resultEntity.setMessage("未找到相应课程");
            }
        }
        else
        {
            resultEntity.setMessage("传入参数不全！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
}
