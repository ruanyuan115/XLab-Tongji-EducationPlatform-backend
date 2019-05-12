package org.lab409.dao;

import org.lab409.entity.CourseRelation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface CourseRelationDao extends JpaRepository<CourseRelation,Integer>
{
    CourseRelation findByCourseNameIDAndPreCourseNameID(Integer courseNameID,Integer preCourseNameID);
    ArrayList<CourseRelation> findByPreCourseNameID(Integer preCourseNameID);
    List<CourseRelation> findByCourseNameID(Integer courseID);
}
