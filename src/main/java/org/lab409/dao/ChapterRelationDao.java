package org.lab409.dao;

import org.lab409.entity.ChapterRelation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface ChapterRelationDao extends JpaRepository<ChapterRelation,Integer>
{
    ChapterRelation findByChapterIDAndPreChapterID(Integer chapterID,Integer preChapterID);
    List<ChapterRelation>findByChapterID(Integer chapterID);
    ArrayList<ChapterRelation>findByPreChapterID(Integer preChapterID);
}
