package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "takes")
@DynamicInsert
@EntityListeners(AuditingEntityListener.class)
@Data
public class Takes
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
    @Column(name = "student_id")
    private Integer studentID;
    @Column(name = "course_class_id")
    private Integer courseClassID;
    @Column(name = "current_progress")
    private Integer currentProgress;
    @Column(name = "comment")
    private String comment;
    @Column(name = "rate")
    private Integer rate;
}
