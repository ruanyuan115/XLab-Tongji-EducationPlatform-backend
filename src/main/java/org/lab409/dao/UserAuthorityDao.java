package org.lab409.dao;

import org.lab409.entity.UserAuthority;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserAuthorityDao extends JpaRepository<UserAuthority,Integer>{
}
