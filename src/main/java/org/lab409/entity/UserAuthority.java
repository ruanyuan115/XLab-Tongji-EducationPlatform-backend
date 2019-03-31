package org.lab409.entity;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "USER_AUTHORITY")
@Data
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
}
