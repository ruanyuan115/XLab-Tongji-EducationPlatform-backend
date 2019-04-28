package org.lab409.entity;

import lombok.Data;

@Data
public class StudentChapterEntity
{
    private StudentChapter studentChapter;
    private String chapterName;
    public StudentChapterEntity(StudentChapter studentChapter,String chapterName)
    {
        this.studentChapter=studentChapter;
        this.chapterName=chapterName;
    }
}
