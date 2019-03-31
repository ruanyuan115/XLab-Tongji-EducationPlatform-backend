package org.lab409.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Table(name = "USER_AUTHORITY")
@DynamicInsert
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
