package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "course_relation")
@DynamicInsert
@EntityListeners(AuditingEntityListener.class)
@Data
public class CourseRelation
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
    @Column(name="course_name_id")
    private int courseNameID;
    @Column(name = "pre_course_name_id")
    private int preCourseNameID;
}
