package com.StandardE.Survey.controller;

import com.StandardE.Survey.dto.SurveyQuestion;
import com.StandardE.Survey.repository.SurveyQuestionDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RestController
@Component
public class QuestionController {


    @Autowired
    private SurveyQuestionDaoImpl surveyQuestionDao;


//    public void getQuestionsBySchemaId(int id){
//        List<SurveyQuestion> surveyQuestion = surveyQuestionDao.getQuestionsBySchemaId(1);
//        System.out.println(Arrays.asList(surveyQuestion));
//    }




}
