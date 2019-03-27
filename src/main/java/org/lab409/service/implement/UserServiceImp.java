package org.lab409.service.implement;

import org.lab409.dao.UserDao;
import org.lab409.entity.ResultEntity;
import org.lab409.entity.UserInfo;
import org.lab409.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service(value="userService")
public class UserServiceImp implements UserService
{
    @Autowired
    private UserDao userDao;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    @Override
    @Transactional
    public ResultEntity addUser(UserInfo userInfo)
    {
        ResultEntity resultEntity=new ResultEntity();
        if (userInfo!=null)
        {
            userInfo.setPassword(bCryptPasswordEncoder.encode(userInfo.getPassword()));
            resultEntity.setData(userDao.saveAndFlush(userInfo));
            if (resultEntity.getData()!=null)
            {
                resultEntity.setState(1);
                resultEntity.setMessage("注册成功！");
            }
            else
            {
                resultEntity.setMessage("数据插入失败！");
                resultEntity.setState(0);
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }
}
