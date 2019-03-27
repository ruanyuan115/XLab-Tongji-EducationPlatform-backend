package org.lab409.model.security;

import lombok.Data;

import java.util.List;

@Data
public class User
{
    private Long id;

    private String mail;

    private String password;

    private String name;

    private List<Authority> authorities;
}
