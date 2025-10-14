package com.example.edms.dao.impl;

import com.example.edms.dao.GenericDAO;
import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

/**
 * Base implementation of GenericDAO providing common CRUD operations.
 * Entity-specific DAOs should extend this class.
 * 
 * @param <T> the entity type
 * @param <ID> the primary key type
 */
public abstract class GenericDAOImpl<T, ID extends Serializable> implements GenericDAO<T, ID> {

    private Class<T> entityClass;

    /**
     * Constructor that determines the entity class from generics.
     */
    @SuppressWarnings("unchecked")
    public GenericDAOImpl() {
        this.entityClass = (Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0];
    }

    /**
     * Get the current Hibernate session.
     * 
     * @return the current session
     */
    protected Session getSession() {
        return HibernateUtil.getSessionFactory().getCurrentSession();
    }

    @Override
    public T save(T entity) {
        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(entity);
            tx.commit();
            return entity;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error saving entity", e);
        }
    }

    @Override
    public T update(T entity) {
        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(entity);
            tx.commit();
            return entity;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error updating entity", e);
        }
    }

    @Override
    public void delete(T entity) {
        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(entity);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error deleting entity", e);
        }
    }

    @Override
    public void deleteById(ID id) {
        T entity = findById(id);
        if (entity != null) {
            delete(entity);
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public T findById(ID id) {
        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            T entity = (T) session.get(entityClass, id);
            tx.commit();
            return entity;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error finding entity by ID", e);
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<T> findAll() {
        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List<T> entities = session.createCriteria(entityClass).list();
            tx.commit();
            return entities;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error finding all entities", e);
        }
    }

    @Override
    public long count() {
        Session session = getSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM " + entityClass.getSimpleName())
                    .uniqueResult();
            tx.commit();
            return count != null ? count.longValue() : 0L;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Error counting entities", e);
        }
    }

    @Override
    public boolean exists(ID id) {
        return findById(id) != null;
    }

    /**
     * Get the entity class.
     * 
     * @return the entity class
     */
    protected Class<T> getEntityClass() {
        return entityClass;
    }
}
