package org.lab409.dao;

import org.lab409.entity.CourseInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseInfoDao extends JpaRepository<CourseInfo,Integer>
{
    CourseInfo findByCourseID(Integer courseID);
}
