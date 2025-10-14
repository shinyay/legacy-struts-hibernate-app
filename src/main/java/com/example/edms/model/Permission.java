package com.example.edms.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Permission entity for granular access control.
 * Corresponds to the 'permissions' table in the database schema.
 */
public class Permission implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String name;
    private String resource; // DOCUMENT, USER, WORKFLOW, REPORT, SYSTEM
    private String action; // CREATE, READ, UPDATE, DELETE, EXECUTE
    private String description;
    private Date createdAt;

    // Constructors
    public Permission() {
        this.createdAt = new Date();
    }

    public Permission(String name, String resource, String action) {
        this();
        this.name = name;
        this.resource = resource;
        this.action = action;
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

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", resource='" + resource + '\'' +
                ", action='" + action + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Permission that = (Permission) o;
        return id != null && id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}
