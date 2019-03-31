package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "course_notice")
@DynamicInsert
@EntityListeners(AuditingEntityListener.class)
@Data
public class CourseNotice
{
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @CreatedDate
    @Column(name = "create_time")
    private Timestamp createTime;
    @LastModifiedDate
    @Column(name = "update_time")
    private Timestamp updateTime;
    @Column(name = "course_id")
    private Integer courseID;
    @Column(name = "course_notice")
    private String courseNotice;
}
