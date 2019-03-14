package org.lab409.security.repository;

import org.lab409.model.security.User;

/**
 * Created by stephan on 20.03.16.
 */
public interface UserRepository {
    User findByUsername(String username);
}
