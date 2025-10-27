package com.example.edms.dao;

import com.example.edms.model.User;
import java.util.List;

/**
 * DAO interface for User entity operations.
 */
public interface UserDAO extends GenericDAO<User, Long> {

    /**
     * Find a user by username.
     * 
     * @param username the username
     * @return the user, or null if not found
     */
    User findByUsername(String username);

    /**
     * Find a user by email.
     * 
     * @param email the email address
     * @return the user, or null if not found
     */
    User findByEmail(String email);

    /**
     * Authenticate a user.
     * 
     * @param username the username
     * @param hashedPassword the hashed password
     * @return the authenticated user, or null if authentication fails
     */
    User authenticate(String username, String hashedPassword);

    /**
     * Find users by department.
     * 
     * @param department the department name
     * @return list of users in the department
     */
    List<User> findByDepartment(String department);

    /**
     * Find users by status.
     * 
     * @param status the user status (ACTIVE, INACTIVE, LOCKED)
     * @return list of users with the specified status
     */
    List<User> findByStatus(String status);

    /**
     * Find users by role.
     * 
     * @param roleName the role name
     * @return list of users with the specified role
     */
    List<User> findByRole(String roleName);

    /**
     * Check if username exists.
     * 
     * @param username the username to check
     * @return true if username exists
     */
    boolean usernameExists(String username);

    /**
     * Check if email exists.
     * 
     * @param email the email to check
     * @return true if email exists
     */
    boolean emailExists(String email);
}
