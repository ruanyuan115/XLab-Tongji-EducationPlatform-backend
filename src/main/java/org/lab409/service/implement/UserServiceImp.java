package org.lab409.service.implement;

import org.lab409.dao.UserAuthorityDao;
import org.lab409.dao.UserDao;
import org.lab409.entity.ResultEntity;
import org.lab409.entity.UserAuthority;
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
    private UserAuthorityDao userAuthorityDao;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    @Override
    @Transactional(rollbackOn = Exception.class)
    public ResultEntity addUser(UserInfo userInfo)
    {
        ResultEntity resultEntity=new ResultEntity();
        if (userInfo!=null)
        {
            if(userDao.findByMail(userInfo.getMail())==null)
            {
                userInfo.setPassword(bCryptPasswordEncoder.encode(userInfo.getPassword()));

                UserInfo result=new UserInfo(userDao.saveAndFlush(userInfo));
                UserAuthority authorityResult=addUserAuthority(result.getUserID(),result.getRole().equals("学生")?1:(result.getRole().equals("老师")?2:3));

                result.setPassword("");
                resultEntity.setData(result);

                if (resultEntity.getData()!=null&&authorityResult!=null)
                {
                    resultEntity.setState(1);
                    resultEntity.setMessage("注册成功！");
                }
                else
                {
                    resultEntity.setMessage("数据插入失败！");
                    resultEntity.setState(0);
                    throw new NullPointerException();
                }
            }
            else
            {
                resultEntity.setState(0);
                resultEntity.setMessage("该邮箱已被注册！");
            }
        }
        else
        {
            resultEntity.setMessage("传入参数为空！");
            resultEntity.setState(0);
        }
        return resultEntity;
    }

    @Override
    public UserAuthority addUserAuthority(Integer userID, Integer authorityID)
    {
        if(userID!=null&&authorityID!=null)
        {
            UserAuthority userAuthority=new UserAuthority();
            userAuthority.setUserID(userID);
            userAuthority.setAuthorityID(authorityID);
            return userAuthorityDao.save(userAuthority);
        }
        else
        {
            return null;
        }
    }
}
