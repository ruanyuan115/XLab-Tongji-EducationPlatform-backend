package org.lab409.dao;

import org.lab409.entity.CourseNotice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseNoticeDao extends JpaRepository<CourseNotice,Integer>
{
    CourseNotice findByCourseID(Integer courseID);
    void deleteByCourseID(Integer courseID);
}
