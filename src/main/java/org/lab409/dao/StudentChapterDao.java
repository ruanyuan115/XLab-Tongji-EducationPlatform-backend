package org.lab409.dao;

import org.lab409.entity.StudentChapter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface StudentChapterDao extends JpaRepository<StudentChapter,Integer>
{
    StudentChapter findByChapterIDAndStudentID(Integer chapterID,Integer studentID);
    ArrayList<StudentChapter>findByChapterID(Integer chapterID);
}
