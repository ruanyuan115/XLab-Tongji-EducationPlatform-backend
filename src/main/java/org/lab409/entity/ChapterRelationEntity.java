package org.lab409.entity;

import lombok.Data;

import java.util.ArrayList;

@Data
public class ChapterRelationEntity
{
    private ChapterNode chapterNode;
    private ArrayList<ChapterNode> preChapterNodes;
    public ChapterRelationEntity(ChapterNode chapterNode,ArrayList<ChapterNode>preChapterNodes)
    {
        this.chapterNode=chapterNode;
        this.preChapterNodes=preChapterNodes;
    }
}
