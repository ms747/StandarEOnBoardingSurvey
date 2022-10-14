package com.StandardE.Survey.service;

import com.StandardE.Survey.dto.SurveyQuestion;
import com.StandardE.Survey.model.SurveySchema;
import com.StandardE.Survey.repository.SurveyQuestionDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class createSurveySchema {

    @Autowired
    SurveyQuestionDaoImpl surveyQuestionDao;

    @Transactional
    public int createSchema(SurveySchema surveySchema){
        String schema_Name = surveySchema.getSchema_name();
        surveyQuestionDao.schemaEntry(schema_Name);
        int schema_id = surveyQuestionDao.getSchemaId();
        List<SurveyQuestion> surveyQuestions = surveySchema.getSurveyQuestions();
        for (SurveyQuestion surveyQuestion: surveyQuestions){
            surveyQuestionDao.questionEntry(surveyQuestion.getQuestion(), surveyQuestion.getChoices()); // Change choice to type
            int question_id = surveyQuestionDao.getQuestionId();
            if(surveyQuestion.getType().equals("single_select")){
                surveyQuestionDao.choiceEntry(surveyQuestion.getChoices());
            }
            int choice_id = surveyQuestionDao.getChoiceId();
            surveyQuestionDao.question_ChoiceEntry(question_id,choice_id);
            surveyQuestionDao.schema_questionEntry(schema_id, question_id);
        }
        return schema_id;
    }
}
