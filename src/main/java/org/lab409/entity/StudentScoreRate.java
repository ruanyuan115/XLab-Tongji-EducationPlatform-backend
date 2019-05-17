package org.lab409.entity;

import lombok.Data;

@Data
public class StudentScoreRate {
    private Integer studentID;
    private Integer totalScore_1;
    private Integer totalScore_2;
    private Integer rate;
}
