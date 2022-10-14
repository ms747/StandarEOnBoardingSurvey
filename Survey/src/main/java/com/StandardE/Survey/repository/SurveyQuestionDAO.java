package com.StandardE.Survey.repository;

import com.StandardE.Survey.dto.SurveyQuestion;

import java.util.List;

public interface SurveyQuestionDAO {
    List<SurveyQuestion> getQuestionsBySchemaId(int id);
    int createTable();
    void schemaEntry(String schemaName);
    int getSchemaId();
    void questionEntry(String question, List<String> choices);
    int getQuestionId();
    void choiceEntry(List<String> choices);
    int getChoiceId();
    void question_ChoiceEntry(int question_id, int choice_id);
    void schema_questionEntry(int schema_id, int question_id);

}
