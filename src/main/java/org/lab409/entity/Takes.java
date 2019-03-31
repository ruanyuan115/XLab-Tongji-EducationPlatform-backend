package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "takes")
@DynamicInsert
@Data
public class Takes
{
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "create_time")
    private Timestamp createTime;
    @Column(name = "update_time")
    private Timestamp updateTime;
    @Column(name = "student_id")
    private Integer studentID;
    @Column(name = "course_id")
    private Integer courseID;
    @Column(name = "current_progress")
    private Integer currentProgress;
}