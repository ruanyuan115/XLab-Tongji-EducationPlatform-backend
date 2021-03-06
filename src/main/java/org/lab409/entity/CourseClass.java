package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "course_class")
@DynamicInsert
@Data
@EntityListeners(AuditingEntityListener.class)
public class CourseClass
{
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "create_time")
    @CreatedDate
    private Timestamp createTime;
    @Column(name = "update_time")
    @LastModifiedDate
    private Timestamp updateTime;
    @Column(name = "course_id")
    private Integer courseID;
    @Column(name = "class_num")
    private Integer classNum;
    @Column(name = "class_code")
    private String classCode;
    @Column(name = "current_exercise")
    private Integer currentExerciseChapter;
}
