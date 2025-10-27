package com.example.edms.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Tag entity for document organization and categorization.
 * Tags can be associated with multiple documents (many-to-many relationship).
 * Corresponds to the 'tags' table in the database schema.
 */
public class Tag implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String name;
    private Date createdAt;

    // Constructors
    public Tag() {
        this.createdAt = new Date();
    }

    public Tag(String name) {
        this();
        this.name = name;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Tag{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Tag tag = (Tag) o;
        return id != null && id.equals(tag.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}
