package org.lab409.dao;

import org.lab409.entity.ChapterNode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface ChapterContentDao extends JpaRepository<ChapterNode,Integer>
{
    ArrayList<ChapterNode> findByCourseID(Integer chapterID);
    ArrayList<ChapterNode> findByCourseIDAndParentID(Integer courseID,Integer parentID);
}
