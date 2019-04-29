package org.lab409.controller;
import org.lab409.dao.UserDao;
import org.lab409.entity.ResultEntity;
import org.lab409.entity.Exercise;
import org.lab409.entity.ExerciseChoice;
import org.lab409.entity.StudentExerciseScore;
import org.lab409.service.ExerciseService;
import org.lab409.security.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
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
    public ResultEntity answerAll(@RequestParam(value = "answers")List<String> answers, Integer studentId, Integer chapterId,String type, String comment,Integer rate){
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
}
