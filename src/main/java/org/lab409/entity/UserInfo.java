package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Table(name="user")
@DynamicInsert
@Data
public class UserInfo
{
    @Id
    @Column(name = "user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userID;
    @Column(name = "mail")
    private String mail;
    @Column(name = "password")
    private String password;
    @Column(name = "name")
    private String name;
    @Column(name = "role")
    private String role;
    @Column(name = "work_id")
    private Integer workID;
    @Column(name = "gender")
    private String gender;

    public UserInfo(){}
    public UserInfo(UserInfo userInfo) {
        this.userID=userInfo.getUserID();
        this.mail = userInfo.getMail();
        this.name = userInfo.getName();
        this.role = userInfo.getRole();
        this.workID = userInfo.getWorkID();
        this.gender = userInfo.getGender();
    }
}
