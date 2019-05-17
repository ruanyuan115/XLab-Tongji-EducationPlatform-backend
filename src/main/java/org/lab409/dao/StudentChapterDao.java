package org.lab409.dao;

import org.lab409.entity.StudentScoreRate;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.lab409.entity.StudentChapter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public interface StudentChapterDao extends JpaRepository<StudentChapter,Integer>
{
    StudentChapter findByChapterIDAndStudentID(Integer chapterID,Integer studentID);
    ArrayList<StudentChapter>findByChapterID(Integer chapterID);
    Integer countByChapterIDAndRate(Integer chapterID,Integer rate);
    @Query(value = "select nlp_rate from student_chapter where chapter_id=:chapterID and student_id=:studentID",nativeQuery=true)
    String getNLPRateByChapterIDAndStudentID(@Param("chapterID") Integer chapterID,@Param("studentID") Integer studentID);
    @Modifying
    @Transactional
    @Query(value = "update student_chapter set nlp_rate=:nlpRate where chapter_id=:chapterID and student_id=:studentID",nativeQuery=true)
    Integer setNLPRateByChapterIDAndStudentID(@Param("nlpRate") String nlpRate,@Param("chapterID") Integer chapterID,@Param("studentID") Integer studentID);
}
