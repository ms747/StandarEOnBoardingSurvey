package com.StandardE.Survey;

import com.StandardE.Survey.repository.SurveyQuestionDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootApplication
public class SurveyApplication implements CommandLineRunner {

	@Autowired
	private SurveyQuestionDaoImpl surveyQuestionDao;

	@Autowired
	JdbcTemplate jdbcTemplate;

	//GeneratedKeyHolder generatedKeyHolder = new GeneratedKeyHolder();


	public static void main(String[] args) {
		SpringApplication.run(SurveyApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
			this.jdbcTemplate.update("INSERT INTO tejan.persons (FirstName,LastName,Age) VALUES (?,?,?)","tt","gg",23);
			int id = this.jdbcTemplate.queryForObject("SELECT MAX( Personid ) FROM persons",Integer.class);
			System.out.println(id);
			//System.out.println("Schema entry id "+ id);
	}
}
