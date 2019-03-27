package org.lab409.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.lab409.model.security.User;
import org.lab409.security.JwtUserFactory;
import org.lab409.security.repository.UserRepository;

@Service
public class JwtUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String mail) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(mail);

        if (user == null) {
            throw new UsernameNotFoundException(String.format("No user found with mail '%s'.", mail));
        } else {
            return JwtUserFactory.create(user);
        }
    }
}
