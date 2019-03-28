package org.lab409.service;

import org.lab409.entity.ResultEntity;
import org.lab409.entity.UserAuthority;
import org.lab409.entity.UserInfo;

public interface UserService
{
    ResultEntity addUser(UserInfo userInfo);
    UserAuthority addUserAuthority(Integer userID,Integer authorityID);
}
