package org.lab409.entity;

import lombok.Data;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

@Data
public class CourseCatalog
{
    private Integer id;
    private Timestamp createTime;
    private Timestamp updateTime;
    private Integer courseID;
    private String contentName;
    private Integer parentID;
    private Integer siblingID;
    private String content;
    private Boolean exerciseVisible_1;
    private Boolean exerciseVisible_2;
    private Date exerciseDeadline_1;
    private Date exerciseDeadline_2;
    private Integer exerciseTotal_1;
    private Integer exerciseTotal_2;
    private ArrayList<CourseCatalog>subCatalog;
    public CourseCatalog()
    {
        subCatalog=new ArrayList<>();
    }
    public void setChapterNode(ChapterNode chapterNode)
    {
        this.id=chapterNode.getId();
        this.createTime=chapterNode.getCreateTime();
        this.updateTime=chapterNode.getUpdateTime();
        this.courseID=chapterNode.getCourseID();
        this.contentName=chapterNode.getContentName();
        this.parentID=chapterNode.getParentID();
        this.siblingID=chapterNode.getSiblingID();
        this.content=chapterNode.getContent();
        this.exerciseVisible_1=chapterNode.getExerciseVisible_1();
        this.exerciseVisible_2=chapterNode.getExerciseVisible_2();
        this.exerciseDeadline_1=chapterNode.getExerciseDeadline_1();
        this.exerciseDeadline_2=chapterNode.getExerciseDeadline_2();
        this.exerciseTotal_1=chapterNode.getExerciseTotal_1();
        this.exerciseTotal_2=chapterNode.getExerciseTotal_2();
    }

}
