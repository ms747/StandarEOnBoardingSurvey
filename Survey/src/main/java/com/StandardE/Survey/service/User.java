package com.StandardE.Survey.service;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class User {

    private int id;
    private String name;
    private int age;
    private String city;
}
