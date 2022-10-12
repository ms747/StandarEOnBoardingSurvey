package com.StandardE.Survey.service;

import com.StandardE.Survey.entity.SurveyQuestion;
import com.StandardE.Survey.repository.SurveyQuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionService {

    @Autowired
    private SurveyQuestionRepository surveyQuestionRepository;

    public SurveyQuestion saveQuestion(SurveyQuestion surveyQuestion){
        return surveyQuestionRepository.save(surveyQuestion);
    }

    public List<SurveyQuestion> saveQuestions(List<SurveyQuestion> surveyQuestions){
        return surveyQuestionRepository.saveAll(surveyQuestions);
    }

    public List<SurveyQuestion> getQuestion(){
        return surveyQuestionRepository.findAll();
    }

    public SurveyQuestion getQuestionById(int id){
        return surveyQuestionRepository.findById(id).orElse(null);
    }

    public SurveyQuestion getQuestionByName(String question){
        return surveyQuestionRepository.findByQuestion(question);
    }


}
