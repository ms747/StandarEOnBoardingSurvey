package com.StandardE.Survey.repository;

import com.StandardE.Survey.entity.SurveyQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public interface SurveyQuestionRepository extends JpaRepository<SurveyQuestion, Integer> {
    SurveyQuestion findByQuestion(String question);
}
