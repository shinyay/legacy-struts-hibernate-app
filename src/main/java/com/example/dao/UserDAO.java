package com.example.dao;

import com.example.model.User;
import java.util.List;

/**
 * DAO Interface for User operations
 */
public interface UserDAO {

    void save(User user);

    void update(User user);

    void delete(User user);

    User findById(Long id);

    List findAll();

    User findByUsername(String username);
}
