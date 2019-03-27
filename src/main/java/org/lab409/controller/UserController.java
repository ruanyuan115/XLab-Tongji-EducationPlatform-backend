package org.lab409.controller;

import org.apache.ibatis.annotations.Param;
import org.lab409.entity.ResultEntity;
import org.lab409.entity.UserInfo;
import org.lab409.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController
{
    @Autowired
    private UserService userService;

    @PostMapping(value ="/register")
    public ResultEntity register(UserInfo userInfo)
    {
        return userService.addUser(userInfo);
    }
}
