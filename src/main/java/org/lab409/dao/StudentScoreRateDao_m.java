package org.lab409.dao;

import org.lab409.entity.StudentScoreRate;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public interface StudentScoreRateDao_m {
    ArrayList<StudentScoreRate> getStudentScoreRate(@Param("keys")ArrayList<Map> keyMaps);
}
