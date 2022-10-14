package com.StandardE.Survey.repository;

import com.StandardE.Survey.dto.SurveyQuestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SurveyQuestionDaoImpl implements SurveyQuestionDAO{

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public List<SurveyQuestion> getQuestionsBySchemaId(int id) {
        return jdbcTemplate.query("SELECT question_id, question.question, question.type" +
                " FROM survey.schema_question INNER JOIN survey.question ON (schema_question.question_id = question.id)" +
                " WHERE schema_question.schema_id = ?", new BeanPropertyRowMapper<>(SurveyQuestion.class),id);
    }

    @Override
    public int createTable() {
        int update = jdbcTemplate.update("CREATE TABLE IF NOT EXISTS User(id int primary key, name varchar(200), age int, city varchar(100))");
        return update;
    }

    @Override
    public void schemaEntry(String schemaName) {
        jdbcTemplate.update("INSERT INTO survey.schema (name) VALUES (?)",schemaName);
    }

    // Need to change the way to fetch id
    @Override
    public int getSchemaId(){
        return jdbcTemplate.queryForObject("SELECT MAX( schema_id ) FROM survey.schema",Integer.class);
    }

    @Override
    public void questionEntry(String question, List<String> choices){
            jdbcTemplate.update("INSERT INTO survey.question (question, type) VALUES (?, ?)", question, choices);
    }

    @Override
    public int getQuestionId(){
        return jdbcTemplate.queryForObject("SELECT MAX( question_id ) FROM survey.question",Integer.class);
    }

    @Override
    public void choiceEntry(List<String> choices){
        jdbcTemplate.update("INSERT INTO survey.choice (choice) VALUES (?)",choices);
    }

    @Override
    public int getChoiceId(){
        return jdbcTemplate.queryForObject("SELECT MAX( choice_id ) FROM survey.choice",Integer.class);
    }

    @Override
    public void question_ChoiceEntry(int question_id, int choice_id){
        jdbcTemplate.update("INSERT INTO survey.question_choice (question_id, choice_id) VALUES (?, ?)",question_id,choice_id);
    }

    @Override
    public void schema_questionEntry(int schema_id, int question_id){
        jdbcTemplate.update("INSERT INTO survey.schema_question (schema_id, question_id) VALUES (?, ?)",schema_id,question_id);
    }

}
