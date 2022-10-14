package com.StandardE.Survey.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SurveyQuestion {

    private String question;
    private String type;
    private List<String> choices;
}
