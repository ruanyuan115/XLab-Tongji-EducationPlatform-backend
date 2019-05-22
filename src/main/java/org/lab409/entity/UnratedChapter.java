package org.lab409.entity;

import lombok.Data;

import java.util.List;
@Data
public class UnratedChapter {
    ChapterNode chapterNode;
    Integer studentId;

    public UnratedChapter() {
    }

    public UnratedChapter(ChapterNode chapterNode, Integer studentId) {
        this.chapterNode = chapterNode;
        this.studentId = studentId;
    }
}
