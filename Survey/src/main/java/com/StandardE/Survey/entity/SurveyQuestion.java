package com.StandardE.Survey.entity;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "SURVEY_QUESTION")
public class SurveyQuestion {

    @Id
    @GeneratedValue
    private int id;
    private String question;
}
