package org.lab409.dao;

import org.lab409.entity.StudentChapter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentChapterDao extends JpaRepository<StudentChapter,Integer>
{
    StudentChapter findByChapterIDAndStudentID(Integer chapterID,Integer studentID);
}
