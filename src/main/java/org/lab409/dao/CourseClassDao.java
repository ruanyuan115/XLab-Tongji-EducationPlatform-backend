package org.lab409.dao;

import org.lab409.entity.CourseClass;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface CourseClassDao extends JpaRepository<CourseClass,Integer>
{
    CourseClass findById(int id);
    CourseClass findByClassCode(String classCode);
    ArrayList<CourseClass>findByCourseID(Integer courseID);
    CourseClass findByCourseIDAndClassNum(Integer courseID,Integer classNum);
}
