package org.lab409.dao;

import org.lab409.entity.UserInfo;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface UserDao_m {
    ArrayList<UserInfo> findByUserID(@Param("userIDs") ArrayList<Integer> userIDs);
}
