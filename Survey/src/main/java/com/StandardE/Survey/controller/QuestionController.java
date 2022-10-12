package com.StandardE.Survey.controller;

import com.StandardE.Survey.entity.SurveyQuestion;
import com.StandardE.Survey.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Component
public class QuestionController {

    @Autowired
    private QuestionService questionService;

    @PostMapping("/saveQuestion")
    public SurveyQuestion addQuestion(@RequestBody SurveyQuestion surveyQuestion){
        return questionService.saveQuestion(surveyQuestion);
    }

    @PostMapping("/saveQuestions")
    public List<SurveyQuestion> addQuestions(@RequestBody List<SurveyQuestion> surveyQuestions){
        return questionService.saveQuestions(surveyQuestions);
    }

    @GetMapping("/questions")
    public List<SurveyQuestion> findAllQuestions(){
        return questionService.getQuestion();
    }

    @GetMapping("/question/{id}")
    public SurveyQuestion getQuestionById(@PathVariable int id){
        return questionService.getQuestionById(id);
    }


}
