package org.lab409.entity;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
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
    @Column(name = "exercise_visible")
    private Boolean exerciseVisible;
    @Column(name = "exercise_deadline")
    private Date exerciseDeadline;
}
