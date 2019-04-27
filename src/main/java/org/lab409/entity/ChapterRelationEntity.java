package org.lab409.entity;

import lombok.Data;

import java.util.ArrayList;

@Data
public class ChapterRelationEntity
{
    private ChapterNode chapterNode;
    private ArrayList<ChapterNode> preChapterNodes;
    private ArrayList<ChapterNode>subChapterNodes;
    public ChapterRelationEntity(ChapterNode chapterNode,ArrayList<ChapterNode>preChapterNodes,ArrayList<ChapterNode>subChapterNodes)
    {
        this.chapterNode=chapterNode;
        this.preChapterNodes=preChapterNodes;
        this.subChapterNodes=subChapterNodes;
    }
}
