package org.lab409.entity;

import lombok.Data;

import java.util.ArrayList;

@Data
public class StudyInfo
{
    private Takes takes;
    private ArrayList<StudentChapter> studentChapters;
    public StudyInfo(){}
    public StudyInfo(Takes takes)
    {
        this.takes.setCurrentProgress(takes.getCurrentProgress());
    }
}
