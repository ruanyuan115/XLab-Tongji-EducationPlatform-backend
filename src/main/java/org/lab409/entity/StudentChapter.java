package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "student_chapter")
@DynamicInsert
@EntityListeners(AuditingEntityListener.class)
@Data
public class StudentChapter
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
    @Column(name = "chapter_id")
    private Integer chapterID;
    @Column(name = "scored_1")
    private Integer scored_1;
    @Column(name = "scored_2")
    private Integer scored_2;
    @Column(name = "total_score_1")
    private Integer totalScore_1;
    @Column(name = "total_score_2")
    private Integer totalScore_2;
    @Column(name = "comment")
    private String comment;
    @Column(name = "rate")
    private Integer rate;

}
