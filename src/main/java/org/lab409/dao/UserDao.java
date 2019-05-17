package org.lab409.dao;

import org.lab409.entity.UserInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao extends JpaRepository<UserInfo,Integer>
{
    UserInfo findByMail(String mail);
    UserInfo findByUserID(Integer userID);
}
