package com.example.edms.dao.impl;

import com.example.edms.dao.UserDAO;
import com.example.edms.model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

/**
 * Implementation of UserDAO for User entity operations.
 */
public class UserDAOImpl extends GenericDAOImpl<User, Long> implements UserDAO {

    @Override
    public User findByUsername(String username) {
        if (username == null) {
            return null;
        }

        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("FROM User WHERE username = :username");
            query.setParameter("username", username);
            User user = (User) query.uniqueResult();
            tx.commit();
            return user;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error finding user by username", e);
        }
    }

    @Override
    public User findByEmail(String email) {
        if (email == null) {
            return null;
        }

        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("FROM User WHERE email = :email");
            query.setParameter("email", email);
            User user = (User) query.uniqueResult();
            tx.commit();
            return user;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error finding user by email", e);
        }
    }

    @Override
    public User authenticate(String username, String hashedPassword) {
        if (username == null || hashedPassword == null) {
            return null;
        }

        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery(
                    "FROM User WHERE username = :username AND password = :password AND status = :status");
            query.setParameter("username", username);
            query.setParameter("password", hashedPassword);
            query.setParameter("status", "ACTIVE");
            User user = (User) query.uniqueResult();
            tx.commit();
            return user;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error authenticating user", e);
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> findByDepartment(String department) {
        if (department == null) {
            return null;
        }

        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("FROM User WHERE department = :department ORDER BY fullName");
            query.setParameter("department", department);
            List<User> users = query.list();
            tx.commit();
            return users;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error finding users by department", e);
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> findByStatus(String status) {
        if (status == null) {
            return null;
        }

        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("FROM User WHERE status = :status ORDER BY username");
            query.setParameter("status", status);
            List<User> users = query.list();
            tx.commit();
            return users;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error finding users by status", e);
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> findByRole(String roleName) {
        if (roleName == null) {
            return null;
        }

        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery(
                    "SELECT DISTINCT u FROM User u JOIN u.roles r WHERE r.name = :roleName ORDER BY u.username");
            query.setParameter("roleName", roleName);
            List<User> users = query.list();
            tx.commit();
            return users;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error finding users by role", e);
        }
    }

    @Override
    public boolean usernameExists(String username) {
        return findByUsername(username) != null;
    }

    @Override
    public boolean emailExists(String email) {
        return findByEmail(email) != null;
    }
}
