package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;

@Entity
@Table(name = "chapter_content")
@DynamicInsert
@Data
@EntityListeners(AuditingEntityListener.class)
public class ChapterNode
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
    @Column(name = "content_name")
    private String contentName;
    @Column(name = "parent_id")
    private Integer parentID;
    @Column(name = "sibling_id")
    private Integer siblingID;
    @Column(name = "content")
    private String content;
    @Column(name = "exercise_title")
    private String exerciseTitle;
    @Column(name = "exercise_visible_1")
    private Boolean exerciseVisible_1;
    @Column(name = "exercise_visible_2")
    private Boolean exerciseVisible_2;
    @Column(name = "exercise_deadline_1")
    private Date exerciseDeadline_1;
    @Column(name = "exercise_deadline_2")
    private Date exerciseDeadline_2;
    @Column(name = "exercise_total_1")
    private Integer exerciseTotal_1;
    @Column(name = "exercise_total_2")
    private Integer exerciseTotal_2;
}
