package org.lab409.entity;

import lombok.Data;

import java.util.ArrayList;

@Data
public class CourseCatalog
{
    private ChapterNode chapterNode;
    private ArrayList<CourseCatalog>subCatalog;
    public CourseCatalog()
    {
        chapterNode=new ChapterNode();
        subCatalog=new ArrayList<>();
    }
}
