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
@Table(name = "course_info")
@DynamicInsert
@Data
@EntityListeners(AuditingEntityListener.class)
public class CourseInfo implements Cloneable
{
    @Id
    @Column(name = "course_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer courseID;
    @Column(name = "create_time")
    @CreatedDate
    private Timestamp createTime;
    @Column(name = "update_time")
    @LastModifiedDate
    private Timestamp updateTime;
    @Column(name = "teacher_id")
    private Integer teacherID;
    @Column(name = "course_name")
    private String courseName;
    @Column(name = "course_teacher")
    private String teacherName;
    @Column(name = "course_year")
    private Integer courseYear;
    @Column(name = "course_semester")
    private String courseSemester;
    @Column(name = "start_time")
    private Date startTime;
    @Column(name = "end_time")
    private Date endTime;

    public CourseInfo clone()throws CloneNotSupportedException
    {
        CourseInfo o =null;
        try
        {
            o=(CourseInfo)super.clone();
        }
        catch (CloneNotSupportedException e)
        {
            e.printStackTrace();
        }
        return o;

    }
}
