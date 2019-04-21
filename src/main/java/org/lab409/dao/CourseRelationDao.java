package org.lab409.dao;

import org.lab409.entity.CourseRelation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseRelationDao extends JpaRepository<CourseRelation,Integer>
{
    CourseRelation findByCourseNameIDAndPreCourseNameID(Integer courseNameID,Integer preCourseNameID);
}
