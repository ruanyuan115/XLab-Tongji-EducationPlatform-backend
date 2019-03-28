package org.lab409.dao;

import org.lab409.entity.Takes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TakesDao extends JpaRepository<Takes,Integer>
{
    List<Takes>findByStudentID(Integer studentID);
    Takes findByStudentIDAndCourseID(Integer studentID,Integer courseID);
}
