package org.lab409.dao;

import org.lab409.entity.CourseInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface CourseInfoDao extends JpaRepository<CourseInfo,Integer>
{
    CourseInfo findByCourseID(Integer courseID);
    ArrayList<CourseInfo>findByTeacherID(Integer teacherID);
    ArrayList<CourseInfo>findByCourseName(String nameID);
    ArrayList<CourseInfo>findByCourseSemester(String semester);
    ArrayList<CourseInfo>findByCourseYear(Integer year);
    ArrayList<CourseInfo>findByCourseNameAndTeacherID(String courseNameID,Integer teacherID);
    ArrayList<CourseInfo>findByCourseYearAndCourseSemester(Integer year,String semester);
}
