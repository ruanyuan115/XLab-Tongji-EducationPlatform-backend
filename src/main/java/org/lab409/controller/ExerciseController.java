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

import javax.servlet.http.HttpServletRequest;
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

    @PostMapping(value = "/addExercise")
    public ResultEntity addExercise(Exercise exercise){
        return exerciseService.addExercise(exercise);
    }

    @PostMapping(value = "/addChoice")
    public ResultEntity addChoice(ExerciseChoice exerciseChoice){
        return exerciseService.addExerciseChoice(exerciseChoice);
    }

    @PostMapping(value = "/addAnswer")
    public ResultEntity addAnswer(String answer,Integer exerciseId,Integer userId){
        return exerciseService.answerOne(answer,exerciseId,userId);
    }

    @PutMapping(value = "/correctOne")
    public ResultEntity correctOne(Integer studentExerciseScoreId,Integer score){
        return exerciseService.correctOne(studentExerciseScoreId,score);
    }

    @GetMapping(value = "/view")
    public ResultEntity viewExercise(Integer chapterId,String type){
        return exerciseService.viewExercise(chapterId,type);
    }
}
