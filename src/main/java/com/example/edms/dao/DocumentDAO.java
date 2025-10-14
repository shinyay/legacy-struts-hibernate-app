package com.example.edms.dao;

import com.example.edms.model.Document;
import java.util.Date;
import java.util.List;

/**
 * DAO interface for Document entity operations.
 */
public interface DocumentDAO extends GenericDAO<Document, Long> {

    /**
     * Find documents by title (partial match).
     * 
     * @param title the title to search for
     * @return list of matching documents
     */
    List<Document> findByTitle(String title);

    /**
     * Find documents by category.
     * 
     * @param categoryId the category ID
     * @return list of documents in the category
     */
    List<Document> findByCategory(Long categoryId);

    /**
     * Find documents by author.
     * 
     * @param authorId the author user ID
     * @return list of documents by the author
     */
    List<Document> findByAuthor(Long authorId);

    /**
     * Find documents by status.
     * 
     * @param status the document status
     * @return list of documents with the specified status
     */
    List<Document> findByStatus(String status);

    /**
     * Find documents by access level.
     * 
     * @param accessLevel the access level
     * @return list of documents with the specified access level
     */
    List<Document> findByAccessLevel(String accessLevel);

    /**
     * Find recent documents.
     * 
     * @param limit the maximum number of documents to return
     * @return list of recent documents
     */
    List<Document> findRecent(int limit);

    /**
     * Search documents by keyword (title and description).
     * 
     * @param keyword the search keyword
     * @return list of matching documents
     */
    List<Document> search(String keyword);

    /**
     * Find expired documents.
     * 
     * @return list of expired documents
     */
    List<Document> findExpired();
}
