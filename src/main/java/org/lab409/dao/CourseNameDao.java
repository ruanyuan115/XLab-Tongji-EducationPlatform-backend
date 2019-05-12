package org.lab409.dao;

import org.lab409.entity.CourseName;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseNameDao extends JpaRepository<CourseName,Integer>
{
    CourseName getByCourseName(String courseName);
    boolean existsByCourseName(String courseName);
    CourseName findByCourseName(String courseName);
    CourseName findByCourseNameID(int courseNameID);
}
