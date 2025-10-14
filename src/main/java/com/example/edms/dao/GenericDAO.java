package com.example.edms.dao;

import java.io.Serializable;
import java.util.List;

/**
 * Generic DAO interface defining common CRUD operations.
 * All entity-specific DAOs should extend this interface.
 * 
 * @param <T> the entity type
 * @param <ID> the primary key type
 */
public interface GenericDAO<T, ID extends Serializable> {

    /**
     * Save a new entity.
     * 
     * @param entity the entity to save
     * @return the saved entity with generated ID
     */
    T save(T entity);

    /**
     * Update an existing entity.
     * 
     * @param entity the entity to update
     * @return the updated entity
     */
    T update(T entity);

    /**
     * Delete an entity.
     * 
     * @param entity the entity to delete
     */
    void delete(T entity);

    /**
     * Delete an entity by ID.
     * 
     * @param id the entity ID
     */
    void deleteById(ID id);

    /**
     * Find an entity by ID.
     * 
     * @param id the entity ID
     * @return the entity, or null if not found
     */
    T findById(ID id);

    /**
     * Find all entities.
     * 
     * @return list of all entities
     */
    List<T> findAll();

    /**
     * Count all entities.
     * 
     * @return the total count
     */
    long count();

    /**
     * Check if an entity exists by ID.
     * 
     * @param id the entity ID
     * @return true if exists
     */
    boolean exists(ID id);
}
