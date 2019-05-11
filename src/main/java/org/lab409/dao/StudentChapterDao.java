package org.lab409.dao;

import org.springframework.data.repository.query.Param;
import org.lab409.entity.StudentChapter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface StudentChapterDao extends JpaRepository<StudentChapter,Integer>
{
    StudentChapter findByChapterIDAndStudentID(Integer chapterID,Integer studentID);
    ArrayList<StudentChapter>findByChapterID(Integer chapterID);
    Integer countByChapterIDAndRate(Integer chapterID,Integer rate);
    @Query(value = "select nlp_rate from student_chapter where chapter_id=:chapterID and student_id=:studentID",nativeQuery=true)
    String getNLPRateByChapterIDAndStudentID(@Param("chapterID") Integer chapterID,@Param("studentID") Integer studentID);
}
