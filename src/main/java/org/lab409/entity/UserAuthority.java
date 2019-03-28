package org.lab409.entity;

import javax.persistence.*;

@Entity
@Table(name = "USER_AUTHORITY")
public class UserAuthority
{
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "USER_ID")
    private Integer userID;
    @Column(name = "AUTHORITY_ID")
    private Integer authorityID;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public Integer getAuthorityID() {
        return authorityID;
    }

    public void setAuthorityID(Integer authorityID) {
        this.authorityID = authorityID;
    }
}
