package org.lab409.model.security;

import lombok.Data;

import java.util.List;

@Data
public class User {

    private Long id;

    private String username;

    private String password;

    private String email;

    private List<Authority> authorities;

}
