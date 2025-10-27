package com.example.edms.dao;

import com.example.edms.model.Category;
import java.util.List;

/**
 * DAO interface for Category entity operations.
 */
public interface CategoryDAO extends GenericDAO<Category, Long> {

    /**
     * Find a category by name.
     * 
     * @param name the category name
     * @return the category, or null if not found
     */
    Category findByName(String name);

    /**
     * Find root categories (categories without parent).
     * 
     * @return list of root categories
     */
    List<Category> findRootCategories();

    /**
     * Find child categories of a parent category.
     * 
     * @param parentId the parent category ID
     * @return list of child categories
     */
    List<Category> findByParent(Long parentId);

    /**
     * Check if category name exists.
     * 
     * @param name the category name
     * @return true if name exists
     */
    boolean nameExists(String name);
}
