package com.StandardE.Survey.model;

import com.StandardE.Survey.dto.SurveyQuestion;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class SurveySchema {
    private String schema_name;
    private List<SurveyQuestion> surveyQuestions;
}
