# Document Management System - Complete Technical Specification

**Project Name:** Enterprise Document Management System (EDMS)
**Version:** 1.0
**Date:** October 12, 2025
**Target Platform:** Legacy Java Stack (Java 5 / Struts 1.3 / Hibernate 3.6 / MySQL 5.7)

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [System Overview](#2-system-overview)
3. [Technology Stack](#3-technology-stack)
4. [System Architecture](#4-system-architecture)
5. [Functional Requirements](#5-functional-requirements)
6. [Non-Functional Requirements](#6-non-functional-requirements)
7. [Database Design](#7-database-design)
8. [Application Design](#8-application-design)
9. [User Interface Design](#9-user-interface-design)
10. [Security Design](#10-security-design)
11. [Integration Design](#11-integration-design)
12. [Deployment Architecture](#12-deployment-architecture)
13. [Development Plan](#13-development-plan)
14. [Testing Strategy](#14-testing-strategy)
15. [Risk Management](#15-risk-management)
16. [Appendices](#16-appendices)

---

## 1. Executive Summary

### 1.1 Project Vision

The Enterprise Document Management System (EDMS) is a comprehensive web-based application designed to manage, store, track, and retrieve organizational documents throughout their lifecycle. Built on proven legacy technologies, EDMS provides a stable, reliable, and maintainable solution for enterprise document management needs.

### 1.2 Business Objectives

- **Centralized Document Repository:** Single source of truth for all organizational documents
- **Version Control:** Complete audit trail and version history for all documents
- **Access Control:** Role-based security ensuring documents are accessible only to authorized personnel
- **Search and Retrieval:** Powerful search capabilities to locate documents quickly
- **Workflow Automation:** Streamlined approval and review processes
- **Compliance:** Support for regulatory compliance and retention policies

### 1.3 Target Users

- **Administrators:** System configuration, user management, global settings
- **Department Managers:** Workflow approval, department document oversight
- **Regular Users:** Document upload, search, view, and download
- **Auditors:** Read-only access to audit logs and document history
- **Guests:** Limited read-only access to designated public documents

### 1.4 Success Criteria

- Support 500+ concurrent users
- Handle 100,000+ documents in the repository
- Document upload/download response time < 3 seconds
- Search response time < 2 seconds
- 99.5% uptime during business hours
- Zero data loss tolerance

---

## 2. System Overview

### 2.1 System Description

EDMS is a three-tier web application that provides comprehensive document management capabilities including document upload, categorization, version control, full-text search, workflow management, and audit tracking.

### 2.2 Key Features Summary

1. **Document Management**
   - Upload documents (PDF, DOC, DOCX, XLS, XLSX, TXT, images)
   - Download documents with virus scanning
   - Document metadata management
   - Document categorization and tagging
   - Bulk operations (upload, download, delete)

2. **Version Control**
   - Automatic version tracking
   - Version comparison
   - Rollback to previous versions
   - Version comments and annotations

3. **Search and Indexing**
   - Full-text search using Apache Lucene
   - Metadata-based search
   - Advanced filters (date range, category, author, tags)
   - Search result highlighting

4. **Workflow Management**
   - Document approval workflows
   - Review and comment cycles
   - Email notifications
   - Deadline tracking

5. **Security and Access Control**
   - User authentication (username/password)
   - Role-based access control (RBAC)
   - Document-level permissions
   - Audit logging

6. **Reporting**
   - Document activity reports
   - User activity reports
   - Storage utilization reports
   - Audit trail reports
   - Export to PDF and Excel

### 2.3 System Boundaries

**In Scope:**
- Document storage and retrieval
- Version control
- Search functionality
- Workflow management
- User management
- Reporting and analytics
- Basic email notifications

**Out of Scope:**
- Real-time collaboration (Google Docs-style editing)
- Mobile native applications
- External system integrations (ERP, CRM)
- OCR processing
- Advanced document conversion
- Video/audio streaming

---

## 3. Technology Stack

### 3.1 Core Technologies

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| Programming Language | Java | 1.5.0_22 (J2SE 5.0) | Core application logic |
| Application Server | Apache Tomcat | 6.0.53 | Servlet container |
| Database | MySQL | 5.7 | Data persistence |
| ORM Framework | Hibernate | 3.6.10.Final | Object-relational mapping |
| Web Framework | Apache Struts | 1.3.10 | MVC architecture |
| Frontend Library | jQuery | 1.12.4 | DOM manipulation, AJAX |
| Build Tool | Apache Ant | 1.6.5 | Build automation |

### 3.2 Supporting Libraries

| Library | Version | Purpose |
|---------|---------|---------|
| Log4j | 1.2.17 | Logging framework |
| C3P0 | 0.9.1.2 | Connection pooling |
| EHCache | 2.4.3 | Second-level caching |
| Apache Commons FileUpload | 1.3.3 | File upload handling |
| Apache Commons IO | 2.4 | File operations |
| Apache Commons Lang | 2.6 | Utility functions |
| Apache Lucene | 3.6.2 | Full-text search |
| Apache PDFBox | 1.8.16 | PDF text extraction |
| Apache POI | 3.17 | Excel/Word processing |
| iText | 2.1.7 | PDF generation |
| JavaMail | 1.4.7 | Email notifications |
| Quartz Scheduler | 1.8.6 | Job scheduling |
| JSTL | 1.2 | JSP tag library |
| DisplayTag | 1.2 | Table rendering |

### 3.3 Development Tools

- **IDE:** Eclipse 3.7 (Indigo) or IntelliJ IDEA
- **Version Control:** Git
- **Database Client:** MySQL Workbench
- **Testing:** JUnit 4.12, DBUnit 2.4.9
- **Code Coverage:** Cobertura
- **Static Analysis:** FindBugs, PMD

---

## 4. System Architecture

### 4.1 Architectural Pattern

EDMS follows a traditional **3-tier architecture**:

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION TIER                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   JSP Pages  │  │  Struts Tags │  │   jQuery     │      │
│  │   + JSTL     │  │   + Custom   │  │   + AJAX     │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                    APPLICATION TIER                          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Struts Action Layer                      │  │
│  │  (Controllers, Form Beans, Action Mappings)          │  │
│  └──────────────────────────────────────────────────────┘  │
│                            ↕                                 │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Business Logic Layer                     │  │
│  │  (Services, Business Rules, Validation)              │  │
│  └──────────────────────────────────────────────────────┘  │
│                            ↕                                 │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Data Access Layer (DAO)                  │  │
│  │  (Hibernate DAOs, Transaction Management)            │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                      DATA TIER                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ MySQL        │  │ File System  │  │ Lucene Index │      │
│  │ Database     │  │ (Documents)  │  │ (Search)     │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### 4.2 Component Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      Web Browser                             │
│           (HTML, CSS, JavaScript/jQuery)                     │
└─────────────────────────────────────────────────────────────┘
                            ↕ HTTP/HTTPS
┌─────────────────────────────────────────────────────────────┐
│                   Apache Tomcat 6.0                          │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Filter Chain                                          │  │
│  │  ├─ AuthenticationFilter                              │  │
│  │  ├─ EncodingFilter (UTF-8)                            │  │
│  │  └─ LoggingFilter                                     │  │
│  └───────────────────────────────────────────────────────┘  │
│                            ↕                                 │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Struts ActionServlet (Front Controller)              │  │
│  └───────────────────────────────────────────────────────┘  │
│                            ↕                                 │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Action Classes                                        │  │
│  │  ├─ DocumentAction (upload, download, list, delete)   │  │
│  │  ├─ SearchAction (search, advanced search)            │  │
│  │  ├─ VersionAction (history, compare, rollback)        │  │
│  │  ├─ WorkflowAction (submit, approve, reject)          │  │
│  │  ├─ UserAction (login, logout, profile)               │  │
│  │  ├─ AdminAction (user mgmt, system config)            │  │
│  │  └─ ReportAction (generate reports)                   │  │
│  └───────────────────────────────────────────────────────┘  │
│                            ↕                                 │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Service Layer                                         │  │
│  │  ├─ DocumentService                                   │  │
│  │  ├─ VersionService                                    │  │
│  │  ├─ SearchService (Lucene integration)                │  │
│  │  ├─ WorkflowService                                   │  │
│  │  ├─ UserService                                       │  │
│  │  ├─ SecurityService                                   │  │
│  │  ├─ NotificationService (JavaMail)                    │  │
│  │  └─ ReportService (iText, POI)                        │  │
│  └───────────────────────────────────────────────────────┘  │
│                            ↕                                 │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  DAO Layer (Hibernate)                                │  │
│  │  ├─ DocumentDAO                                       │  │
│  │  ├─ DocumentVersionDAO                                │  │
│  │  ├─ CategoryDAO                                       │  │
│  │  ├─ WorkflowDAO                                       │  │
│  │  ├─ UserDAO                                           │  │
│  │  ├─ RoleDAO                                           │  │
│  │  └─ AuditLogDAO                                       │  │
│  └───────────────────────────────────────────────────────┘  │
│                            ↕                                 │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Domain Model (Hibernate Entities)                    │  │
│  │  ├─ Document                                          │  │
│  │  ├─ DocumentVersion                                   │  │
│  │  ├─ Category                                          │  │
│  │  ├─ Tag                                               │  │
│  │  ├─ Workflow                                          │  │
│  │  ├─ WorkflowStep                                      │  │
│  │  ├─ User                                              │  │
│  │  ├─ Role                                              │  │
│  │  ├─ Permission                                        │  │
│  │  └─ AuditLog                                          │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│  MySQL Database + File System + Lucene Index                │
└─────────────────────────────────────────────────────────────┘
```

### 4.3 Package Structure

```
com.example.edms
├── action                    (Struts Action classes)
│   ├── DocumentAction.java
│   ├── SearchAction.java
│   ├── VersionAction.java
│   ├── WorkflowAction.java
│   ├── UserAction.java
│   ├── AdminAction.java
│   └── ReportAction.java
├── form                      (Struts ActionForm classes)
│   ├── DocumentForm.java
│   ├── SearchForm.java
│   ├── WorkflowForm.java
│   ├── UserForm.java
│   └── ReportForm.java
├── service                   (Business logic layer)
│   ├── DocumentService.java
│   ├── VersionService.java
│   ├── SearchService.java
│   ├── WorkflowService.java
│   ├── UserService.java
│   ├── SecurityService.java
│   ├── NotificationService.java
│   ├── ReportService.java
│   └── impl                  (Service implementations)
│       ├── DocumentServiceImpl.java
│       ├── VersionServiceImpl.java
│       ├── SearchServiceImpl.java
│       ├── WorkflowServiceImpl.java
│       ├── UserServiceImpl.java
│       ├── SecurityServiceImpl.java
│       ├── NotificationServiceImpl.java
│       └── ReportServiceImpl.java
├── dao                       (Data access layer)
│   ├── DocumentDAO.java
│   ├── DocumentVersionDAO.java
│   ├── CategoryDAO.java
│   ├── TagDAO.java
│   ├── WorkflowDAO.java
│   ├── WorkflowStepDAO.java
│   ├── UserDAO.java
│   ├── RoleDAO.java
│   ├── PermissionDAO.java
│   ├── AuditLogDAO.java
│   └── impl                  (DAO implementations)
│       ├── DocumentDAOImpl.java
│       ├── DocumentVersionDAOImpl.java
│       ├── CategoryDAOImpl.java
│       ├── TagDAOImpl.java
│       ├── WorkflowDAOImpl.java
│       ├── WorkflowStepDAOImpl.java
│       ├── UserDAOImpl.java
│       ├── RoleDAOImpl.java
│       ├── PermissionDAOImpl.java
│       └── AuditLogDAOImpl.java
├── model                     (Domain model / Hibernate entities)
│   ├── Document.java
│   ├── DocumentVersion.java
│   ├── Category.java
│   ├── Tag.java
│   ├── Workflow.java
│   ├── WorkflowStep.java
│   ├── WorkflowInstance.java
│   ├── WorkflowTask.java
│   ├── User.java
│   ├── Role.java
│   ├── Permission.java
│   ├── AuditLog.java
│   ├── Comment.java
│   └── Notification.java
├── filter                    (Servlet filters)
│   ├── AuthenticationFilter.java
│   ├── EncodingFilter.java
│   ├── LoggingFilter.java
│   └── SecurityFilter.java
├── listener                  (Context and session listeners)
│   ├── AppContextListener.java
│   └── SessionListener.java
├── util                      (Utility classes)
│   ├── Constants.java
│   ├── DateUtil.java
│   ├── FileUtil.java
│   ├── StringUtil.java
│   ├── EncryptionUtil.java
│   ├── ValidationUtil.java
│   └── HibernateUtil.java
├── exception                 (Custom exceptions)
│   ├── EDMSException.java
│   ├── DocumentNotFoundException.java
│   ├── UnauthorizedAccessException.java
│   ├── InvalidDocumentException.java
│   └── WorkflowException.java
├── dto                       (Data transfer objects)
│   ├── DocumentDTO.java
│   ├── SearchResultDTO.java
│   ├── WorkflowDTO.java
│   └── ReportDTO.java
└── validator                 (Custom validators)
    ├── DocumentValidator.java
    ├── UserValidator.java
    └── WorkflowValidator.java
```

### 4.4 Request Processing Flow

```
1. User Request (Browser)
   ↓
2. Tomcat receives HTTP request
   ↓
3. Filter Chain
   ├─ EncodingFilter (sets UTF-8 encoding)
   ├─ AuthenticationFilter (checks session, validates user)
   └─ LoggingFilter (logs request details)
   ↓
4. Struts ActionServlet (Front Controller)
   ↓
5. ActionServlet reads struts-config.xml
   ├─ Finds matching <action> mapping by path
   ├─ Populates ActionForm from request parameters
   └─ Validates ActionForm (if validate="true")
   ↓
6. ActionServlet dispatches to Action class
   ↓
7. Action class executes business logic
   ├─ Calls Service layer methods
   │   ├─ Service validates business rules
   │   ├─ Service calls DAO layer
   │   │   ├─ DAO uses Hibernate Session
   │   │   ├─ Hibernate executes SQL via JDBC
   │   │   └─ Returns domain objects
   │   └─ Service transforms to DTOs
   └─ Action returns ActionForward
   ↓
8. ActionServlet forwards to JSP
   ↓
9. JSP renders view
   ├─ Uses JSTL tags for logic
   ├─ Uses Struts tags for forms
   ├─ Includes jQuery for interactivity
   └─ Generates HTML response
   ↓
10. Response sent to browser
```

---

## 5. Functional Requirements

### 5.1 User Management

#### 5.1.1 User Registration and Authentication

**FR-UM-001: User Login**
- **Description:** Users must authenticate using username and password
- **Actors:** All users
- **Preconditions:** User account exists and is active
- **Flow:**
  1. User navigates to login page
  2. User enters username and password
  3. System validates credentials against database (password hashed with MD5/SHA-256)
  4. System creates HTTP session upon successful authentication
  5. System redirects to dashboard
- **Postconditions:** User session established, audit log entry created
- **Business Rules:**
  - Password minimum 8 characters
  - Account locks after 5 failed login attempts
  - Session timeout after 30 minutes of inactivity
- **UI Elements:** Login form with username, password, "Remember Me" checkbox, "Forgot Password" link

**FR-UM-002: User Logout**
- **Description:** Users can terminate their session
- **Actors:** All authenticated users
- **Flow:**
  1. User clicks "Logout" button
  2. System invalidates HTTP session
  3. System clears session attributes
  4. System redirects to login page
- **Postconditions:** Session destroyed, audit log entry created

**FR-UM-003: User Profile Management**
- **Description:** Users can view and update their profile information
- **Actors:** All authenticated users
- **Fields:** Full name, email, phone, department, profile picture
- **Flow:**
  1. User navigates to "My Profile" page
  2. User updates desired fields
  3. User clicks "Save"
  4. System validates input
  5. System updates database
  6. System displays success message
- **Validations:**
  - Email format validation
  - Phone number format validation
  - Profile picture max size 2MB (JPG, PNG)

**FR-UM-004: Password Change**
- **Description:** Users can change their password
- **Actors:** All authenticated users
- **Flow:**
  1. User navigates to "Change Password" page
  2. User enters current password
  3. User enters new password twice
  4. System validates current password
  5. System validates new password meets complexity requirements
  6. System validates password confirmation matches
  7. System updates password (hashed)
  8. System sends email notification
- **Validations:**
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one number
  - At least one special character
  - Cannot be same as previous 3 passwords

#### 5.1.2 User Administration

**FR-UM-005: Create User Account**
- **Description:** Administrators can create new user accounts
- **Actors:** Administrator
- **Fields:** Username, password, full name, email, role, department, status
- **Flow:**
  1. Admin navigates to "User Management" → "Add User"
  2. Admin fills in user details
  3. Admin assigns role(s)
  4. Admin clicks "Create"
  5. System validates input
  6. System creates user account
  7. System sends welcome email with credentials
- **Postconditions:** User account created, audit log entry created

**FR-UM-006: Edit User Account**
- **Description:** Administrators can modify existing user accounts
- **Actors:** Administrator
- **Flow:**
  1. Admin searches/selects user
  2. Admin clicks "Edit"
  3. Admin modifies fields
  4. Admin clicks "Save"
  5. System validates and updates
- **Validations:** Cannot modify own role, cannot delete last admin

**FR-UM-007: Deactivate/Activate User**
- **Description:** Administrators can activate or deactivate user accounts
- **Actors:** Administrator
- **Flow:**
  1. Admin selects user
  2. Admin clicks "Deactivate" or "Activate"
  3. System updates user status
  4. System terminates active sessions (for deactivation)
- **Business Rules:** Cannot deactivate own account

**FR-UM-008: Role Management**
- **Description:** Administrators can create and manage roles
- **Default Roles:** Administrator, Manager, User, Auditor, Guest
- **Permissions:** Create/Read/Update/Delete for Documents, Users, Workflows, Reports
- **Flow:**
  1. Admin navigates to "Role Management"
  2. Admin creates/edits role
  3. Admin assigns permissions
  4. Admin saves role
- **Business Rules:** Cannot delete default roles, cannot remove all admins

### 5.2 Document Management

#### 5.2.1 Document Upload

**FR-DM-001: Single Document Upload**
- **Description:** Users can upload a single document with metadata
- **Actors:** Users with upload permission
- **Supported Formats:** PDF, DOC, DOCX, XLS, XLSX, PPT, PPTX, TXT, JPG, PNG, GIF
- **Maximum File Size:** 50MB per file
- **Flow:**
  1. User navigates to "Upload Document"
  2. User clicks "Browse" and selects file
  3. User fills in metadata:
     - Document title (required)
     - Description (optional)
     - Category (required, dropdown)
     - Tags (optional, comma-separated)
     - Access level (Public, Private, Restricted)
  4. User clicks "Upload"
  5. System validates file type and size
  6. System scans for viruses (if configured)
  7. System generates unique file ID
  8. System saves file to file system
  9. System creates database record
  10. System indexes document for search (Lucene)
  11. System displays success message with document link
- **Postconditions:** Document stored, metadata saved, search index updated, audit log created
- **Error Handling:**
  - Invalid file type: "File type not supported"
  - File too large: "File exceeds maximum size of 50MB"
  - Virus detected: "File contains malicious content"

**FR-DM-002: Bulk Document Upload**
- **Description:** Users can upload multiple documents simultaneously
- **Actors:** Users with upload permission
- **Flow:**
  1. User navigates to "Bulk Upload"
  2. User selects multiple files (drag-and-drop or browse)
  3. User sets common metadata (category, tags, access level)
  4. User clicks "Upload All"
  5. System processes each file asynchronously
  6. System displays progress bar
  7. System shows summary (X successful, Y failed)
- **Business Rules:** Maximum 20 files per batch, each file validates independently

**FR-DM-003: Document Metadata Entry**
- **Metadata Fields:**
  - **Title:** Text, required, max 200 characters
  - **Description:** Text area, optional, max 2000 characters
  - **Category:** Dropdown, required, values from category table
  - **Tags:** Text, optional, comma-separated, max 10 tags
  - **Author:** Auto-filled with current user, read-only
  - **Department:** Auto-filled from user's department
  - **Access Level:** Radio buttons (Public/Private/Restricted)
  - **Expiration Date:** Date picker, optional
  - **Custom Fields:** Dynamic fields based on category (max 5)

#### 5.2.2 Document Viewing and Download

**FR-DM-004: View Document Details**
- **Description:** Users can view document metadata and preview
- **Actors:** Users with read permission
- **Flow:**
  1. User searches/browses for document
  2. User clicks document title
  3. System displays document details page showing:
     - Metadata (title, description, category, tags, author, upload date)
     - File information (name, size, type, version)
     - Version history
     - Comments
     - Access permissions
     - Related documents
  4. System shows preview (for supported formats: PDF, images, TXT)
- **Preview:** Embedded iframe for PDF, image tag for images, text display for TXT

**FR-DM-005: Download Document**
- **Description:** Users can download documents they have access to
- **Actors:** Users with download permission
- **Flow:**
  1. User clicks "Download" button on document details page
  2. System checks user permissions
  3. System retrieves file from storage
  4. System logs download activity
  5. System sends file to browser with appropriate headers
- **Postconditions:** Download logged in audit trail
- **Business Rules:** Downloads count towards usage statistics

**FR-DM-006: Download Multiple Documents**
- **Description:** Users can download multiple documents as a ZIP archive
- **Actors:** Users with download permission
- **Flow:**
  1. User selects multiple documents (checkboxes)
  2. User clicks "Download Selected"
  3. System creates temporary ZIP file
  4. System adds selected documents to ZIP
  5. System sends ZIP to browser
  6. System deletes temporary ZIP after download
- **Business Rules:** Maximum 100 documents per ZIP, total size limit 500MB

#### 5.2.3 Document Editing

**FR-DM-007: Edit Document Metadata**
- **Description:** Users can update document metadata
- **Actors:** Document owner or users with edit permission
- **Flow:**
  1. User navigates to document details
  2. User clicks "Edit Metadata"
  3. User modifies fields
  4. User clicks "Save"
  5. System validates input
  6. System updates database
  7. System creates audit log entry
- **Business Rules:** Cannot change original author, upload date preserved

**FR-DM-008: Replace Document File**
- **Description:** Users can replace the document file (creates new version)
- **Actors:** Document owner or users with edit permission
- **Flow:**
  1. User navigates to document details
  2. User clicks "Upload New Version"
  3. User selects replacement file
  4. User enters version comments
  5. System validates file
  6. System creates new version record
  7. System saves new file
  8. System updates search index
  9. System increments version number
- **Postconditions:** New version created, previous version retained

#### 5.2.4 Document Deletion

**FR-DM-009: Soft Delete Document**
- **Description:** Users can mark documents as deleted (soft delete)
- **Actors:** Document owner or users with delete permission
- **Flow:**
  1. User clicks "Delete" on document
  2. System prompts for confirmation
  3. User confirms deletion
  4. System marks document as deleted (status flag)
  5. System removes from search index
  6. System hides from normal views
- **Postconditions:** Document hidden but recoverable, audit log created
- **Business Rules:** Deleted documents retained for 90 days before permanent deletion

**FR-DM-010: Restore Deleted Document**
- **Description:** Administrators can restore soft-deleted documents
- **Actors:** Administrator
- **Flow:**
  1. Admin navigates to "Deleted Documents"
  2. Admin selects document
  3. Admin clicks "Restore"
  4. System updates status to active
  5. System re-indexes document
- **Postconditions:** Document visible again

**FR-DM-011: Permanent Delete**
- **Description:** Administrators can permanently delete documents
- **Actors:** Administrator
- **Flow:**
  1. Admin navigates to "Deleted Documents"
  2. Admin selects document
  3. Admin clicks "Permanent Delete"
  4. System prompts for confirmation
  5. User confirms with password
  6. System deletes file from storage
  7. System deletes all versions
  8. System deletes database records
- **Postconditions:** Document permanently removed, not recoverable
- **Business Rules:** Requires admin password confirmation

### 5.3 Category and Tag Management

**FR-CT-001: Create Category**
- **Description:** Administrators can create document categories
- **Actors:** Administrator
- **Fields:** Name, description, parent category (for hierarchy), custom fields
- **Flow:**
  1. Admin navigates to "Category Management"
  2. Admin clicks "Add Category"
  3. Admin fills in details
  4. Admin defines custom fields (optional)
  5. Admin clicks "Save"
- **Business Rules:** Category names must be unique within parent, maximum 3 levels deep

**FR-CT-002: Edit/Delete Category**
- **Description:** Administrators can modify or remove categories
- **Actors:** Administrator
- **Flow:**
  1. Admin selects category
  2. Admin edits/deletes
  3. System validates (cannot delete category with documents)
  4. System updates/removes
- **Business Rules:** Must reassign documents before deleting category

**FR-CT-003: Tag Management**
- **Description:** System automatically creates tags from user input
- **Auto-complete:** Suggests existing tags as user types
- **Tag Cloud:** Displays popular tags with varying sizes
- **Tag Administration:** Admins can merge, rename, or delete tags

### 5.4 Version Control

**FR-VC-001: Automatic Version Creation**
- **Description:** System automatically creates versions when document file is replaced
- **Version Numbering:** Major.Minor format (e.g., 1.0, 1.1, 2.0)
- **Version Metadata:**
  - Version number
  - Upload date/time
  - Uploaded by
  - File size
  - Version comments
  - MD5 checksum

**FR-VC-002: View Version History**
- **Description:** Users can view all versions of a document
- **Actors:** Users with read permission
- **Flow:**
  1. User navigates to document details
  2. User clicks "Version History" tab
  3. System displays table with all versions:
     - Version number
     - Date/time
     - User
     - Size
     - Comments
     - Actions (View, Download, Restore, Compare)

**FR-VC-003: Download Specific Version**
- **Description:** Users can download any previous version
- **Actors:** Users with download permission
- **Flow:**
  1. User views version history
  2. User clicks "Download" for specific version
  3. System retrieves that version file
  4. System sends file to browser
- **Postconditions:** Download logged with version information

**FR-VC-004: Compare Versions**
- **Description:** Users can compare two versions (for text-based documents)
- **Actors:** Users with read permission
- **Flow:**
  1. User selects two versions
  2. User clicks "Compare"
  3. System extracts text from both versions
  4. System performs diff comparison
  5. System displays side-by-side view with highlighting:
     - Green: Added text
     - Red: Removed text
     - Yellow: Modified text
- **Supported Formats:** TXT, PDF (text extraction), DOC/DOCX (limited)

**FR-VC-005: Rollback to Previous Version**
- **Description:** Users can restore a previous version as current
- **Actors:** Document owner or users with edit permission
- **Flow:**
  1. User views version history
  2. User clicks "Restore" for desired version
  3. System prompts for confirmation
  4. User confirms
  5. System creates new version (copy of selected version)
  6. System sets new version as current
- **Postconditions:** New version created (preserves history), audit log entry

**FR-VC-006: Version Comments**
- **Description:** Users must/can add comments when creating versions
- **Required:** Yes, minimum 10 characters
- **Display:** Shows in version history table
- **Examples:** "Updated financial figures", "Corrected typos", "Added new section"

### 5.5 Search and Retrieval

**FR-SR-001: Basic Search**
- **Description:** Users can perform keyword search across documents
- **Actors:** All authenticated users
- **Flow:**
  1. User enters search term in search box
  2. User clicks "Search" or presses Enter
  3. System searches:
     - Document titles
     - Descriptions
     - Tags
     - File content (via Lucene index)
  4. System displays results sorted by relevance
  5. System highlights matching terms
- **Search Scope:** Only documents user has permission to view
- **Result Display:**
  - Document title (link)
  - Snippet with highlighted keywords
  - Category
  - Author
  - Upload date
  - Relevance score

**FR-SR-002: Advanced Search**
- **Description:** Users can search with multiple criteria
- **Actors:** All authenticated users
- **Search Criteria:**
  - Keywords (full-text)
  - Document title (contains)
  - Category (dropdown, multiple select)
  - Tags (multi-select)
  - Author (autocomplete)
  - Date range (from/to date pickers)
  - File type (checkboxes: PDF, DOC, XLS, etc.)
  - File size (min/max in MB)
  - Access level
- **Boolean Operators:** AND, OR, NOT
- **Wildcards:** * for multiple characters, ? for single character
- **Flow:**
  1. User clicks "Advanced Search"
  2. User fills in desired criteria
  3. User clicks "Search"
  4. System builds complex query
  5. System executes search
  6. System displays results with faceted navigation

**FR-SR-003: Search Filters**
- **Description:** Users can refine search results using facets
- **Facets Displayed:**
  - Category (with document counts)
  - File Type (with document counts)
  - Author (top 10)
  - Date (Last 24 hours, Last week, Last month, Last year)
  - Tags (top 20)
- **Flow:**
  1. After initial search, facets appear in sidebar
  2. User clicks facet value
  3. System refines results
  4. System updates facet counts
  5. User can apply multiple facets

**FR-SR-004: Save Search**
- **Description:** Users can save frequently used searches
- **Actors:** All authenticated users
- **Flow:**
  1. User performs search (basic or advanced)
  2. User clicks "Save This Search"
  3. User enters search name
  4. System saves search criteria
  5. Search appears in user's "Saved Searches" list
- **Usage:** User clicks saved search to re-execute

**FR-SR-005: Search Result Sorting**
- **Description:** Users can sort search results
- **Sort Options:**
  - Relevance (default)
  - Title (A-Z, Z-A)
  - Upload Date (newest first, oldest first)
  - File Size (largest first, smallest first)
  - Author (A-Z, Z-A)
- **Flow:** User clicks column header or selects from dropdown

**FR-SR-006: Export Search Results**
- **Description:** Users can export search results to Excel
- **Actors:** All authenticated users
- **Flow:**
  1. User performs search
  2. User clicks "Export to Excel"
  3. System generates Excel file with:
     - Document title
     - Category
     - Author
     - Upload date
     - File size
     - Tags
  4. System sends file to browser
- **Business Rules:** Maximum 1000 results per export

### 5.6 Workflow Management

**FR-WF-001: Create Workflow Template**
- **Description:** Administrators can define reusable workflow templates
- **Actors:** Administrator
- **Workflow Components:**
  - Workflow name
  - Description
  - Steps (ordered sequence):
    - Step name
    - Approver role/user
    - Step type (Approval, Review, Acknowledgment)
    - Required/Optional
    - Due days (from previous step)
  - Routing rules (parallel, sequential, conditional)
- **Flow:**
  1. Admin navigates to "Workflow Management"
  2. Admin clicks "Create Workflow"
  3. Admin defines workflow details
  4. Admin adds steps
  5. Admin configures routing
  6. Admin saves workflow
- **Example Workflows:**
  - Document Approval (Submit → Manager Review → Director Approval → Publish)
  - Quality Review (Submit → QA Review → Corrections → Final Review)
  - Legal Review (Submit → Legal Check → Risk Assessment → Approval)

**FR-WF-002: Submit Document to Workflow**
- **Description:** Users can submit documents for workflow processing
- **Actors:** Users with submit permission
- **Flow:**
  1. User navigates to document
  2. User clicks "Submit for Approval"
  3. User selects workflow template
  4. User optionally specifies approvers (if template allows)
  5. User enters submission comments
  6. User clicks "Submit"
  7. System creates workflow instance
  8. System assigns first task
  9. System sends notification to first approver
  10. System locks document (read-only during workflow)
- **Postconditions:** Workflow initiated, notifications sent, document status = "In Workflow"

**FR-WF-003: Approve Workflow Task**
- **Description:** Assigned users can approve workflow tasks
- **Actors:** Users assigned to workflow task
- **Flow:**
  1. User receives notification
  2. User navigates to "My Tasks"
  3. User clicks on task
  4. System displays:
     - Document details
     - Workflow history
     - Current step information
  5. User reviews document
  6. User clicks "Approve"
  7. User enters approval comments
  8. User clicks "Confirm"
  9. System updates task status
  10. System advances to next step
  11. System notifies next approver
- **Business Rules:** Cannot approve own submission

**FR-WF-004: Reject Workflow Task**
- **Description:** Assigned users can reject workflow tasks
- **Actors:** Users assigned to workflow task
- **Flow:**
  1. User views task
  2. User clicks "Reject"
  3. User enters rejection reason (required)
  4. User clicks "Confirm"
  5. System updates task status
  6. System returns workflow to submitter
  7. System notifies submitter
  8. System unlocks document
- **Postconditions:** Document status = "Rejected", workflow ended

**FR-WF-005: Workflow Reassignment**
- **Description:** Users can reassign tasks to other users
- **Actors:** Users assigned to workflow task
- **Flow:**
  1. User views task
  2. User clicks "Reassign"
  3. User selects new assignee
  4. User enters reason
  5. System updates assignment
  6. System notifies new assignee
- **Business Rules:** Can only reassign within same role

**FR-WF-006: Workflow Cancellation**
- **Description:** Workflow initiator or admin can cancel workflow
- **Actors:** Workflow initiator, Administrator
- **Flow:**
  1. User navigates to workflow instance
  2. User clicks "Cancel Workflow"
  3. System prompts for reason
  4. User confirms
  5. System cancels all pending tasks
  6. System unlocks document
  7. System notifies all participants
- **Postconditions:** Workflow status = "Cancelled"

**FR-WF-007: Workflow Monitoring**
- **Description:** Users can monitor workflow progress
- **Actors:** Workflow participants, Administrators
- **Display:**
  - Workflow diagram with current step highlighted
  - Step history with timestamps
  - Pending tasks
  - Comments from each step
- **Access:** Submitter and all approvers can view

### 5.7 Comments and Annotations

**FR-CA-001: Add Comment to Document**
- **Description:** Users can add comments to documents
- **Actors:** Users with read permission
- **Flow:**
  1. User navigates to document details
  2. User scrolls to "Comments" section
  3. User enters comment text
  4. User clicks "Post Comment"
  5. System saves comment
  6. System displays comment with:
     - Author name
     - Timestamp
     - Comment text
  7. System notifies document owner (optional setting)
- **Business Rules:** Comments visible to all users with document access

**FR-CA-002: Reply to Comment**
- **Description:** Users can reply to existing comments (threading)
- **Actors:** Users with read permission
- **Flow:**
  1. User clicks "Reply" on comment
  2. User enters reply text
  3. User clicks "Post Reply"
  4. System saves reply
  5. System displays reply indented under parent comment
  6. System notifies original commenter

**FR-CA-003: Edit/Delete Own Comment**
- **Description:** Users can edit or delete their own comments
- **Actors:** Comment author
- **Flow:**
  1. User clicks "Edit" or "Delete" on own comment
  2. For edit: User modifies text and saves
  3. For delete: User confirms deletion
  4. System updates/removes comment
  5. System shows "edited" indicator (for edits)

**FR-CA-004: Document Annotations (Future Enhancement)**
- **Description:** Users can add annotations directly on PDF documents
- **Status:** Phase 2 feature
- **Capabilities:** Highlight text, add sticky notes, draw shapes

### 5.8 Notification System

**FR-NS-001: Email Notifications**
- **Description:** System sends email notifications for key events
- **Notification Triggers:**
  - Document uploaded in watched category
  - Document shared with user
  - Workflow task assigned
  - Workflow approved/rejected
  - Comment added to user's document
  - Document nearing expiration
  - Search results for saved search (daily digest)
- **Email Content:**
  - Subject line with event type
  - Document title and link
  - Event description
  - Actor (who triggered event)
  - Timestamp
  - Direct link to document/task
- **Configuration:** Users can enable/disable notification types in preferences

**FR-NS-002: In-App Notifications**
- **Description:** System displays notifications within application
- **Display:** Bell icon in header with badge count
- **Flow:**
  1. User clicks bell icon
  2. System displays dropdown with recent notifications
  3. User clicks notification
  4. System navigates to related item
  5. System marks notification as read
- **Notification List:**
  - Icon indicating type
  - Brief description
  - Timestamp (relative: "2 hours ago")
  - Read/unread indicator

**FR-NS-003: Notification Preferences**
- **Description:** Users can configure notification settings
- **Actors:** All authenticated users
- **Settings:**
  - Email notifications (on/off per type)
  - Email frequency (immediate, daily digest, weekly digest)
  - In-app notifications (on/off per type)
  - Watched categories (receive updates for documents)
- **Flow:**
  1. User navigates to "Settings" → "Notifications"
  2. User toggles preferences
  3. User saves
  4. System updates user preferences

### 5.9 Reporting and Analytics

**FR-RA-001: Document Activity Report**
- **Description:** Generate report of document activities
- **Actors:** Manager, Administrator
- **Parameters:**
  - Date range (from/to)
  - Category (optional filter)
  - Department (optional filter)
  - Activity types (uploads, downloads, edits, deletions)
- **Report Content:**
  - Total documents by category
  - Upload trends (chart)
  - Download statistics
  - Most active users
  - Most accessed documents
- **Output Formats:** PDF, Excel
- **Flow:**
  1. User navigates to "Reports" → "Document Activity"
  2. User selects parameters
  3. User clicks "Generate Report"
  4. System queries database
  5. System generates report (iText for PDF, POI for Excel)
  6. System displays report or prompts download

**FR-RA-002: User Activity Report**
- **Description:** Generate report of user activities
- **Actors:** Administrator
- **Report Content:**
  - User login history
  - Documents uploaded per user
  - Documents downloaded per user
  - Search queries per user
  - Workflow tasks completed per user
- **Output:** Table with charts, exportable to PDF/Excel

**FR-RA-003: Storage Utilization Report**
- **Description:** Show storage usage by category and department
- **Actors:** Administrator
- **Report Content:**
  - Total storage used
  - Storage by category (pie chart)
  - Storage by department (bar chart)
  - Storage by file type
  - Largest documents (top 100)
  - Growth trend (monthly)
- **Output:** Dashboard with charts, exportable

**FR-RA-004: Audit Trail Report**
- **Description:** Complete audit trail of all system activities
- **Actors:** Administrator, Auditor
- **Report Content:**
  - All logged events with:
    - Timestamp
    - User
    - Action (login, upload, download, edit, delete, etc.)
    - Resource (document ID/name)
    - IP address
    - Result (success/failure)
- **Filters:** Date range, user, action type, resource
- **Export:** Excel, CSV
- **Business Rules:** Read-only, cannot be modified or deleted

**FR-RA-005: Workflow Performance Report**
- **Description:** Analyze workflow efficiency
- **Actors:** Manager, Administrator
- **Metrics:**
  - Average completion time per workflow type
  - Workflows by status (pending, completed, rejected, cancelled)
  - Bottleneck identification (steps taking longest)
  - User performance (average approval time)
  - Overdue tasks
- **Output:** Dashboard with metrics and charts

**FR-RA-006: Search Analytics**
- **Description:** Analyze search patterns
- **Actors:** Administrator
- **Metrics:**
  - Top search terms
  - Searches with no results
  - Search to download conversion rate
  - Average search result count
- **Purpose:** Improve categorization and tagging

### 5.10 Administration

**FR-AD-001: System Configuration**
- **Description:** Administrators can configure system settings
- **Actors:** Administrator
- **Settings:**
  - **General:**
    - Application name
    - Support email
    - Session timeout (minutes)
    - Default language
  - **File Upload:**
    - Maximum file size (MB)
    - Allowed file extensions
    - Virus scanning (enabled/disabled)
    - Storage path
  - **Search:**
    - Results per page
    - Lucene index path
    - Index rebuild schedule
  - **Email:**
    - SMTP server
    - SMTP port
    - Username/password
    - From address
  - **Security:**
    - Password complexity rules
    - Password expiration (days)
    - Session timeout
    - Failed login attempts before lockout
  - **Workflow:**
    - Default approval timeout (days)
    - Email notifications enabled
- **Flow:**
  1. Admin navigates to "System Settings"
  2. Admin modifies settings
  3. Admin clicks "Save"
  4. System validates and updates
  5. System may require restart for some settings

**FR-AD-002: Category Hierarchy Management**
- **Description:** Create and manage document categories
- **See:** FR-CT-001, FR-CT-002

**FR-AD-003: Database Maintenance**
- **Description:** Perform database maintenance tasks
- **Actors:** Administrator
- **Tasks:**
  - Backup database (on-demand or scheduled)
  - Optimize tables
  - View database statistics
  - Purge old deleted documents
  - Rebuild search index
- **Flow:**
  1. Admin navigates to "System Maintenance"
  2. Admin selects task
  3. Admin clicks "Execute"
  4. System performs task
  5. System displays result/log

**FR-AD-004: View System Logs**
- **Description:** View application and error logs
- **Actors:** Administrator
- **Log Types:**
  - Application log (Log4j)
  - Error log
  - Audit log
  - Access log
- **Features:**
  - Filter by date, level (INFO, WARN, ERROR), logger
  - Search log content
  - Download log files

**FR-AD-005: License Management**
- **Description:** Manage user licenses
- **Actors:** Administrator
- **Display:**
  - Total licenses
  - Used licenses
  - Available licenses
  - License expiration date
- **Alerts:** Warn when 90% licenses used

---

## 6. Non-Functional Requirements

### 6.1 Performance Requirements

**NFR-PERF-001: Response Time**
- **Page Load Time:** < 2 seconds for standard pages (95th percentile)
- **Document Upload:** < 3 seconds for files up to 10MB
- **Document Download:** < 3 seconds for files up to 10MB
- **Search Results:** < 2 seconds for keyword search
- **Advanced Search:** < 5 seconds with multiple filters
- **Report Generation:** < 10 seconds for standard reports (< 1000 records)

**NFR-PERF-002: Throughput**
- **Concurrent Users:** Support 500 concurrent users
- **Peak Load:** Handle 1000 page requests per minute
- **Document Uploads:** Support 50 concurrent uploads
- **Search Queries:** Handle 100 search queries per minute

**NFR-PERF-003: Database Performance**
- **Query Execution:** < 1 second for 90% of queries
- **Connection Pool:** Minimum 10 connections, maximum 50 connections
- **Connection Timeout:** 30 seconds
- **Transaction Timeout:** 60 seconds
- **Index Optimization:** Maintain indexes on frequently queried columns

**NFR-PERF-004: File System Performance**
- **Storage:** Support up to 500GB of documents (100,000 files)
- **File Organization:** Hierarchical directory structure by year/month/day
- **Disk I/O:** Use buffered streams for file operations
- **Cleanup:** Scheduled job to remove orphaned files

**NFR-PERF-005: Search Index Performance**
- **Index Size:** Support indexing of 100,000+ documents
- **Index Update:** Near real-time (< 1 minute after document upload)
- **Index Rebuild:** Full rebuild completes within 4 hours
- **Search Index Location:** Separate disk from application/database

**NFR-PERF-006: Caching Strategy**
- **Second-Level Cache:** Enable Hibernate EHCache for:
  - User entities (1 hour TTL)
  - Role and Permission entities (24 hours TTL)
  - Category entities (4 hours TTL)
  - System configuration (1 hour TTL)
- **Query Cache:** Enable for frequently executed queries
- **Cache Eviction:** Automatic eviction on entity updates

**NFR-PERF-007: Memory Requirements**
- **JVM Heap Size:** Minimum 1GB, recommended 2GB
- **PermGen Size:** 256MB (Java 5 requirement)
- **Database Connection Pool:** Maximum 200MB
- **Lucene Index RAM:** Minimum 512MB for index operations

### 6.2 Scalability Requirements

**NFR-SCAL-001: Horizontal Scalability**
- **Application Servers:** Support load balancing across multiple Tomcat instances
- **Session Management:** Use database-based session persistence or sticky sessions
- **File Storage:** Use shared network storage (NFS, SAN) for multi-server deployment

**NFR-SCAL-002: Vertical Scalability**
- **CPU:** Application designed to utilize multi-core processors
- **Memory:** Efficient memory management, no memory leaks
- **Disk:** Support expansion of storage capacity without downtime

**NFR-SCAL-003: Data Growth**
- **Database:** Support database growth to 50GB+
- **Documents:** Handle 100,000+ documents initially, scalable to 1,000,000+
- **Users:** Support 5,000+ user accounts
- **Audit Logs:** Implement log rotation and archival strategy

### 6.3 Security Requirements

**NFR-SEC-001: Authentication**
- **Password Storage:** Passwords hashed using SHA-256 or better with salt
- **Session Management:** Secure session IDs, regenerate on login
- **Session Timeout:** Auto-logout after 30 minutes of inactivity
- **Account Lockout:** Lock account after 5 failed login attempts
- **Password Policy:**
  - Minimum 8 characters
  - At least 1 uppercase, 1 lowercase, 1 number, 1 special character
  - Cannot reuse last 3 passwords
  - Expires every 90 days (configurable)

**NFR-SEC-002: Authorization**
- **Role-Based Access Control (RBAC):** Enforce permissions at service layer
- **Document-Level Permissions:** Check access rights before any operation
- **Privilege Escalation Prevention:** Validate user cannot assign higher roles
- **Default Deny:** Deny access unless explicitly granted

**NFR-SEC-003: Data Protection**
- **Encryption at Rest:** Option to encrypt stored documents (AES-256)
- **Encryption in Transit:** HTTPS/TLS for all communications (SSL/TLS 1.2+)
- **Database Encryption:** Encrypt sensitive fields (passwords, SSNs if stored)
- **Backup Encryption:** Encrypt database and file backups

**NFR-SEC-004: Input Validation**
- **SQL Injection Prevention:** Use parameterized queries (Hibernate)
- **XSS Prevention:** Escape HTML output in JSPs
- **File Upload Validation:**
  - Validate file extension (whitelist)
  - Validate MIME type
  - Validate file size
  - Optional virus scanning integration
- **Path Traversal Prevention:** Validate and sanitize file paths
- **CSRF Protection:** Implement synchronizer token pattern

**NFR-SEC-005: Audit Logging**
- **Log All Security Events:**
  - Login/logout (successful and failed)
  - Permission changes
  - Document access (upload, download, view, edit, delete)
  - Configuration changes
  - User management actions
- **Log Fields:**
  - Timestamp (precise to millisecond)
  - User ID and username
  - Action performed
  - Resource affected
  - IP address
  - Session ID
  - Result (success/failure)
  - Error message (if failed)
- **Log Protection:** Audit logs immutable, only administrators can view
- **Log Retention:** Retain logs for minimum 1 year

**NFR-SEC-006: Secure Configuration**
- **Default Passwords:** No default passwords, force change on first login
- **Error Messages:** Generic error messages, no sensitive information
- **Directory Listing:** Disable directory browsing
- **HTTP Headers:** Set security headers (X-Frame-Options, X-Content-Type-Options)
- **Cookie Security:** Set HttpOnly and Secure flags on cookies

### 6.4 Reliability Requirements

**NFR-REL-001: Availability**
- **Uptime:** 99.5% availability during business hours (8 AM - 6 PM)
- **Planned Downtime:** Maintenance windows outside business hours
- **Recovery Time Objective (RTO):** < 4 hours
- **Recovery Point Objective (RPO):** < 24 hours (daily backups)

**NFR-REL-002: Fault Tolerance**
- **Database:** Connection pool with automatic reconnection
- **File System:** Graceful handling of file system errors
- **External Services:** Retry logic for email sending
- **Error Handling:** Catch and log all exceptions, display user-friendly messages

**NFR-REL-003: Data Integrity**
- **Transactions:** ACID compliance for database operations
- **File Integrity:** MD5 checksums for uploaded files
- **Referential Integrity:** Foreign key constraints in database
- **Validation:** Server-side validation for all inputs

**NFR-REL-004: Backup and Recovery**
- **Database Backup:** Automated daily backup, retain 30 days
- **File Backup:** Automated daily backup of document repository
- **Configuration Backup:** Backup of configuration files
- **Backup Verification:** Monthly restore tests
- **Disaster Recovery Plan:** Documented procedures for data recovery

### 6.5 Usability Requirements

**NFR-USE-001: User Interface**
- **Consistent Layout:** Standard header, navigation, and footer on all pages
- **Responsive Design:** Support minimum 1024x768 resolution
- **Browser Compatibility:**
  - Internet Explorer 8+ (primary target)
  - Firefox 3.6+
  - Chrome 10+
  - Safari 5+
- **Accessibility:** WCAG 2.0 Level A compliance
- **Language:** English (primary), extensible for localization

**NFR-USE-002: Navigation**
- **Menu Structure:** Clear hierarchical navigation menu
- **Breadcrumbs:** Display current location in hierarchy
- **Search Box:** Accessible from all pages (header)
- **Maximum Clicks:** Reach any feature within 3 clicks from home

**NFR-USE-003: User Feedback**
- **Loading Indicators:** Show progress for long-running operations
- **Success Messages:** Confirm successful actions (green banner)
- **Error Messages:** Clear error messages with suggested actions (red banner)
- **Validation Feedback:** Inline validation with field-level error messages
- **Help Text:** Tooltips and help icons for complex features

**NFR-USE-004: Forms**
- **Required Fields:** Clear indication with asterisk (*)
- **Field Labels:** Descriptive labels for all inputs
- **Default Values:** Sensible defaults where applicable
- **Auto-complete:** Browser auto-complete for appropriate fields
- **Tab Order:** Logical tab order through forms

**NFR-USE-005: Documentation**
- **User Manual:** Comprehensive PDF user guide
- **Online Help:** Context-sensitive help on each page
- **FAQ:** Frequently asked questions section
- **Video Tutorials:** Screen recordings for key workflows (optional)
- **Administrator Guide:** Separate guide for system administration

### 6.6 Maintainability Requirements

**NFR-MAIN-001: Code Quality**
- **Coding Standards:** Follow Java coding conventions
- **Code Comments:** JavaDoc for all public methods and classes
- **Complexity:** Maximum cyclomatic complexity of 10 per method
- **Code Duplication:** Minimize code duplication (DRY principle)
- **Static Analysis:** Pass FindBugs and PMD checks with zero high-priority issues

**NFR-MAIN-002: Logging**
- **Logging Framework:** Log4j with configurable levels
- **Log Levels:**
  - DEBUG: Detailed debugging information
  - INFO: General informational messages
  - WARN: Warning messages for recoverable issues
  - ERROR: Error messages for exceptions
  - FATAL: Critical failures
- **Log Files:**
  - application.log (INFO and above)
  - error.log (ERROR and FATAL only)
  - Rotate daily, compress, retain 30 days

**NFR-MAIN-003: Configuration**
- **Externalized Configuration:** All environment-specific settings in properties files
- **Configuration Files:**
  - hibernate.cfg.xml (database connection)
  - log4j.properties (logging configuration)
  - application.properties (application settings)
  - mail.properties (email configuration)
- **No Hardcoded Values:** No hardcoded IPs, passwords, or URLs in code

**NFR-MAIN-004: Database Schema**
- **Naming Conventions:**
  - Tables: lowercase with underscores (e.g., document_version)
  - Columns: lowercase with underscores (e.g., created_date)
  - Primary keys: id
  - Foreign keys: {table_name}_id (e.g., user_id)
- **Normalization:** Minimum 3NF (Third Normal Form)
- **Indexes:** Create indexes on foreign keys and frequently queried columns
- **Versioning:** Use database migration scripts (numbered sequentially)

**NFR-MAIN-005: Testing**
- **Unit Tests:** Minimum 70% code coverage
- **Integration Tests:** Test DAO layer with in-memory database
- **Automated Tests:** Run with Ant build
- **Test Data:** Use DBUnit for test data setup

### 6.7 Compatibility Requirements

**NFR-COMP-001: Java Version**
- **Java Version:** Java 1.5.0_22 (J2SE 5.0)
- **Compatibility:** Must not use features from Java 6+

**NFR-COMP-002: Application Server**
- **Tomcat Version:** Apache Tomcat 6.0.x (6.0.20 or higher)
- **Servlet Specification:** Servlet 2.5
- **JSP Specification:** JSP 2.1

**NFR-COMP-003: Database**
- **MySQL Version:** MySQL 5.7.x
- **JDBC Driver:** MySQL Connector/J 5.1.x
- **Character Set:** UTF-8 for international character support

**NFR-COMP-004: Browser Compatibility**
- **Primary Target:** Internet Explorer 8
- **Supported Browsers:**
  - IE 7, 8, 9
  - Firefox 3.6+
  - Chrome 10+
  - Safari 5+
- **JavaScript:** ES5 (ECMAScript 5)
- **No Flash/Silverlight:** HTML/JavaScript only

### 6.8 Operational Requirements

**NFR-OPS-001: Deployment**
- **Deployment Package:** Single WAR file
- **Deployment Method:** Deploy to Tomcat via manager or file copy
- **Configuration:** External configuration files (not in WAR)
- **Database Setup:** SQL scripts for schema creation and initial data

**NFR-OPS-002: Monitoring**
- **Application Monitoring:** Log file monitoring for errors
- **Health Check:** /health endpoint returning system status
- **Database Monitoring:** Connection pool statistics
- **Disk Space Monitoring:** Alert when storage 80% full
- **JMX:** Expose MBeans for Tomcat monitoring

**NFR-OPS-003: Scheduled Jobs**
- **Job Scheduler:** Quartz Scheduler
- **Scheduled Tasks:**
  - Lucene index optimization (daily at 2 AM)
  - Email digest for saved searches (daily at 7 AM)
  - Purge deleted documents (weekly on Sunday 3 AM)
  - Database backup (daily at 1 AM)
  - Session cleanup (hourly)
  - Workflow deadline notifications (daily at 9 AM)

**NFR-OPS-004: Email Configuration**
- **SMTP Support:** Support for SMTP servers with/without authentication
- **Email Templates:** HTML email templates for notifications
- **Retry Logic:** Retry failed emails up to 3 times
- **Email Queue:** Queue emails for asynchronous sending

---

## 7. Database Design

### 7.1 Entity Relationship Diagram

```
┌─────────────────┐         ┌──────────────────┐
│     USER        │         │      ROLE        │
├─────────────────┤         ├──────────────────┤
│ id (PK)         │         │ id (PK)          │
│ username        │         │ name             │
│ password_hash   │         │ description      │
│ full_name       │    ┌────┤ created_date     │
│ email           │    │    └──────────────────┘
│ phone           │    │              │
│ department      │    │              │
│ status          │    │              │
│ created_date    │    │              ▼
│ last_login      │    │    ┌──────────────────┐
└─────────────────┘    │    │  USER_ROLE       │
        │              │    ├──────────────────┤
        │              └────│ user_id (FK)     │
        │                   │ role_id (FK)     │
        │                   └──────────────────┘
        │                             │
        │                             ▼
        │                   ┌──────────────────┐
        │                   │ ROLE_PERMISSION  │
        │                   ├──────────────────┤
        │                   │ role_id (FK)     │
        │                   │ permission_id(FK)│
        │                   └──────────────────┘
        │                             │
        │                             ▼
        │                   ┌──────────────────┐
        │                   │   PERMISSION     │
        │                   ├──────────────────┤
        │                   │ id (PK)          │
        │                   │ name             │
        │                   │ resource         │
        │                   │ action           │
        │                   └──────────────────┘
        │
        │
        ├───────────────────────────────────────┐
        │                                       │
        ▼                                       ▼
┌─────────────────┐                  ┌──────────────────┐
│   DOCUMENT      │                  │   WORKFLOW       │
├─────────────────┤                  ├──────────────────┤
│ id (PK)         │                  │ id (PK)          │
│ title           │                  │ name             │
│ description     │                  │ description      │
│ file_name       │                  │ created_by (FK)  │
│ file_path       │                  │ created_date     │
│ file_size       │                  │ status           │
│ file_type       │                  └──────────────────┘
│ mime_type       │                            │
│ md5_checksum    │                            │
│ category_id(FK) │                            ▼
│ owner_id (FK)   │                  ┌──────────────────┐
│ status          │                  │  WORKFLOW_STEP   │
│ access_level    │                  ├──────────────────┤
│ version_number  │                  │ id (PK)          │
│ is_deleted      │                  │ workflow_id (FK) │
│ expiration_date │                  │ step_number      │
│ created_date    │                  │ step_name        │
│ updated_date    │                  │ step_type        │
│ created_by(FK)  │                  │ approver_role_id │
│ updated_by(FK)  │                  │ due_days         │
└─────────────────┘                  │ is_required      │
        │                            └──────────────────┘
        │
        ├───────────────┬────────────────┬──────────────┐
        │               │                │              │
        ▼               ▼                ▼              ▼
┌─────────────┐ ┌──────────────┐ ┌────────────┐ ┌──────────────┐
│ DOC_VERSION │ │ DOC_TAG      │ │ DOC_COMMENT│ │WORKFLOW_INST │
├─────────────┤ ├──────────────┤ ├────────────┤ ├──────────────┤
│ id (PK)     │ │ document_id  │ │ id (PK)    │ │ id (PK)      │
│ document_id │ │ tag_id       │ │ document_id│ │ workflow_id  │
│ version_num │ └──────────────┘ │ user_id(FK)│ │ document_id  │
│ file_name   │        │         │ comment    │ │ submitted_by │
│ file_path   │        ▼         │ parent_id  │ │ submit_date  │
│ file_size   │ ┌──────────────┐ │ created_dt │ │ status       │
│ md5_checksum│ │     TAG      │ └────────────┘ │ current_step │
│ comments    │ ├──────────────┤                └──────────────┘
│ created_by  │ │ id (PK)      │                      │
│ created_date│ │ name         │                      ▼
└─────────────┘ │ created_date │            ┌──────────────────┐
                └──────────────┘            │  WORKFLOW_TASK   │
                                            ├──────────────────┤
                                            │ id (PK)          │
┌─────────────────┐                        │ instance_id (FK) │
│   CATEGORY      │                        │ step_id (FK)     │
├─────────────────┤                        │ assigned_to (FK) │
│ id (PK)         │                        │ status           │
│ name            │                        │ assigned_date    │
│ description     │                        │ completed_date   │
│ parent_id (FK)  │◄──────────────────┐    │ comments         │
│ created_date    │                   │    │ due_date         │
└─────────────────┘                   │    └──────────────────┘
                                      │
                                      │
┌─────────────────┐                   │
│   AUDIT_LOG     │                   │
├─────────────────┤                   │
│ id (PK)         │                   │
│ user_id (FK)    │                   │
│ action          │                   │
│ resource_type   │                   │
│ resource_id     │                   │
│ ip_address      │                   │
│ session_id      │                   │
│ result          │                   │
│ error_message   │                   │
│ created_date    │                   │
└─────────────────┘                   │
                                      │
┌─────────────────┐                   │
│ NOTIFICATION    │                   │
├─────────────────┤                   │
│ id (PK)         │                   │
│ user_id (FK)    │                   │
│ type            │                   │
│ title           │                   │
│ message         │                   │
│ resource_type   │                   │
│ resource_id     │                   │
│ is_read         │                   │
│ created_date    │                   │
└─────────────────┘                   │
                                      │
┌─────────────────┐                   │
│ SYSTEM_CONFIG   │                   │
├─────────────────┤                   │
│ id (PK)         │                   │
│ config_key      │                   │
│ config_value    │                   │
│ description     │                   │
│ updated_date    │                   │
│ updated_by (FK) │───────────────────┘
└─────────────────┘
```

### 7.2 Table Definitions

#### 7.2.1 User Tables

**Table: user**
```sql
CREATE TABLE user (
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    username            VARCHAR(50) UNIQUE NOT NULL,
    password_hash       VARCHAR(128) NOT NULL,
    full_name           VARCHAR(100) NOT NULL,
    email               VARCHAR(100) UNIQUE NOT NULL,
    phone               VARCHAR(20),
    department          VARCHAR(100),
    profile_picture     VARCHAR(255),
    status              ENUM('ACTIVE', 'INACTIVE', 'LOCKED') DEFAULT 'ACTIVE',
    failed_login_count  INT DEFAULT 0,
    last_login_date     TIMESTAMP NULL,
    last_login_ip       VARCHAR(45),
    password_changed_date TIMESTAMP NULL,
    created_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by          INT,
    updated_by          INT,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: role**
```sql
CREATE TABLE role (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(50) UNIQUE NOT NULL,
    description     VARCHAR(255),
    is_system_role  BOOLEAN DEFAULT FALSE,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: permission**
```sql
CREATE TABLE permission (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(50) UNIQUE NOT NULL,
    resource        VARCHAR(50) NOT NULL,  -- e.g., 'DOCUMENT', 'USER', 'WORKFLOW'
    action          VARCHAR(20) NOT NULL,  -- e.g., 'CREATE', 'READ', 'UPDATE', 'DELETE'
    description     VARCHAR(255),
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_resource (resource)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: user_role**
```sql
CREATE TABLE user_role (
    user_id         INT NOT NULL,
    role_id         INT NOT NULL,
    assigned_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    assigned_by     INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_by) REFERENCES user(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: role_permission**
```sql
CREATE TABLE role_permission (
    role_id         INT NOT NULL,
    permission_id   INT NOT NULL,
    granted_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permission(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

#### 7.2.2 Document Tables

**Table: category**
```sql
CREATE TABLE category (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    parent_id       INT,
    path            VARCHAR(500),  -- Materialized path for hierarchy
    level           INT DEFAULT 0,
    display_order   INT DEFAULT 0,
    icon            VARCHAR(50),
    is_active       BOOLEAN DEFAULT TRUE,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by      INT,
    updated_by      INT,
    FOREIGN KEY (parent_id) REFERENCES category(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES user(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_parent (parent_id),
    INDEX idx_path (path(255)),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: document**
```sql
CREATE TABLE document (
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    title               VARCHAR(255) NOT NULL,
    description         TEXT,
    file_name           VARCHAR(255) NOT NULL,
    original_file_name  VARCHAR(255) NOT NULL,
    file_path           VARCHAR(500) NOT NULL,
    file_size           BIGINT NOT NULL,  -- in bytes
    file_type           VARCHAR(50) NOT NULL,  -- extension
    mime_type           VARCHAR(100) NOT NULL,
    md5_checksum        VARCHAR(32) NOT NULL,
    category_id         INT NOT NULL,
    owner_id            INT NOT NULL,
    department          VARCHAR(100),
    status              ENUM('DRAFT', 'ACTIVE', 'IN_WORKFLOW', 'ARCHIVED', 'DELETED') DEFAULT 'ACTIVE',
    access_level        ENUM('PUBLIC', 'PRIVATE', 'RESTRICTED') DEFAULT 'PRIVATE',
    version_number      INT DEFAULT 1,
    is_deleted          BOOLEAN DEFAULT FALSE,
    deleted_date        TIMESTAMP NULL,
    deleted_by          INT,
    expiration_date     DATE NULL,
    download_count      INT DEFAULT 0,
    view_count          INT DEFAULT 0,
    created_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by          INT NOT NULL,
    updated_by          INT,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE RESTRICT,
    FOREIGN KEY (owner_id) REFERENCES user(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES user(id) ON DELETE RESTRICT,
    FOREIGN KEY (updated_by) REFERENCES user(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_title (title),
    INDEX idx_category (category_id),
    INDEX idx_owner (owner_id),
    INDEX idx_status (status),
    INDEX idx_created_date (created_date),
    INDEX idx_is_deleted (is_deleted),
    FULLTEXT INDEX ft_title_desc (title, description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: document_version**
```sql
CREATE TABLE document_version (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    document_id     INT NOT NULL,
    version_number  INT NOT NULL,
    file_name       VARCHAR(255) NOT NULL,
    file_path       VARCHAR(500) NOT NULL,
    file_size       BIGINT NOT NULL,
    mime_type       VARCHAR(100) NOT NULL,
    md5_checksum    VARCHAR(32) NOT NULL,
    comments        TEXT,
    is_current      BOOLEAN DEFAULT FALSE,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by      INT NOT NULL,
    FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES user(id) ON DELETE RESTRICT,
    UNIQUE KEY uk_doc_version (document_id, version_number),
    INDEX idx_document (document_id),
    INDEX idx_is_current (is_current),
    INDEX idx_created_date (created_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: tag**
```sql
CREATE TABLE tag (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(50) UNIQUE NOT NULL,
    usage_count     INT DEFAULT 0,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_usage_count (usage_count)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: document_tag**
```sql
CREATE TABLE document_tag (
    document_id     INT NOT NULL,
    tag_id          INT NOT NULL,
    tagged_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tagged_by       INT,
    PRIMARY KEY (document_id, tag_id),
    FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tag(id) ON DELETE CASCADE,
    FOREIGN KEY (tagged_by) REFERENCES user(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: document_comment**
```sql
CREATE TABLE document_comment (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    document_id     INT NOT NULL,
    user_id         INT NOT NULL,
    parent_id       INT,  -- For threaded comments
    comment_text    TEXT NOT NULL,
    is_deleted      BOOLEAN DEFAULT FALSE,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE RESTRICT,
    FOREIGN KEY (parent_id) REFERENCES document_comment(id) ON DELETE CASCADE,
    INDEX idx_document (document_id),
    INDEX idx_parent (parent_id),
    INDEX idx_created_date (created_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: document_permission**
```sql
CREATE TABLE document_permission (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    document_id     INT NOT NULL,
    user_id         INT,
    role_id         INT,
    permission_type ENUM('READ', 'WRITE', 'DELETE', 'SHARE') NOT NULL,
    granted_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    granted_by      INT,
    FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
    FOREIGN KEY (granted_by) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_document (document_id),
    INDEX idx_user (user_id),
    INDEX idx_role (role_id),
    CHECK (user_id IS NOT NULL OR role_id IS NOT NULL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

#### 7.2.3 Workflow Tables

**Table: workflow**
```sql
CREATE TABLE workflow (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100) UNIQUE NOT NULL,
    description     TEXT,
    is_active       BOOLEAN DEFAULT TRUE,
    is_system       BOOLEAN DEFAULT FALSE,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by      INT NOT NULL,
    updated_by      INT,
    FOREIGN KEY (created_by) REFERENCES user(id) ON DELETE RESTRICT,
    FOREIGN KEY (updated_by) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_name (name),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: workflow_step**
```sql
CREATE TABLE workflow_step (
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    workflow_id         INT NOT NULL,
    step_number         INT NOT NULL,
    step_name           VARCHAR(100) NOT NULL,
    step_type           ENUM('APPROVAL', 'REVIEW', 'ACKNOWLEDGMENT') NOT NULL,
    approver_role_id    INT,
    approver_user_id    INT,
    is_required         BOOLEAN DEFAULT TRUE,
    due_days            INT DEFAULT 7,
    allow_reassign      BOOLEAN DEFAULT TRUE,
    created_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (workflow_id) REFERENCES workflow(id) ON DELETE CASCADE,
    FOREIGN KEY (approver_role_id) REFERENCES role(id) ON DELETE RESTRICT,
    FOREIGN KEY (approver_user_id) REFERENCES user(id) ON DELETE RESTRICT,
    UNIQUE KEY uk_workflow_step (workflow_id, step_number),
    INDEX idx_workflow (workflow_id),
    CHECK (approver_role_id IS NOT NULL OR approver_user_id IS NOT NULL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: workflow_instance**
```sql
CREATE TABLE workflow_instance (
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    workflow_id         INT NOT NULL,
    document_id         INT NOT NULL,
    submitted_by        INT NOT NULL,
    submit_date         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status              ENUM('PENDING', 'IN_PROGRESS', 'APPROVED', 'REJECTED', 'CANCELLED') DEFAULT 'PENDING',
    current_step_number INT,
    completed_date      TIMESTAMP NULL,
    completed_by        INT,
    comments            TEXT,
    FOREIGN KEY (workflow_id) REFERENCES workflow(id) ON DELETE RESTRICT,
    FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
    FOREIGN KEY (submitted_by) REFERENCES user(id) ON DELETE RESTRICT,
    FOREIGN KEY (completed_by) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_workflow (workflow_id),
    INDEX idx_document (document_id),
    INDEX idx_status (status),
    INDEX idx_submitted_by (submitted_by),
    INDEX idx_submit_date (submit_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: workflow_task**
```sql
CREATE TABLE workflow_task (
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    workflow_instance_id INT NOT NULL,
    workflow_step_id    INT NOT NULL,
    assigned_to         INT NOT NULL,
    assigned_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date            TIMESTAMP NOT NULL,
    status              ENUM('PENDING', 'IN_PROGRESS', 'APPROVED', 'REJECTED', 'REASSIGNED') DEFAULT 'PENDING',
    completed_date      TIMESTAMP NULL,
    comments            TEXT,
    reassigned_from     INT,
    reassigned_to       INT,
    FOREIGN KEY (workflow_instance_id) REFERENCES workflow_instance(id) ON DELETE CASCADE,
    FOREIGN KEY (workflow_step_id) REFERENCES workflow_step(id) ON DELETE RESTRICT,
    FOREIGN KEY (assigned_to) REFERENCES user(id) ON DELETE RESTRICT,
    FOREIGN KEY (reassigned_from) REFERENCES user(id) ON DELETE SET NULL,
    FOREIGN KEY (reassigned_to) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_instance (workflow_instance_id),
    INDEX idx_assigned_to (assigned_to),
    INDEX idx_status (status),
    INDEX idx_due_date (due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

#### 7.2.4 System Tables

**Table: audit_log**
```sql
CREATE TABLE audit_log (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id         INT,
    username        VARCHAR(50),  -- Denormalized for historical record
    action          VARCHAR(50) NOT NULL,  -- LOGIN, LOGOUT, UPLOAD, DOWNLOAD, etc.
    resource_type   VARCHAR(50),  -- DOCUMENT, USER, WORKFLOW, etc.
    resource_id     INT,
    resource_name   VARCHAR(255),  -- Denormalized
    ip_address      VARCHAR(45),
    session_id      VARCHAR(50),
    result          ENUM('SUCCESS', 'FAILURE') NOT NULL,
    error_message   TEXT,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_user (user_id),
    INDEX idx_action (action),
    INDEX idx_created_date (created_date),
    INDEX idx_resource (resource_type, resource_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: notification**
```sql
CREATE TABLE notification (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    user_id         INT NOT NULL,
    type            VARCHAR(50) NOT NULL,  -- DOCUMENT_SHARED, TASK_ASSIGNED, etc.
    title           VARCHAR(255) NOT NULL,
    message         TEXT NOT NULL,
    resource_type   VARCHAR(50),
    resource_id     INT,
    is_read         BOOLEAN DEFAULT FALSE,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_date       TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    INDEX idx_user (user_id),
    INDEX idx_is_read (is_read),
    INDEX idx_created_date (created_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: system_config**
```sql
CREATE TABLE system_config (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    config_key      VARCHAR(100) UNIQUE NOT NULL,
    config_value    TEXT NOT NULL,
    description     VARCHAR(255),
    data_type       ENUM('STRING', 'INTEGER', 'BOOLEAN', 'DATE') DEFAULT 'STRING',
    is_encrypted    BOOLEAN DEFAULT FALSE,
    updated_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by      INT,
    FOREIGN KEY (updated_by) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_config_key (config_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: user_preference**
```sql
CREATE TABLE user_preference (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    user_id         INT NOT NULL,
    pref_key        VARCHAR(100) NOT NULL,
    pref_value      TEXT NOT NULL,
    updated_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_pref (user_id, pref_key),
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Table: saved_search**
```sql
CREATE TABLE saved_search (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    user_id         INT NOT NULL,
    search_name     VARCHAR(100) NOT NULL,
    search_criteria TEXT NOT NULL,  -- JSON or serialized object
    is_public       BOOLEAN DEFAULT FALSE,
    usage_count     INT DEFAULT 0,
    created_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    INDEX idx_user (user_id),
    INDEX idx_public (is_public)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

### 7.3 Initial Data

**Default Roles:**
```sql
INSERT INTO role (name, description, is_system_role) VALUES
('ROLE_ADMIN', 'System Administrator', TRUE),
('ROLE_MANAGER', 'Department Manager', TRUE),
('ROLE_USER', 'Regular User', TRUE),
('ROLE_AUDITOR', 'Auditor (Read-only)', TRUE),
('ROLE_GUEST', 'Guest (Limited access)', TRUE);
```

**Default Permissions:**
```sql
INSERT INTO permission (name, resource, action, description) VALUES
-- Document permissions
('DOCUMENT_CREATE', 'DOCUMENT', 'CREATE', 'Create new documents'),
('DOCUMENT_READ', 'DOCUMENT', 'READ', 'View documents'),
('DOCUMENT_UPDATE', 'DOCUMENT', 'UPDATE', 'Edit documents'),
('DOCUMENT_DELETE', 'DOCUMENT', 'DELETE', 'Delete documents'),
-- User permissions
('USER_CREATE', 'USER', 'CREATE', 'Create new users'),
('USER_READ', 'USER', 'READ', 'View user information'),
('USER_UPDATE', 'USER', 'UPDATE', 'Edit user information'),
('USER_DELETE', 'USER', 'DELETE', 'Delete users'),
-- Workflow permissions
('WORKFLOW_CREATE', 'WORKFLOW', 'CREATE', 'Create workflow templates'),
('WORKFLOW_READ', 'WORKFLOW', 'READ', 'View workflows'),
('WORKFLOW_UPDATE', 'WORKFLOW', 'UPDATE', 'Edit workflows'),
('WORKFLOW_DELETE', 'WORKFLOW', 'DELETE', 'Delete workflows'),
('WORKFLOW_APPROVE', 'WORKFLOW', 'APPROVE', 'Approve workflow tasks'),
-- Report permissions
('REPORT_VIEW', 'REPORT', 'READ', 'View reports'),
('REPORT_EXPORT', 'REPORT', 'EXPORT', 'Export reports'),
-- System permissions
('SYSTEM_CONFIG', 'SYSTEM', 'UPDATE', 'Modify system configuration'),
('AUDIT_LOG_VIEW', 'AUDIT', 'READ', 'View audit logs');
```

**Default Admin User:**
```sql
-- Password: Admin@123 (SHA-256 hashed)
INSERT INTO user (username, password_hash, full_name, email, status) VALUES
('admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
 'System Administrator', 'admin@example.com', 'ACTIVE');

INSERT INTO user_role (user_id, role_id) VALUES (1, 1);
```

**Default Categories:**
```sql
INSERT INTO category (name, description, level, display_order) VALUES
('General', 'General documents', 0, 1),
('Financial', 'Financial documents', 0, 2),
('HR', 'Human Resources documents', 0, 3),
('Legal', 'Legal documents', 0, 4),
('Technical', 'Technical documentation', 0, 5),
('Marketing', 'Marketing materials', 0, 6);
```

**System Configuration:**
```sql
INSERT INTO system_config (config_key, config_value, description, data_type) VALUES
('app.name', 'Enterprise Document Management System', 'Application name', 'STRING'),
('app.version', '1.0', 'Application version', 'STRING'),
('file.upload.max_size', '52428800', 'Maximum file size in bytes (50MB)', 'INTEGER'),
('file.upload.allowed_extensions', 'pdf,doc,docx,xls,xlsx,ppt,pptx,txt,jpg,png,gif', 'Allowed file extensions', 'STRING'),
('session.timeout', '30', 'Session timeout in minutes', 'INTEGER'),
('password.min_length', '8', 'Minimum password length', 'INTEGER'),
('password.expiry_days', '90', 'Password expiry in days', 'INTEGER'),
('login.max_failed_attempts', '5', 'Maximum failed login attempts', 'INTEGER'),
('email.enabled', 'false', 'Email notifications enabled', 'BOOLEAN'),
('search.results_per_page', '20', 'Search results per page', 'INTEGER');
```

---

## 8. Application Design

### 8.1 Domain Model Classes

#### 8.1.1 Document.java
```java
package com.example.edms.model;

import java.util.Date;
import java.util.Set;
import java.util.HashSet;

/**
 * Domain model for Document entity
 */
public class Document {
    private Integer id;
    private String title;
    private String description;
    private String fileName;
    private String originalFileName;
    private String filePath;
    private Long fileSize;
    private String fileType;
    private String mimeType;
    private String md5Checksum;

    // Associations
    private Category category;
    private User owner;
    private Set<Tag> tags = new HashSet<Tag>();
    private Set<DocumentVersion> versions = new HashSet<DocumentVersion>();
    private Set<DocumentComment> comments = new HashSet<DocumentComment>();

    // Metadata
    private String department;
    private String status;  // DRAFT, ACTIVE, IN_WORKFLOW, ARCHIVED, DELETED
    private String accessLevel;  // PUBLIC, PRIVATE, RESTRICTED
    private Integer versionNumber;
    private Boolean isDeleted;
    private Date deletedDate;
    private User deletedBy;
    private Date expirationDate;
    private Integer downloadCount;
    private Integer viewCount;
    private Date createdDate;
    private Date updatedDate;
    private User createdBy;
    private User updatedBy;

    // Constructors
    public Document() {}

    public Document(String title, String fileName, Category category, User owner) {
        this.title = title;
        this.fileName = fileName;
        this.category = category;
        this.owner = owner;
        this.versionNumber = 1;
        this.isDeleted = false;
        this.downloadCount = 0;
        this.viewCount = 0;
        this.status = "ACTIVE";
        this.accessLevel = "PRIVATE";
        this.createdDate = new Date();
    }

    // Business methods
    public void incrementDownloadCount() {
        this.downloadCount++;
    }

    public void incrementViewCount() {
        this.viewCount++;
    }

    public void incrementVersion() {
        this.versionNumber++;
    }

    public boolean isAccessibleBy(User user) {
        if (this.owner.equals(user)) return true;
        if ("PUBLIC".equals(this.accessLevel)) return true;
        // Additional permission checks would go here
        return false;
    }

    public void addTag(Tag tag) {
        this.tags.add(tag);
        tag.incrementUsageCount();
    }

    public void removeTag(Tag tag) {
        this.tags.remove(tag);
        tag.decrementUsageCount();
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }

    public String getOriginalFileName() { return originalFileName; }
    public void setOriginalFileName(String originalFileName) { this.originalFileName = originalFileName; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public Long getFileSize() { return fileSize; }
    public void setFileSize(Long fileSize) { this.fileSize = fileSize; }

    public String getFileType() { return fileType; }
    public void setFileType(String fileType) { this.fileType = fileType; }

    public String getMimeType() { return mimeType; }
    public void setMimeType(String mimeType) { this.mimeType = mimeType; }

    public String getMd5Checksum() { return md5Checksum; }
    public void setMd5Checksum(String md5Checksum) { this.md5Checksum = md5Checksum; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }

    public User getOwner() { return owner; }
    public void setOwner(User owner) { this.owner = owner; }

    public Set<Tag> getTags() { return tags; }
    public void setTags(Set<Tag> tags) { this.tags = tags; }

    public Set<DocumentVersion> getVersions() { return versions; }
    public void setVersions(Set<DocumentVersion> versions) { this.versions = versions; }

    public Set<DocumentComment> getComments() { return comments; }
    public void setComments(Set<DocumentComment> comments) { this.comments = comments; }

    // ... remaining getters/setters
}
```

#### 8.1.2 User.java
```java
package com.example.edms.model;

import java.util.Date;
import java.util.Set;
import java.util.HashSet;

public class User {
    private Integer id;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private String phone;
    private String department;
    private String profilePicture;
    private String status;  // ACTIVE, INACTIVE, LOCKED
    private Integer failedLoginCount;
    private Date lastLoginDate;
    private String lastLoginIp;
    private Date passwordChangedDate;
    private Date createdDate;
    private Date updatedDate;
    private User createdBy;
    private User updatedBy;

    // Associations
    private Set<Role> roles = new HashSet<Role>();
    private Set<Document> ownedDocuments = new HashSet<Document>();

    // Constructors
    public User() {}

    public User(String username, String passwordHash, String fullName, String email) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.email = email;
        this.status = "ACTIVE";
        this.failedLoginCount = 0;
        this.createdDate = new Date();
    }

    // Business methods
    public boolean hasRole(String roleName) {
        for (Role role : roles) {
            if (role.getName().equals(roleName)) {
                return true;
            }
        }
        return false;
    }

    public boolean hasPermission(String permissionName) {
        for (Role role : roles) {
            for (Permission perm : role.getPermissions()) {
                if (perm.getName().equals(permissionName)) {
                    return true;
                }
            }
        }
        return false;
    }

    public void incrementFailedLoginCount() {
        this.failedLoginCount++;
        if (this.failedLoginCount >= 5) {
            this.status = "LOCKED";
        }
    }

    public void resetFailedLoginCount() {
        this.failedLoginCount = 0;
    }

    public void recordLogin(String ipAddress) {
        this.lastLoginDate = new Date();
        this.lastLoginIp = ipAddress;
        this.resetFailedLoginCount();
    }

    public boolean isActive() {
        return "ACTIVE".equals(this.status);
    }

    public boolean isLocked() {
        return "LOCKED".equals(this.status);
    }

    public void addRole(Role role) {
        this.roles.add(role);
    }

    public void removeRole(Role role) {
        this.roles.remove(role);
    }

    // Getters and Setters
    // ... (standard getters/setters for all fields)
}
```

### 8.2 DAO Layer Design

#### 8.2.1 DocumentDAO.java
```java
package com.example.edms.dao;

import com.example.edms.model.Document;
import java.util.List;
import java.util.Map;

/**
 * DAO interface for Document entity
 */
public interface DocumentDAO {

    /**
     * Save or update document
     */
    void saveOrUpdate(Document document);

    /**
     * Find document by ID
     */
    Document findById(Integer id);

    /**
     * Find all documents (with pagination)
     */
    List<Document> findAll(int offset, int limit);

    /**
     * Find documents by category
     */
    List<Document> findByCategory(Integer categoryId, int offset, int limit);

    /**
     * Find documents by owner
     */
    List<Document> findByOwner(Integer userId, int offset, int limit);

    /**
     * Find documents by status
     */
    List<Document> findByStatus(String status, int offset, int limit);

    /**
     * Search documents by criteria
     */
    List<Document> search(Map<String, Object> criteria, int offset, int limit);

    /**
     * Count documents by criteria
     */
    long count(Map<String, Object> criteria);

    /**
     * Delete document (soft delete)
     */
    void softDelete(Integer documentId, Integer userId);

    /**
     * Permanently delete document
     */
    void delete(Integer documentId);

    /**
     * Find documents expiring soon
     */
    List<Document> findExpiringSoon(int days);

    /**
     * Find most downloaded documents
     */
    List<Document> findMostDownloaded(int limit);

    /**
     * Update download count
     */
    void incrementDownloadCount(Integer documentId);

    /**
     * Update view count
     */
    void incrementViewCount(Integer documentId);
}
```

#### 8.2.2 DocumentDAOImpl.java
```java
package com.example.edms.dao.impl;

import com.example.edms.dao.DocumentDAO;
import com.example.edms.model.Document;
import com.example.edms.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Query;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import java.util.List;
import java.util.Map;
import java.util.Date;

public class DocumentDAOImpl implements DocumentDAO {

    public void saveOrUpdate(Document document) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();

            if (document.getId() == null) {
                session.save(document);
            } else {
                session.update(document);
            }

            session.getTransaction().commit();
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw new RuntimeException("Error saving document", e);
        }
    }

    public Document findById(Integer id) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();

            Document document = (Document) session.get(Document.class, id);

            session.getTransaction().commit();
            return document;
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw new RuntimeException("Error finding document", e);
        }
    }

    public List<Document> findAll(int offset, int limit) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();

            Criteria criteria = session.createCriteria(Document.class);
            criteria.add(Restrictions.eq("isDeleted", false));
            criteria.addOrder(Order.desc("createdDate"));
            criteria.setFirstResult(offset);
            criteria.setMaxResults(limit);

            List<Document> documents = criteria.list();

            session.getTransaction().commit();
            return documents;
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw new RuntimeException("Error finding documents", e);
        }
    }

    public List<Document> findByCategory(Integer categoryId, int offset, int limit) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();

            Criteria criteria = session.createCriteria(Document.class);
            criteria.add(Restrictions.eq("isDeleted", false));
            criteria.add(Restrictions.eq("category.id", categoryId));
            criteria.addOrder(Order.desc("createdDate"));
            criteria.setFirstResult(offset);
            criteria.setMaxResults(limit);

            List<Document> documents = criteria.list();

            session.getTransaction().commit();
            return documents;
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw new RuntimeException("Error finding documents by category", e);
        }
    }

    public List<Document> search(Map<String, Object> criteria, int offset, int limit) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();

            Criteria hibernateCriteria = session.createCriteria(Document.class);
            hibernateCriteria.add(Restrictions.eq("isDeleted", false));

            // Apply search criteria
            if (criteria.containsKey("title")) {
                hibernateCriteria.add(Restrictions.ilike("title", "%" + criteria.get("title") + "%"));
            }
            if (criteria.containsKey("categoryId")) {
                hibernateCriteria.add(Restrictions.eq("category.id", criteria.get("categoryId")));
            }
            if (criteria.containsKey("ownerId")) {
                hibernateCriteria.add(Restrictions.eq("owner.id", criteria.get("ownerId")));
            }
            if (criteria.containsKey("fromDate")) {
                hibernateCriteria.add(Restrictions.ge("createdDate", criteria.get("fromDate")));
            }
            if (criteria.containsKey("toDate")) {
                hibernateCriteria.add(Restrictions.le("createdDate", criteria.get("toDate")));
            }

            hibernateCriteria.addOrder(Order.desc("createdDate"));
            hibernateCriteria.setFirstResult(offset);
            hibernateCriteria.setMaxResults(limit);

            List<Document> documents = hibernateCriteria.list();

            session.getTransaction().commit();
            return documents;
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw new RuntimeException("Error searching documents", e);
        }
    }

    public long count(Map<String, Object> criteria) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();

            Criteria hibernateCriteria = session.createCriteria(Document.class);
            hibernateCriteria.add(Restrictions.eq("isDeleted", false));

            // Apply same criteria as search method
            // ... (similar to search method)

            hibernateCriteria.setProjection(Projections.rowCount());
            Long count = (Long) hibernateCriteria.uniqueResult();

            session.getTransaction().commit();
            return count;
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw new RuntimeException("Error counting documents", e);
        }
    }

    public void softDelete(Integer documentId, Integer userId) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();

            Document document = (Document) session.get(Document.class, documentId);
            if (document != null) {
                document.setIsDeleted(true);
                document.setDeletedDate(new Date());
                // Set deletedBy user
                session.update(document);
            }

            session.getTransaction().commit();
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw new RuntimeException("Error soft deleting document", e);
        }
    }

    public void incrementDownloadCount(Integer documentId) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();

            String hql = "UPDATE Document SET downloadCount = downloadCount + 1 WHERE id = :id";
            Query query = session.createQuery(hql);
            query.setInteger("id", documentId);
            query.executeUpdate();

            session.getTransaction().commit();
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw new RuntimeException("Error incrementing download count", e);
        }
    }

    // Additional methods implementation...
}
```

### 8.3 Service Layer Design

#### 8.3.1 DocumentService.java
```java
package com.example.edms.service;

import com.example.edms.model.Document;
import com.example.edms.dto.DocumentDTO;
import com.example.edms.exception.DocumentNotFoundException;
import com.example.edms.exception.UnauthorizedAccessException;
import org.apache.commons.fileupload.FileItem;
import java.util.List;
import java.util.Map;
import java.io.InputStream;

/**
 * Service interface for document operations
 */
public interface DocumentService {

    /**
     * Upload a new document
     */
    Document uploadDocument(FileItem fileItem, Map<String, String> metadata, Integer userId)
        throws Exception;

    /**
     * Upload new version of existing document
     */
    Document uploadNewVersion(Integer documentId, FileItem fileItem,
                             String comments, Integer userId) throws Exception;

    /**
     * Download document
     */
    InputStream downloadDocument(Integer documentId, Integer userId)
        throws DocumentNotFoundException, UnauthorizedAccessException;

    /**
     * Get document details
     */
    DocumentDTO getDocumentDetails(Integer documentId, Integer userId)
        throws DocumentNotFoundException, UnauthorizedAccessException;

    /**
     * Update document metadata
     */
    void updateMetadata(Integer documentId, Map<String, String> metadata, Integer userId)
        throws DocumentNotFoundException, UnauthorizedAccessException;

    /**
     * Delete document (soft delete)
     */
    void deleteDocument(Integer documentId, Integer userId)
        throws DocumentNotFoundException, UnauthorizedAccessException;

    /**
     * Permanently delete document
     */
    void permanentlyDeleteDocument(Integer documentId, Integer userId)
        throws DocumentNotFoundException, UnauthorizedAccessException;

    /**
     * Restore deleted document
     */
    void restoreDocument(Integer documentId, Integer userId)
        throws DocumentNotFoundException, UnauthorizedAccessException;

    /**
     * Search documents
     */
    List<DocumentDTO> searchDocuments(Map<String, Object> criteria,
                                     int page, int pageSize, Integer userId);

    /**
     * Get documents by category
     */
    List<DocumentDTO> getDocumentsByCategory(Integer categoryId,
                                            int page, int pageSize, Integer userId);

    /**
     * Get my documents
     */
    List<DocumentDTO> getMyDocuments(Integer userId, int page, int pageSize);

    /**
     * Get recent documents
     */
    List<DocumentDTO> getRecentDocuments(Integer userId, int limit);

    /**
     * Add tag to document
     */
    void addTag(Integer documentId, String tagName, Integer userId)
        throws DocumentNotFoundException, UnauthorizedAccessException;

    /**
     * Remove tag from document
     */
    void removeTag(Integer documentId, Integer tagId, Integer userId)
        throws DocumentNotFoundException, UnauthorizedAccessException;

    /**
     * Check user access to document
     */
    boolean hasAccess(Integer documentId, Integer userId, String permission);

    /**
     * Get document count
     */
    long getDocumentCount(Map<String, Object> criteria);
}
```

#### 8.3.2 DocumentServiceImpl.java
```java
package com.example.edms.service.impl;

import com.example.edms.service.DocumentService;
import com.example.edms.service.SecurityService;
import com.example.edms.service.SearchService;
import com.example.edms.dao.DocumentDAO;
import com.example.edms.dao.DocumentVersionDAO;
import com.example.edms.dao.CategoryDAO;
import com.example.edms.dao.UserDAO;
import com.example.edms.model.*;
import com.example.edms.dto.DocumentDTO;
import com.example.edms.util.FileUtil;
import com.example.edms.exception.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import java.io.*;
import java.util.*;

public class DocumentServiceImpl implements DocumentService {

    private static final Logger logger = Logger.getLogger(DocumentServiceImpl.class);

    private DocumentDAO documentDAO;
    private DocumentVersionDAO versionDAO;
    private CategoryDAO categoryDAO;
    private UserDAO userDAO;
    private SecurityService securityService;
    private SearchService searchService;

    // Dependency injection via setters
    public void setDocumentDAO(DocumentDAO documentDAO) {
        this.documentDAO = documentDAO;
    }

    public void setVersionDAO(DocumentVersionDAO versionDAO) {
        this.versionDAO = versionDAO;
    }

    public void setCategoryDAO(CategoryDAO categoryDAO) {
        this.categoryDAO = categoryDAO;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public void setSecurityService(SecurityService securityService) {
        this.securityService = securityService;
    }

    public void setSearchService(SearchService searchService) {
        this.searchService = searchService;
    }

    public Document uploadDocument(FileItem fileItem, Map<String, String> metadata,
                                  Integer userId) throws Exception {
        logger.info("Uploading document for user: " + userId);

        // Validate file
        FileUtil.validateFile(fileItem);

        // Get user
        User user = userDAO.findById(userId);
        if (user == null) {
            throw new IllegalArgumentException("User not found: " + userId);
        }

        // Get category
        Integer categoryId = Integer.parseInt(metadata.get("categoryId"));
        Category category = categoryDAO.findById(categoryId);
        if (category == null) {
            throw new IllegalArgumentException("Category not found: " + categoryId);
        }

        // Create document entity
        Document document = new Document();
        document.setTitle(metadata.get("title"));
        document.setDescription(metadata.get("description"));
        document.setCategory(category);
        document.setOwner(user);
        document.setCreatedBy(user);
        document.setDepartment(user.getDepartment());
        document.setAccessLevel(metadata.get("accessLevel"));

        // File information
        String originalFileName = fileItem.getName();
        document.setOriginalFileName(originalFileName);
        document.setFileSize(fileItem.getSize());
        document.setMimeType(fileItem.getContentType());
        document.setFileType(FileUtil.getFileExtension(originalFileName));

        // Generate unique filename and save file
        String uniqueFileName = FileUtil.generateUniqueFileName(originalFileName);
        String filePath = FileUtil.saveFile(fileItem, uniqueFileName);
        document.setFileName(uniqueFileName);
        document.setFilePath(filePath);

        // Calculate MD5 checksum
        String md5 = FileUtil.calculateMD5(new File(filePath));
        document.setMd5Checksum(md5);

        // Save to database
        documentDAO.saveOrUpdate(document);

        // Create initial version
        DocumentVersion version = new DocumentVersion();
        version.setDocument(document);
        version.setVersionNumber(1);
        version.setFileName(uniqueFileName);
        version.setFilePath(filePath);
        version.setFileSize(fileItem.getSize());
        version.setMimeType(fileItem.getContentType());
        version.setMd5Checksum(md5);
        version.setComments("Initial version");
        version.setIsCurrent(true);
        version.setCreatedBy(user);
        versionDAO.saveOrUpdate(version);

        // Index for search
        try {
            searchService.indexDocument(document);
        } catch (Exception e) {
            logger.error("Error indexing document", e);
            // Don't fail the upload if indexing fails
        }

        logger.info("Document uploaded successfully: " + document.getId());
        return document;
    }

    public InputStream downloadDocument(Integer documentId, Integer userId)
            throws DocumentNotFoundException, UnauthorizedAccessException {
        logger.info("Downloading document " + documentId + " for user " + userId);

        // Get document
        Document document = documentDAO.findById(documentId);
        if (document == null || document.getIsDeleted()) {
            throw new DocumentNotFoundException("Document not found: " + documentId);
        }

        // Check access
        if (!hasAccess(documentId, userId, "READ")) {
            throw new UnauthorizedAccessException("User " + userId +
                " does not have access to document " + documentId);
        }

        // Increment download count
        documentDAO.incrementDownloadCount(documentId);

        // Return file stream
        try {
            File file = new File(document.getFilePath());
            return new FileInputStream(file);
        } catch (FileNotFoundException e) {
            logger.error("File not found: " + document.getFilePath(), e);
            throw new DocumentNotFoundException("Document file not found");
        }
    }

    public DocumentDTO getDocumentDetails(Integer documentId, Integer userId)
            throws DocumentNotFoundException, UnauthorizedAccessException {
        logger.info("Getting document details " + documentId + " for user " + userId);

        // Get document
        Document document = documentDAO.findById(documentId);
        if (document == null || document.getIsDeleted()) {
            throw new DocumentNotFoundException("Document not found: " + documentId);
        }

        // Check access
        if (!hasAccess(documentId, userId, "READ")) {
            throw new UnauthorizedAccessException("User " + userId +
                " does not have access to document " + documentId);
        }

        // Increment view count
        documentDAO.incrementViewCount(documentId);

        // Convert to DTO
        return convertToDTO(document);
    }

    public boolean hasAccess(Integer documentId, Integer userId, String permission) {
        Document document = documentDAO.findById(documentId);
        if (document == null) return false;

        User user = userDAO.findById(userId);
        if (user == null) return false;

        // Owner always has access
        if (document.getOwner().getId().equals(userId)) {
            return true;
        }

        // Admin always has access
        if (user.hasRole("ROLE_ADMIN")) {
            return true;
        }

        // Public documents
        if ("PUBLIC".equals(document.getAccessLevel()) && "READ".equals(permission)) {
            return true;
        }

        // Check document-level permissions
        // ... (implement permission checking logic)

        return false;
    }

    private DocumentDTO convertToDTO(Document document) {
        DocumentDTO dto = new DocumentDTO();
        dto.setId(document.getId());
        dto.setTitle(document.getTitle());
        dto.setDescription(document.getDescription());
        dto.setFileName(document.getOriginalFileName());
        dto.setFileSize(document.getFileSize());
        dto.setFileType(document.getFileType());
        dto.setCategoryName(document.getCategory().getName());
        dto.setOwnerName(document.getOwner().getFullName());
        dto.setCreatedDate(document.getCreatedDate());
        dto.setVersionNumber(document.getVersionNumber());
        dto.setDownloadCount(document.getDownloadCount());
        dto.setViewCount(document.getViewCount());
        // ... set other fields
        return dto;
    }

    // Additional method implementations...
}
```

### 8.4 Action Layer Design

#### 8.4.1 DocumentAction.java
```java
package com.example.edms.action;

import com.example.edms.form.DocumentForm;
import com.example.edms.service.DocumentService;
import com.example.edms.service.CategoryService;
import com.example.edms.model.Document;
import com.example.edms.dto.DocumentDTO;
import com.example.edms.exception.*;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Struts Action for document operations
 */
public class DocumentAction extends Action {

    private static final Logger logger = Logger.getLogger(DocumentAction.class);

    private DocumentService documentService;
    private CategoryService categoryService;

    // Dependency injection
    public void setDocumentService(DocumentService documentService) {
        this.documentService = documentService;
    }

    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    /**
     * Main execute method - dispatches to specific methods
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String action = request.getParameter("action");

        if ("upload".equals(action)) {
            return upload(mapping, form, request, response);
        } else if ("download".equals(action)) {
            return download(mapping, form, request, response);
        } else if ("view".equals(action)) {
            return view(mapping, form, request, response);
        } else if ("edit".equals(action)) {
            return edit(mapping, form, request, response);
        } else if ("delete".equals(action)) {
            return delete(mapping, form, request, response);
        } else if ("list".equals(action)) {
            return list(mapping, form, request, response);
        } else {
            return list(mapping, form, request, response);  // Default
        }
    }

    /**
     * Display upload form
     */
    public ActionForward uploadForm(ActionMapping mapping, ActionForm form,
                                   HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // Load categories for dropdown
        request.setAttribute("categories", categoryService.getAllCategories());

        return mapping.findForward("uploadForm");
    }

    /**
     * Handle document upload
     */
    public ActionForward upload(ActionMapping mapping, ActionForm form,
                               HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        logger.info("Processing document upload");

        DocumentForm docForm = (DocumentForm) form;
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            ActionMessages errors = new ActionMessages();
            errors.add("error", new ActionMessage("error.not.logged.in"));
            saveErrors(request, errors);
            return mapping.findForward("login");
        }

        try {
            // Get file from form
            FileItem fileItem = docForm.getFile();

            // Prepare metadata
            Map<String, String> metadata = new HashMap<String, String>();
            metadata.put("title", docForm.getTitle());
            metadata.put("description", docForm.getDescription());
            metadata.put("categoryId", String.valueOf(docForm.getCategoryId()));
            metadata.put("accessLevel", docForm.getAccessLevel());

            // Upload document
            Document document = documentService.uploadDocument(fileItem, metadata, userId);

            // Success message
            ActionMessages messages = new ActionMessages();
            messages.add("success", new ActionMessage("document.upload.success",
                                                     document.getTitle()));
            saveMessages(request, messages);

            // Redirect to document view
            return mapping.findForward("viewDocument");

        } catch (InvalidDocumentException e) {
            logger.error("Invalid document", e);
            ActionMessages errors = new ActionMessages();
            errors.add("error", new ActionMessage("document.upload.invalid", e.getMessage()));
            saveErrors(request, errors);
            return mapping.findForward("uploadForm");

        } catch (Exception e) {
            logger.error("Error uploading document", e);
            ActionMessages errors = new ActionMessages();
            errors.add("error", new ActionMessage("document.upload.error"));
            saveErrors(request, errors);
            return mapping.findForward("uploadForm");
        }
    }

    /**
     * Handle document download
     */
    public ActionForward download(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Integer documentId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        logger.info("User " + userId + " downloading document " + documentId);

        try {
            // Get document details for filename
            DocumentDTO document = documentService.getDocumentDetails(documentId, userId);

            // Get file stream
            InputStream inputStream = documentService.downloadDocument(documentId, userId);

            // Set response headers
            response.setContentType(document.getMimeType());
            response.setHeader("Content-Disposition",
                "attachment; filename=\"" + document.getFileName() + "\"");
            response.setContentLength(document.getFileSize().intValue());

            // Stream file to response
            OutputStream outputStream = response.getOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            inputStream.close();
            outputStream.flush();
            outputStream.close();

            return null;  // No forward, response already written

        } catch (DocumentNotFoundException e) {
            logger.error("Document not found: " + documentId, e);
            ActionMessages errors = new ActionMessages();
            errors.add("error", new ActionMessage("document.not.found"));
            saveErrors(request, errors);
            return mapping.findForward("error");

        } catch (UnauthorizedAccessException e) {
            logger.error("Unauthorized access to document: " + documentId, e);
            ActionMessages errors = new ActionMessages();
            errors.add("error", new ActionMessage("document.access.denied"));
            saveErrors(request, errors);
            return mapping.findForward("error");
        }
    }

    /**
     * View document details
     */
    public ActionForward view(ActionMapping mapping, ActionForm form,
                             HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Integer documentId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        try {
            DocumentDTO document = documentService.getDocumentDetails(documentId, userId);
            request.setAttribute("document", document);

            return mapping.findForward("viewDocument");

        } catch (DocumentNotFoundException e) {
            ActionMessages errors = new ActionMessages();
            errors.add("error", new ActionMessage("document.not.found"));
            saveErrors(request, errors);
            return mapping.findForward("error");
        }
    }

    /**
     * List documents
     */
    public ActionForward list(ActionMapping mapping, ActionForm form,
                             HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int pageSize = 20;

        // Get search criteria from request
        Map<String, Object> criteria = new HashMap<String, Object>();
        if (request.getParameter("categoryId") != null) {
            criteria.put("categoryId", Integer.parseInt(request.getParameter("categoryId")));
        }

        // Search documents
        List<DocumentDTO> documents = documentService.searchDocuments(
            criteria, page, pageSize, userId);
        long totalCount = documentService.getDocumentCount(criteria);

        request.setAttribute("documents", documents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", (totalCount + pageSize - 1) / pageSize);
        request.setAttribute("totalCount", totalCount);

        return mapping.findForward("listDocuments");
    }

    // Additional methods: edit, delete, etc.
}
```

### 8.5 Hibernate Mapping Files

#### 8.5.1 Document.hbm.xml
```xml
<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping PUBLIC
    "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
    "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">

<hibernate-mapping package="com.example.edms.model">

    <class name="Document" table="document">
        <cache usage="read-write"/>

        <id name="id" column="id">
            <generator class="identity"/>
        </id>

        <property name="title" column="title" not-null="true" length="255"/>
        <property name="description" column="description" type="text"/>
        <property name="fileName" column="file_name" not-null="true" length="255"/>
        <property name="originalFileName" column="original_file_name" not-null="true" length="255"/>
        <property name="filePath" column="file_path" not-null="true" length="500"/>
        <property name="fileSize" column="file_size" not-null="true"/>
        <property name="fileType" column="file_type" not-null="true" length="50"/>
        <property name="mimeType" column="mime_type" not-null="true" length="100"/>
        <property name="md5Checksum" column="md5_checksum" not-null="true" length="32"/>

        <many-to-one name="category" column="category_id" class="Category" not-null="true"/>
        <many-to-one name="owner" column="owner_id" class="User" not-null="true"/>

        <property name="department" column="department" length="100"/>
        <property name="status" column="status" length="20"/>
        <property name="accessLevel" column="access_level" length="20"/>
        <property name="versionNumber" column="version_number"/>
        <property name="isDeleted" column="is_deleted" type="boolean"/>
        <property name="deletedDate" column="deleted_date" type="timestamp"/>

        <many-to-one name="deletedBy" column="deleted_by" class="User"/>

        <property name="expirationDate" column="expiration_date" type="date"/>
        <property name="downloadCount" column="download_count"/>
        <property name="viewCount" column="view_count"/>
        <property name="createdDate" column="created_date" type="timestamp" insert="false" update="false"/>
        <property name="updatedDate" column="updated_date" type="timestamp" insert="false" update="false"/>

        <many-to-one name="createdBy" column="created_by" class="User" not-null="true"/>
        <many-to-one name="updatedBy" column="updated_by" class="User"/>

        <!-- Collections -->
        <set name="tags" table="document_tag" cascade="save-update">
            <cache usage="read-write"/>
            <key column="document_id"/>
            <many-to-many column="tag_id" class="Tag"/>
        </set>

        <set name="versions" cascade="all-delete-orphan" inverse="true">
            <cache usage="read-write"/>
            <key column="document_id"/>
            <one-to-many class="DocumentVersion"/>
        </set>

        <set name="comments" cascade="all-delete-orphan" inverse="true">
            <cache usage="read-write"/>
            <key column="document_id"/>
            <one-to-many class="DocumentComment"/>
        </set>
    </class>

</hibernate-mapping>
```

---

## 9. User Interface Design

### 9.1 Layout and Navigation

#### 9.1.1 Master Page Layout

```
┌─────────────────────────────────────────────────────────────────┐
│                         HEADER                                   │
│  ┌────────────┐  ┌───────────────────────┐  ┌──────────────┐   │
│  │    LOGO    │  │    SEARCH BOX         │  │  USER MENU   │   │
│  │    EDMS    │  │  🔍 Search documents  │  │  John Doe ▼  │   │
│  └────────────┘  └───────────────────────┘  └──────────────┘   │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Home │ Documents │ Upload │ My Documents │ Workflows │   │  │
│  │  Reports │ Admin │ Help                                  │  │
│  └──────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  BREADCRUMB:  Home > Documents > Financial > Invoices     │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌────────────┬─────────────────────────────────────────────┐  │
│  │            │                                              │  │
│  │  SIDEBAR   │         MAIN CONTENT AREA                   │  │
│  │            │                                              │  │
│  │ Categories │                                              │  │
│  │ ▶ General  │                                              │  │
│  │ ▼ Financial│                                              │  │
│  │   • Invoice│                                              │  │
│  │   • Reports│                                              │  │
│  │ ▶ HR       │                                              │  │
│  │ ▶ Legal    │                                              │  │
│  │            │                                              │  │
│  │ Quick Links│                                              │  │
│  │ • My Docs  │                                              │  │
│  │ • Recent   │                                              │  │
│  │ • My Tasks │                                              │  │
│  │            │                                              │  │
│  └────────────┴─────────────────────────────────────────────┘  │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
│                         FOOTER                                   │
│  Enterprise DMS v1.0 | © 2025 | Privacy | Terms | Contact       │
└──────────────────────────────────────────────────────────────────┘
```

#### 9.1.2 Navigation Structure

```
Home
├── Documents
│   ├── Browse by Category
│   ├── Recent Documents
│   ├── Most Downloaded
│   └── Advanced Search
├── Upload
│   ├── Single Upload
│   └── Bulk Upload
├── My Documents
│   ├── My Uploads
│   ├── Shared with Me
│   └── Deleted Documents
├── Workflows
│   ├── My Tasks (pending approvals)
│   ├── Submitted Workflows
│   └── Workflow History
├── Reports
│   ├── Document Activity
│   ├── User Activity
│   ├── Storage Utilization
│   ├── Workflow Performance
│   └── Audit Trail
├── Admin (Administrators only)
│   ├── User Management
│   ├── Role Management
│   ├── Category Management
│   ├── Workflow Templates
│   ├── System Configuration
│   └── System Maintenance
└── Help
    ├── User Guide
    ├── FAQ
    ├── Video Tutorials
    └── Contact Support
```

### 9.2 Page Designs

#### 9.2.1 Login Page

**Page: login.jsp**
```
┌───────────────────────────────────────────────┐
│                                               │
│           ┌─────────────────────┐             │
│           │                     │             │
│           │    EDMS LOGO        │             │
│           │                     │             │
│           └─────────────────────┘             │
│                                               │
│    Enterprise Document Management System     │
│                                               │
│   ┌─────────────────────────────────────┐    │
│   │  Username: [________________]       │    │
│   │                                     │    │
│   │  Password: [________________]       │    │
│   │                                     │    │
│   │  ☐ Remember me                      │    │
│   │                                     │    │
│   │  [ Login ]                          │    │
│   │                                     │    │
│   │  Forgot password?                   │    │
│   └─────────────────────────────────────┘    │
│                                               │
│          Version 1.0 | © 2025                 │
└───────────────────────────────────────────────┘
```

#### 9.2.2 Dashboard / Home Page

**Page: dashboard.jsp**
```
┌─────────────────────────────────────────────────────────────┐
│  Dashboard                                                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │  📄 Total  │  │  ⬆️ Uploaded│  │  ⬇️ Downloads│            │
│  │  Documents │  │  This Month │  │  This Month │            │
│  │   15,234   │  │     456     │  │    2,891    │            │
│  └────────────┘  └────────────┘  └────────────┘            │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Recent Documents                      [View All >>] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │  📄 Q4 Financial Report.pdf                          │   │
│  │     Finance | John Doe | 2 hours ago                 │   │
│  │  📊 Sales Analysis.xlsx                              │   │
│  │     Marketing | Jane Smith | 5 hours ago             │   │
│  │  📝 Project Proposal.docx                            │   │
│  │     General | Mike Johnson | 1 day ago               │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  My Pending Tasks                      [View All >>] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │  ⚠️ Approval Required: Budget 2025.xlsx              │   │
│  │     Due: Jan 15, 2025 | [Approve] [Reject]          │   │
│  │  ⚠️ Review Required: Policy Update.pdf               │   │
│  │     Due: Jan 18, 2025 | [View]                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌─────────────────────┐  ┌──────────────────────────────┐ │
│  │  Popular Tags       │  │  Storage Usage               │ │
│  │  #invoice #contract │  │  ████████░░░░░░░░ 45% used   │ │
│  │  #report #financial │  │  225 GB / 500 GB             │ │
│  │  #proposal #legal   │  └──────────────────────────────┘ │
│  └─────────────────────┘                                   │
└─────────────────────────────────────────────────────────────┘
```

#### 9.2.3 Document Upload Page

**Page: upload.jsp**
```
┌─────────────────────────────────────────────────────────────┐
│  Upload Document                                             │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Document File *                                     │   │
│  │  ┌────────────────────────┐  [ Browse... ]          │   │
│  │  │ No file selected       │                          │   │
│  │  └────────────────────────┘                          │   │
│  │  Supported: PDF, DOC, DOCX, XLS, XLSX, PPT, TXT     │   │
│  │  Maximum size: 50 MB                                 │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Document Information                                │   │
│  │                                                       │   │
│  │  Title * :  [_______________________________]        │   │
│  │                                                       │   │
│  │  Description:                                        │   │
│  │  ┌─────────────────────────────────────────┐         │   │
│  │  │                                         │         │   │
│  │  │                                         │         │   │
│  │  │                                         │         │   │
│  │  └─────────────────────────────────────────┘         │   │
│  │                                                       │   │
│  │  Category * :  [▼ Select Category          ]        │   │
│  │                                                       │   │
│  │  Tags:  [______________________________]            │   │
│  │  (comma-separated, e.g., invoice, 2025, urgent)     │   │
│  │                                                       │   │
│  │  Access Level:                                       │   │
│  │  ◉ Private  ○ Public  ○ Restricted                  │   │
│  │                                                       │   │
│  │  Expiration Date (optional):  [📅 mm/dd/yyyy]       │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  [ Upload Document ]  [ Cancel ]                            │
└─────────────────────────────────────────────────────────────┘
```

#### 9.2.4 Document List / Browse Page

**Page: documentList.jsp**
```
┌─────────────────────────────────────────────────────────────┐
│  Documents                                                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  🔍 [_________________________]  [Search]  [Advanced]│   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌────────┐  Showing 1-20 of 523 documents                  │
│  │Filters │  Sort by: [▼ Date (newest first)   ]           │
│  ├────────┤                                                  │
│  │Category│  ☐ Select All  [ Download Selected ]           │
│  │☐General│                                                  │
│  │☑Finance│  ┌──────────────────────────────────────────┐   │
│  │☐HR     │  │ ☐ 📄 Q4_Financial_Report.pdf              │   │
│  │☐Legal  │  │    Finance | 2.5 MB | Jan 10, 2025       │   │
│  │        │  │    John Doe | ⬇️ 45 downloads              │   │
│  │File Type│  │    [View] [Download] [Share] [Delete]    │   │
│  │☑PDF    │  ├──────────────────────────────────────────┤   │
│  │☐DOC    │  │ ☐ 📊 Budget_Analysis_2025.xlsx            │   │
│  │☐XLS    │  │    Finance | 1.8 MB | Jan 9, 2025        │   │
│  │        │  │    Jane Smith | ⬇️ 23 downloads            │   │
│  │Date    │  │    [View] [Download] [Share] [Delete]    │   │
│  │⦿ All   │  ├──────────────────────────────────────────┤   │
│  │○ Today │  │ ☐ 📄 Invoice_Dec_2024.pdf                 │   │
│  │○ Week  │  │    Finance | 524 KB | Jan 8, 2025        │   │
│  │○ Month │  │    Mike Johnson | ⬇️ 12 downloads          │   │
│  │        │  │    [View] [Download] [Share] [Delete]    │   │
│  └────────┘  └──────────────────────────────────────────┘   │
│                                                              │
│              << Previous  [1] 2 3 4 5  Next >>              │
└─────────────────────────────────────────────────────────────┘
```

#### 9.2.5 Document View / Details Page

**Page: documentView.jsp**
```
┌─────────────────────────────────────────────────────────────┐
│  Document Details                                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Q4_Financial_Report.pdf                             │   │
│  │  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │   │
│  │  [ Download ] [ Share ] [ Edit ] [ Delete ]          │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌────────────────┬─────────────────────────────────────┐   │
│  │                │                                     │   │
│  │  Details       │  Version History                    │   │
│  │  ━━━━━━━       │  ━━━━━━━━━━━━━                     │   │
│  │                │  v3.0 - Jan 10, 2025 (current)      │   │
│  │ Title:         │  Updated Q4 figures                 │   │
│  │ Q4 Financial   │  John Doe | 2.5 MB                  │   │
│  │ Report         │  [View] [Download] [Restore]        │   │
│  │                │                                     │   │
│  │ Description:   │  v2.0 - Jan 5, 2025                 │   │
│  │ Quarterly      │  Added charts                       │   │
│  │ financial      │  John Doe | 2.3 MB                  │   │
│  │ report for Q4  │  [View] [Download] [Restore]        │   │
│  │ 2024           │                                     │   │
│  │                │  v1.0 - Dec 20, 2024                │   │
│  │ Category:      │  Initial version                    │   │
│  │ Finance        │  Jane Smith | 1.9 MB                │   │
│  │                │  [View] [Download] [Restore]        │   │
│  │ Owner:         │                                     │   │
│  │ John Doe       │                                     │   │
│  │                │                                     │   │
│  │ Created:       │                                     │   │
│  │ Dec 20, 2024   │                                     │   │
│  │                │                                     │   │
│  │ Size: 2.5 MB   │                                     │   │
│  │                │                                     │   │
│  │ Downloads: 45  │                                     │   │
│  │                │                                     │   │
│  │ Tags:          │                                     │   │
│  │ #financial     │                                     │   │
│  │ #q4 #2024      │                                     │   │
│  │                │                                     │   │
│  └────────────────┴─────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Comments (3)                                        │   │
│  │  ━━━━━━━━━━━                                        │   │
│  │                                                       │   │
│  │  Jane Smith • 2 hours ago                            │   │
│  │  Great report! Very comprehensive.                   │   │
│  │  [Reply]                                             │   │
│  │                                                       │   │
│  │  Mike Johnson • 5 hours ago                          │   │
│  │  Could you add a comparison with Q3?                 │   │
│  │  [Reply]                                             │   │
│  │    └─ John Doe • 3 hours ago                         │   │
│  │       I'll add that in the next version.             │   │
│  │                                                       │   │
│  │  ┌─────────────────────────────────────────┐         │   │
│  │  │ Add a comment...                        │         │   │
│  │  │                                         │         │   │
│  │  └─────────────────────────────────────────┘         │   │
│  │  [ Post Comment ]                                    │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

#### 9.2.6 Workflow Tasks Page

**Page: workflowTasks.jsp**
```
┌─────────────────────────────────────────────────────────────┐
│  My Workflow Tasks                                           │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Tabs: [Pending (5)] [Completed] [All]                      │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  ⚠️ URGENT - Approval Required                        │   │
│  │  Document: Budget_2025.xlsx                          │   │
│  │  Workflow: Budget Approval Process                   │   │
│  │  Submitted by: Jane Smith on Jan 8, 2025             │   │
│  │  Due Date: Jan 15, 2025 (5 days remaining)           │   │
│  │                                                       │   │
│  │  Current Step: Director Approval (Step 2 of 3)       │   │
│  │                                                       │   │
│  │  Workflow Progress:                                  │   │
│  │  ✅ Manager Review (Approved by Mike J. - Jan 9)     │   │
│  │  ⏳ Director Approval (Assigned to you)              │   │
│  │  ⚪ Final Sign-off                                   │   │
│  │                                                       │   │
│  │  Comments:                                           │   │
│  │  ┌─────────────────────────────────────────┐         │   │
│  │  │                                         │         │   │
│  │  │                                         │         │   │
│  │  └─────────────────────────────────────────┘         │   │
│  │                                                       │   │
│  │  [ View Document ] [ Approve ] [ Reject ] [Reassign]│   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Review Required                                     │   │
│  │  Document: Policy_Update_2025.pdf                    │   │
│  │  Workflow: Policy Review                             │   │
│  │  ... (similar structure)                             │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 9.3 CSS Styling

**File: style.css**
```css
/* Global Styles */
body {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 14px;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
    color: #333;
}

/* Header */
#header {
    background-color: #2c3e50;
    color: white;
    padding: 15px 20px;
    border-bottom: 3px solid #3498db;
}

#logo {
    float: left;
    font-size: 24px;
    font-weight: bold;
}

#search-box {
    float: left;
    margin-left: 50px;
    margin-top: 5px;
}

#search-box input[type="text"] {
    width: 400px;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

#user-menu {
    float: right;
    margin-top: 5px;
}

/* Navigation Menu */
#nav-menu {
    clear: both;
    background-color: #34495e;
    padding: 0;
    margin-top: 15px;
}

#nav-menu ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

#nav-menu li {
    display: inline-block;
}

#nav-menu a {
    display: block;
    color: white;
    text-decoration: none;
    padding: 12px 20px;
}

#nav-menu a:hover {
    background-color: #3498db;
}

/* Content Area */
#content {
    margin: 20px;
    background-color: white;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

/* Sidebar */
#sidebar {
    float: left;
    width: 220px;
    margin-right: 20px;
}

#sidebar .category-tree {
    list-style-type: none;
    padding-left: 0;
}

#sidebar .category-tree li {
    padding: 5px 0;
}

#sidebar .category-tree a {
    color: #333;
    text-decoration: none;
}

#sidebar .category-tree a:hover {
    color: #3498db;
}

/* Main Content */
#main-content {
    margin-left: 250px;
}

/* Forms */
.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

.form-group input[type="text"],
.form-group input[type="password"],
.form-group input[type="email"],
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.form-group textarea {
    min-height: 100px;
}

/* Buttons */
.btn {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.btn-primary {
    background-color: #3498db;
    color: white;
}

.btn-primary:hover {
    background-color: #2980b9;
}

.btn-success {
    background-color: #27ae60;
    color: white;
}

.btn-danger {
    background-color: #e74c3c;
    color: white;
}

.btn-secondary {
    background-color: #95a5a6;
    color: white;
}

/* Tables */
.data-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.data-table th {
    background-color: #34495e;
    color: white;
    padding: 12px;
    text-align: left;
}

.data-table td {
    padding: 12px;
    border-bottom: 1px solid #ddd;
}

.data-table tr:hover {
    background-color: #f5f5f5;
}

/* Messages */
.message-success {
    background-color: #d4edda;
    border: 1px solid #c3e6cb;
    color: #155724;
    padding: 12px;
    border-radius: 4px;
    margin-bottom: 15px;
}

.message-error {
    background-color: #f8d7da;
    border: 1px solid #f5c6cb;
    color: #721c24;
    padding: 12px;
    border-radius: 4px;
    margin-bottom: 15px;
}

/* Document List */
.document-item {
    border: 1px solid #ddd;
    padding: 15px;
    margin-bottom: 10px;
    border-radius: 4px;
}

.document-item:hover {
    background-color: #f9f9f9;
}

.document-title {
    font-size: 16px;
    font-weight: bold;
    color: #2c3e50;
}

.document-meta {
    color: #7f8c8d;
    font-size: 12px;
    margin-top: 5px;
}

/* Pagination */
.pagination {
    text-align: center;
    margin-top: 20px;
}

.pagination a {
    padding: 8px 12px;
    margin: 0 2px;
    border: 1px solid #ddd;
    text-decoration: none;
    color: #333;
    border-radius: 4px;
}

.pagination a:hover {
    background-color: #3498db;
    color: white;
}

.pagination .active {
    background-color: #3498db;
    color: white;
}

/* Footer */
#footer {
    clear: both;
    background-color: #2c3e50;
    color: white;
    text-align: center;
    padding: 15px;
    margin-top: 40px;
}
```

### 9.4 JavaScript/jQuery Components

**File: app.js**
```javascript
/**
 * EDMS Application JavaScript
 */

// Document ready
$(document).ready(function() {

    // Initialize components
    initializeSearchAutocomplete();
    initializeFileUpload();
    initializeDataTables();
    initializeDatePickers();
    initializeTooltips();

    // Form validation
    $('#uploadForm').submit(function(e) {
        return validateUploadForm();
    });

    // Confirm delete
    $('.delete-btn').click(function(e) {
        return confirm('Are you sure you want to delete this document?');
    });
});

/**
 * Initialize search autocomplete
 */
function initializeSearchAutocomplete() {
    $('#searchBox').autocomplete({
        source: function(request, response) {
            $.ajax({
                url: 'search.do?action=suggest',
                data: { term: request.term },
                success: function(data) {
                    response(data);
                }
            });
        },
        minLength: 2,
        select: function(event, ui) {
            window.location.href = 'document.do?action=view&id=' + ui.item.id;
        }
    });
}

/**
 * Initialize file upload with drag-and-drop
 */
function initializeFileUpload() {
    var dropZone = $('#dropZone');

    // Prevent default drag behaviors
    $(document).on('drag dragstart dragend dragover dragenter dragleave drop', function(e) {
        e.preventDefault();
        e.stopPropagation();
    });

    // Add visual feedback
    dropZone.on('dragover dragenter', function() {
        $(this).addClass('is-dragover');
    });

    dropZone.on('dragleave dragend drop', function() {
        $(this).removeClass('is-dragover');
    });

    // Handle drop
    dropZone.on('drop', function(e) {
        var files = e.originalEvent.dataTransfer.files;
        handleFiles(files);
    });
}

/**
 * Handle file selection
 */
function handleFiles(files) {
    for (var i = 0; i < files.length; i++) {
        var file = files[i];

        // Validate file
        if (!validateFile(file)) {
            continue;
        }

        // Show file info
        displayFileInfo(file);
    }
}

/**
 * Validate file before upload
 */
function validateFile(file) {
    var maxSize = 50 * 1024 * 1024; // 50MB
    var allowedTypes = ['application/pdf', 'application/msword',
                       'application/vnd.ms-excel', 'text/plain'];

    if (file.size > maxSize) {
        alert('File size exceeds maximum limit of 50MB');
        return false;
    }

    if (allowedTypes.indexOf(file.type) === -1) {
        alert('File type not supported: ' + file.type);
        return false;
    }

    return true;
}

/**
 * Initialize data tables with sorting and pagination
 */
function initializeDataTables() {
    $('.data-table').each(function() {
        $(this).dataTable({
            'paging': true,
            'pageLength': 20,
            'lengthChange': true,
            'searching': true,
            'ordering': true,
            'info': true,
            'autoWidth': false
        });
    });
}

/**
 * Initialize date pickers
 */
function initializeDatePickers() {
    $('.datepicker').datepicker({
        dateFormat: 'mm/dd/yy',
        changeMonth: true,
        changeYear: true
    });
}

/**
 * Initialize tooltips
 */
function initializeTooltips() {
    $('[data-toggle="tooltip"]').tooltip();
}

/**
 * Validate upload form
 */
function validateUploadForm() {
    var isValid = true;

    // Check file selected
    var fileInput = $('#fileInput');
    if (!fileInput.val()) {
        alert('Please select a file to upload');
        fileInput.focus();
        return false;
    }

    // Check title
    var title = $('#title');
    if (!title.val().trim()) {
        alert('Please enter a document title');
        title.focus();
        return false;
    }

    // Check category
    var category = $('#categoryId');
    if (!category.val()) {
        alert('Please select a category');
        category.focus();
        return false;
    }

    return isValid;
}

/**
 * AJAX document search
 */
function searchDocuments(query) {
    $.ajax({
        url: 'search.do',
        type: 'GET',
        data: { q: query },
        beforeSend: function() {
            $('#searchResults').html('<div class="loading">Searching...</div>');
        },
        success: function(data) {
            displaySearchResults(data);
        },
        error: function() {
            $('#searchResults').html('<div class="error">Search failed</div>');
        }
    });
}

/**
 * Display search results
 */
function displaySearchResults(results) {
    var html = '';

    if (results.length === 0) {
        html = '<div class="no-results">No documents found</div>';
    } else {
        for (var i = 0; i < results.length; i++) {
            var doc = results[i];
            html += '<div class="document-item">';
            html += '<div class="document-title"><a href="document.do?action=view&id=' + doc.id + '">' + doc.title + '</a></div>';
            html += '<div class="document-meta">' + doc.category + ' | ' + doc.owner + ' | ' + doc.createdDate + '</div>';
            html += '</div>';
        }
    }

    $('#searchResults').html(html);
}

/**
 * Add tag to document
 */
function addTag(documentId, tagName) {
    $.ajax({
        url: 'document.do?action=addTag',
        type: 'POST',
        data: {
            documentId: documentId,
            tagName: tagName
        },
        success: function(response) {
            if (response.success) {
                // Refresh tags display
                location.reload();
            } else {
                alert('Error adding tag: ' + response.message);
            }
        },
        error: function() {
            alert('Error adding tag');
        }
    });
}

/**
 * Submit workflow approval
 */
function submitApproval(taskId, action, comments) {
    $.ajax({
        url: 'workflow.do?action=' + action,
        type: 'POST',
        data: {
            taskId: taskId,
            comments: comments
        },
        success: function(response) {
            if (response.success) {
                alert('Workflow task ' + action + 'd successfully');
                location.reload();
            } else {
                alert('Error: ' + response.message);
            }
        },
        error: function() {
            alert('Error submitting workflow action');
        }
    });
}
```

---

## 10. Security Design

### 10.1 Authentication Flow

```
User Login Process:
1. User enters username/password on login page
2. Form submitted to LoginAction
3. LoginAction calls AuthenticationService.authenticate()
4. AuthenticationService:
   a. Validates input (not empty, format)
   b. Queries database for user by username
   c. If user not found → login fails
   d. If user status is LOCKED → login fails
   e. Retrieves stored password hash from database
   f. Hashes submitted password with same salt
   g. Compares hashes
   h. If match → proceed
   i. If no match → increment failed_login_count, login fails
5. On successful authentication:
   a. Reset failed_login_count to 0
   b. Update last_login_date and last_login_ip
   c. Load user roles and permissions
   d. Create HTTP session
   e. Store user object in session
   f. Generate CSRF token and store in session
   g. Log successful login to audit_log
   h. Redirect to dashboard
6. On failed authentication:
   a. Increment failed_login_count
   b. If count >= 5, set status to LOCKED
   c. Log failed login attempt to audit_log
   d. Display generic error message
   e. Return to login page
```

### 10.2 Authorization Implementation

#### 10.2.1 AuthenticationFilter.java
```java
package com.example.edms.filter;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class AuthenticationFilter implements Filter {

    private List<String> publicPaths = Arrays.asList(
        "/login.jsp", "/login.do", "/css/", "/js/", "/images/"
    );

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestPath = httpRequest.getRequestURI();

        // Check if public path
        boolean isPublicPath = false;
        for (String path : publicPaths) {
            if (requestPath.contains(path)) {
                isPublicPath = true;
                break;
            }
        }

        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }

        // Check session and user
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }

        // User authenticated, continue
        chain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig) throws ServletException {}
    public void destroy() {}
}
```

#### 10.2.2 SecurityService.java
```java
package com.example.edms.service;

import com.example.edms.model.User;

public interface SecurityService {
    boolean hasPermission(User user, String resource, String action);
    boolean canAccessDocument(User user, Integer documentId, String permission);
    void checkPermission(User user, String resource, String action)
        throws UnauthorizedAccessException;
}
```

### 10.3 Password Security

**Password Hashing Implementation:**
```java
package com.example.edms.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class PasswordUtil {

    private static final String ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 16;

    /**
     * Generate random salt
     */
    public static byte[] generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);
        return salt;
    }

    /**
     * Hash password with salt
     */
    public static String hashPassword(String password, byte[] salt)
            throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance(ALGORITHM);
        md.update(salt);
        byte[] hashedPassword = md.digest(password.getBytes());

        // Convert to hex string
        StringBuilder sb = new StringBuilder();
        for (byte b : hashedPassword) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    /**
     * Verify password
     */
    public static boolean verifyPassword(String password, String storedHash,
                                        byte[] salt) throws NoSuchAlgorithmException {
        String hashOfInput = hashPassword(password, salt);
        return hashOfInput.equals(storedHash);
    }

    /**
     * Validate password complexity
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }

        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;

        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isDigit(c)) hasDigit = true;
            else hasSpecial = true;
        }

        return hasUpper && hasLower && hasDigit && hasSpecial;
    }
}
```

### 10.4 SQL Injection Prevention

**Using Hibernate Parameterized Queries:**
```java
// GOOD - Parameterized query (prevents SQL injection)
String hql = "FROM Document WHERE title = :title AND category.id = :categoryId";
Query query = session.createQuery(hql);
query.setString("title", userInput);
query.setInteger("categoryId", categoryId);
List<Document> results = query.list();

// BAD - String concatenation (vulnerable to SQL injection)
// NEVER DO THIS:
// String hql = "FROM Document WHERE title = '" + userInput + "'";
```

### 10.5 XSS Prevention

**Output Escaping in JSP:**
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- GOOD - Escapes HTML entities -->
<c:out value="${document.title}" />

<!-- or using fn:escapeXml -->
${fn:escapeXml(document.description)}

<!-- BAD - Vulnerable to XSS -->
<!-- ${document.title} -->
```

### 10.6 CSRF Protection

**CSRF Token Implementation:**
```java
// Generate CSRF token on login
public void generateCSRFToken(HttpSession session) {
    SecureRandom random = new SecureRandom();
    byte[] tokenBytes = new byte[32];
    random.nextBytes(tokenBytes);
    String token = Base64.encode(tokenBytes);
    session.setAttribute("csrfToken", token);
}

// Validate CSRF token on POST requests
public boolean validateCSRFToken(HttpServletRequest request) {
    String sessionToken = (String) request.getSession().getAttribute("csrfToken");
    String requestToken = request.getParameter("csrfToken");
    return sessionToken != null && sessionToken.equals(requestToken);
}
```

**JSP Form with CSRF Token:**
```jsp
<form action="document.do" method="POST">
    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}" />
    <!-- other form fields -->
</form>
```

---

## 11. Integration Design

### 11.1 Apache Lucene Integration

**Search Index Manager:**
```java
package com.example.edms.service.impl;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

public class SearchServiceImpl implements SearchService {

    private static final String INDEX_DIR = "/var/edms/lucene-index";
    private static final Version LUCENE_VERSION = Version.LUCENE_36;

    /**
     * Index a document for search
     */
    public void indexDocument(com.example.edms.model.Document doc) throws Exception {
        FSDirectory directory = FSDirectory.open(new File(INDEX_DIR));
        IndexWriterConfig config = new IndexWriterConfig(LUCENE_VERSION,
            new StandardAnalyzer(LUCENE_VERSION));
        IndexWriter writer = new IndexWriter(directory, config);

        try {
            Document luceneDoc = new Document();

            // Add fields
            luceneDoc.add(new Field("id", String.valueOf(doc.getId()),
                Field.Store.YES, Field.Index.NOT_ANALYZED));
            luceneDoc.add(new Field("title", doc.getTitle(),
                Field.Store.YES, Field.Index.ANALYZED));
            luceneDoc.add(new Field("description", doc.getDescription(),
                Field.Store.YES, Field.Index.ANALYZED));
            luceneDoc.add(new Field("category", doc.getCategory().getName(),
                Field.Store.YES, Field.Index.ANALYZED));
            luceneDoc.add(new Field("owner", doc.getOwner().getFullName(),
                Field.Store.YES, Field.Index.ANALYZED));

            // Extract and index file content
            String fileContent = extractTextFromFile(doc.getFilePath(), doc.getFileType());
            if (fileContent != null) {
                luceneDoc.add(new Field("content", fileContent,
                    Field.Store.NO, Field.Index.ANALYZED));
            }

            // Add tags
            for (Tag tag : doc.getTags()) {
                luceneDoc.add(new Field("tags", tag.getName(),
                    Field.Store.YES, Field.Index.ANALYZED));
            }

            writer.addDocument(luceneDoc);

        } finally {
            writer.close();
            directory.close();
        }
    }

    /**
     * Search documents
     */
    public List<SearchResult> search(String queryString, int maxResults) throws Exception {
        FSDirectory directory = FSDirectory.open(new File(INDEX_DIR));
        IndexSearcher searcher = new IndexSearcher(directory);

        try {
            // Create multi-field query
            QueryParser parser = new QueryParser(LUCENE_VERSION, "content",
                new StandardAnalyzer(LUCENE_VERSION));
            Query query = parser.parse(queryString);

            // Execute search
            TopDocs topDocs = searcher.search(query, maxResults);
            ScoreDoc[] hits = topDocs.scoreDocs;

            List<SearchResult> results = new ArrayList<SearchResult>();
            for (ScoreDoc hit : hits) {
                Document doc = searcher.doc(hit.doc);
                SearchResult result = new SearchResult();
                result.setDocumentId(Integer.parseInt(doc.get("id")));
                result.setTitle(doc.get("title"));
                result.setDescription(doc.get("description"));
                result.setScore(hit.score);
                results.add(result);
            }

            return results;

        } finally {
            searcher.close();
            directory.close();
        }
    }

    /**
     * Extract text from file based on type
     */
    private String extractTextFromFile(String filePath, String fileType) {
        try {
            if ("pdf".equalsIgnoreCase(fileType)) {
                return extractTextFromPDF(filePath);
            } else if ("txt".equalsIgnoreCase(fileType)) {
                return extractTextFromText(filePath);
            } else if ("doc".equalsIgnoreCase(fileType) ||
                       "docx".equalsIgnoreCase(fileType)) {
                return extractTextFromWord(filePath);
            }
        } catch (Exception e) {
            logger.error("Error extracting text from file", e);
        }
        return null;
    }

    /**
     * Extract text from PDF using PDFBox
     */
    private String extractTextFromPDF(String filePath) throws Exception {
        PDDocument document = PDDocument.load(new File(filePath));
        try {
            PDFTextStripper stripper = new PDFTextStripper();
            return stripper.getText(document);
        } finally {
            document.close();
        }
    }

    /**
     * Extract text from plain text file
     */
    private String extractTextFromText(String filePath) throws Exception {
        StringBuilder content = new StringBuilder();
        BufferedReader reader = new BufferedReader(new FileReader(filePath));
        try {
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
        } finally {
            reader.close();
        }
        return content.toString();
    }
}
```

### 11.2 Email Notification Integration

**Email Service Implementation:**
```java
package com.example.edms.service.impl;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class NotificationServiceImpl implements NotificationService {

    private String smtpHost;
    private int smtpPort;
    private String smtpUsername;
    private String smtpPassword;
    private String fromAddress;

    /**
     * Send email notification
     */
    public void sendEmail(String to, String subject, String body) {
        Properties props = new Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", String.valueOf(smtpPort));
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUsername, smtpPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromAddress));
            message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(to));
            message.setSubject(subject);

            // HTML email body
            message.setContent(body, "text/html; charset=utf-8");

            Transport.send(message);

            logger.info("Email sent to: " + to);

        } catch (MessagingException e) {
            logger.error("Error sending email", e);
            throw new RuntimeException("Failed to send email", e);
        }
    }

    /**
     * Send workflow task notification
     */
    public void sendWorkflowTaskNotification(WorkflowTask task) {
        User assignee = task.getAssignedTo();
        Document document = task.getWorkflowInstance().getDocument();

        String subject = "Workflow Task Assigned: " + document.getTitle();

        StringBuilder body = new StringBuilder();
        body.append("<html><body>");
        body.append("<h2>Workflow Task Assigned</h2>");
        body.append("<p>You have been assigned a workflow task:</p>");
        body.append("<ul>");
        body.append("<li><strong>Document:</strong> ").append(document.getTitle()).append("</li>");
        body.append("<li><strong>Workflow:</strong> ").append(task.getWorkflowStep().getWorkflow().getName()).append("</li>");
        body.append("<li><strong>Step:</strong> ").append(task.getWorkflowStep().getStepName()).append("</li>");
        body.append("<li><strong>Due Date:</strong> ").append(task.getDueDate()).append("</li>");
        body.append("</ul>");
        body.append("<p><a href='").append(getApplicationUrl()).append("/workflow.do?action=viewTask&id=").append(task.getId()).append("'>View Task</a></p>");
        body.append("</body></html>");

        sendEmail(assignee.getEmail(), subject, body.toString());
    }
}
```

### 11.3 File System Integration

**File Storage Strategy:**
```
Storage Directory Structure:
/var/edms/documents/
├── 2025/
│   ├── 01/  (January)
│   │   ├── 10/  (Day 10)
│   │   │   ├── doc_12345_v1_a1b2c3d4.pdf
│   │   │   ├── doc_12346_v1_e5f6g7h8.docx
│   │   │   └── ...
│   │   ├── 11/
│   │   └── ...
│   ├── 02/  (February)
│   └── ...
├── 2024/
└── ...

Naming Convention:
doc_{document_id}_v{version_number}_{random_hash}.{extension}

Example: doc_12345_v3_a1b2c3d4e5f6g7h8.pdf
```

**File Utility Implementation:**
```java
package com.example.edms.util;

import java.io.*;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class FileUtil {

    private static final String STORAGE_BASE_PATH = "/var/edms/documents";

    /**
     * Save uploaded file to storage
     */
    public static String saveFile(FileItem fileItem, String uniqueFileName)
            throws Exception {
        // Create date-based directory structure
        Date now = new Date();
        SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
        SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
        SimpleDateFormat dayFormat = new SimpleDateFormat("dd");

        String year = yearFormat.format(now);
        String month = monthFormat.format(now);
        String day = dayFormat.format(now);

        String dirPath = STORAGE_BASE_PATH + File.separator +
                        year + File.separator +
                        month + File.separator + day;

        // Create directories if they don't exist
        File directory = new File(dirPath);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        // Full file path
        String filePath = dirPath + File.separator + uniqueFileName;

        // Write file
        File destinationFile = new File(filePath);
        fileItem.write(destinationFile);

        return filePath;
    }

    /**
     * Generate unique filename
     */
    public static String generateUniqueFileName(String originalFileName) {
        String extension = getFileExtension(originalFileName);
        String randomHash = UUID.randomUUID().toString().replace("-", "");
        return randomHash + "." + extension;
    }

    /**
     * Get file extension
     */
    public static String getFileExtension(String fileName) {
        int lastDot = fileName.lastIndexOf('.');
        if (lastDot > 0 && lastDot < fileName.length() - 1) {
            return fileName.substring(lastDot + 1).toLowerCase();
        }
        return "";
    }

    /**
     * Calculate MD5 checksum
     */
    public static String calculateMD5(File file) throws Exception {
        MessageDigest md = MessageDigest.getInstance("MD5");
        FileInputStream fis = new FileInputStream(file);

        try {
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                md.update(buffer, 0, bytesRead);
            }
        } finally {
            fis.close();
        }

        byte[] digest = md.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : digest) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    /**
     * Validate file upload
     */
    public static void validateFile(FileItem fileItem) throws InvalidDocumentException {
        if (fileItem == null || fileItem.getSize() == 0) {
            throw new InvalidDocumentException("No file selected");
        }

        // Check file size (50MB max)
        long maxSize = 50 * 1024 * 1024;
        if (fileItem.getSize() > maxSize) {
            throw new InvalidDocumentException("File size exceeds maximum of 50MB");
        }

        // Check file type
        String fileName = fileItem.getName();
        String extension = getFileExtension(fileName);

        String[] allowedExtensions = {"pdf", "doc", "docx", "xls", "xlsx",
                                     "ppt", "pptx", "txt", "jpg", "png", "gif"};
        boolean isAllowed = false;
        for (String ext : allowedExtensions) {
            if (ext.equalsIgnoreCase(extension)) {
                isAllowed = true;
                break;
            }
        }

        if (!isAllowed) {
            throw new InvalidDocumentException("File type not supported: " + extension);
        }
    }

    /**
     * Delete file from storage
     */
    public static boolean deleteFile(String filePath) {
        File file = new File(filePath);
        if (file.exists()) {
            return file.delete();
        }
        return false;
    }

    /**
     * Format file size for display
     */
    public static String formatFileSize(long size) {
        if (size < 1024) {
            return size + " B";
        } else if (size < 1024 * 1024) {
            return String.format("%.2f KB", size / 1024.0);
        } else if (size < 1024 * 1024 * 1024) {
            return String.format("%.2f MB", size / (1024.0 * 1024.0));
        } else {
            return String.format("%.2f GB", size / (1024.0 * 1024.0 * 1024.0));
        }
    }
}
```

### 11.4 Quartz Scheduler Integration

**Scheduled Jobs Configuration:**
```java
package com.example.edms.job;

import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

public class SchedulerManager {

    private Scheduler scheduler;

    public void start() throws SchedulerException {
        scheduler = StdSchedulerFactory.getDefaultScheduler();

        // Job 1: Index optimization (daily at 2 AM)
        JobDetail indexOptimizationJob = JobBuilder.newJob(IndexOptimizationJob.class)
            .withIdentity("indexOptimization", "maintenance")
            .build();

        Trigger indexOptimizationTrigger = TriggerBuilder.newTrigger()
            .withIdentity("indexOptimizationTrigger", "maintenance")
            .withSchedule(CronScheduleBuilder.dailyAtHourAndMinute(2, 0))
            .build();

        scheduler.scheduleJob(indexOptimizationJob, indexOptimizationTrigger);

        // Job 2: Delete old documents (weekly on Sunday at 3 AM)
        JobDetail cleanupJob = JobBuilder.newJob(DocumentCleanupJob.class)
            .withIdentity("documentCleanup", "maintenance")
            .build();

        Trigger cleanupTrigger = TriggerBuilder.newTrigger()
            .withIdentity("cleanupTrigger", "maintenance")
            .withSchedule(CronScheduleBuilder.weeklyOnDayAndHourAndMinute(1, 3, 0))
            .build();

        scheduler.scheduleJob(cleanupJob, cleanupTrigger);

        // Job 3: Workflow deadline notifications (daily at 9 AM)
        JobDetail deadlineJob = JobBuilder.newJob(WorkflowDeadlineJob.class)
            .withIdentity("workflowDeadline", "notifications")
            .build();

        Trigger deadlineTrigger = TriggerBuilder.newTrigger()
            .withIdentity("deadlineTrigger", "notifications")
            .withSchedule(CronScheduleBuilder.dailyAtHourAndMinute(9, 0))
            .build();

        scheduler.scheduleJob(deadlineJob, deadlineTrigger);

        // Start scheduler
        scheduler.start();
    }

    public void stop() throws SchedulerException {
        if (scheduler != null) {
            scheduler.shutdown();
        }
    }
}

/**
 * Job to optimize Lucene index
 */
public class IndexOptimizationJob implements Job {
    public void execute(JobExecutionContext context) throws JobExecutionException {
        try {
            // Optimize Lucene index
            IndexWriter writer = getIndexWriter();
            writer.optimize();
            writer.close();
            logger.info("Index optimization completed");
        } catch (Exception e) {
            logger.error("Error optimizing index", e);
        }
    }
}

/**
 * Job to delete old soft-deleted documents
 */
public class DocumentCleanupJob implements Job {
    public void execute(JobExecutionContext context) throws JobExecutionException {
        // Delete documents soft-deleted more than 90 days ago
        Date cutoffDate = new Date(System.currentTimeMillis() - (90L * 24 * 60 * 60 * 1000));

        // Query and delete old documents
        // ... implementation
    }
}
```

---

## 12. Deployment Architecture

### 12.1 Server Requirements

**Production Server Specifications:**
- **CPU:** 4 cores minimum, 8 cores recommended
- **RAM:** 8GB minimum, 16GB recommended
- **Disk:** 500GB minimum for documents, SSD recommended
- **OS:** Linux (CentOS 7, Ubuntu 18.04, or RHEL 7)
- **Network:** 1Gbps network interface

**Software Requirements:**
- Java 1.5.0_22 (J2SE 5.0)
- Apache Tomcat 6.0.53
- MySQL 5.7.x
- Apache HTTP Server 2.4 (optional, for reverse proxy)

### 12.2 Directory Structure

```
/opt/edms/
├── tomcat/               (Tomcat installation)
│   ├── bin/
│   ├── conf/
│   │   ├── server.xml
│   │   ├── context.xml
│   │   └── tomcat-users.xml
│   ├── lib/
│   ├── logs/
│   ├── webapps/
│   │   └── edms.war
│   └── work/
├── config/               (External configuration)
│   ├── hibernate.cfg.xml
│   ├── log4j.properties
│   ├── application.properties
│   └── mail.properties
├── logs/                 (Application logs)
│   ├── application.log
│   ├── error.log
│   └── audit.log
└── scripts/              (Utility scripts)
    ├── start.sh
    ├── stop.sh
    ├── backup.sh
    └── deploy.sh

/var/edms/
├── documents/            (Document storage)
│   └── 2025/
│       └── 01/
├── lucene-index/         (Search index)
└── temp/                 (Temporary files)

/var/backup/edms/
├── db/                   (Database backups)
└── files/                (Document backups)
```

### 12.3 Configuration Files

**hibernate.cfg.xml (Production):**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-configuration PUBLIC
    "-//Hibernate/Hibernate Configuration DTD 3.0//EN"
    "http://hibernate.sourceforge.net/hibernate-configuration-3.0.dtd">

<hibernate-configuration>
    <session-factory>
        <!-- Database connection settings -->
        <property name="connection.driver_class">com.mysql.jdbc.Driver</property>
        <property name="connection.url">jdbc:mysql://localhost:3306/edms_prod?useUnicode=true&amp;characterEncoding=UTF-8</property>
        <property name="connection.username">edms_user</property>
        <property name="connection.password">ENCRYPTED_PASSWORD</property>

        <!-- C3P0 connection pool -->
        <property name="hibernate.connection.provider_class">org.hibernate.connection.C3P0ConnectionProvider</property>
        <property name="hibernate.c3p0.min_size">10</property>
        <property name="hibernate.c3p0.max_size">50</property>
        <property name="hibernate.c3p0.timeout">300</property>
        <property name="hibernate.c3p0.max_statements">50</property>
        <property name="hibernate.c3p0.idle_test_period">3000</property>

        <!-- SQL dialect -->
        <property name="dialect">org.hibernate.dialect.MySQL5InnoDBDialect</property>

        <!-- Echo SQL to stdout -->
        <property name="show_sql">false</property>
        <property name="format_sql">false</property>

        <!-- Second-level cache -->
        <property name="cache.provider_class">org.hibernate.cache.EhCacheProvider</property>
        <property name="cache.use_second_level_cache">true</property>
        <property name="cache.use_query_cache">true</property>

        <!-- Transaction management -->
        <property name="current_session_context_class">thread</property>

        <!-- Mapping files -->
        <mapping resource="com/example/edms/model/Document.hbm.xml"/>
        <mapping resource="com/example/edms/model/User.hbm.xml"/>
        <mapping resource="com/example/edms/model/Category.hbm.xml"/>
        <!-- ... other mappings -->
    </session-factory>
</hibernate-configuration>
```

**server.xml (Tomcat Configuration):**
```xml
<Server port="8005" shutdown="SHUTDOWN">
    <Service name="Catalina">
        <Connector port="8080" protocol="HTTP/1.1"
                   connectionTimeout="20000"
                   redirectPort="8443"
                   maxThreads="200"
                   minSpareThreads="10"
                   enableLookups="false"
                   acceptCount="100"
                   URIEncoding="UTF-8" />

        <!-- SSL/TLS Connector -->
        <Connector port="8443" protocol="HTTP/1.1" SSLEnabled="true"
                   maxThreads="150" scheme="https" secure="true"
                   keystoreFile="/opt/edms/ssl/keystore.jks"
                   keystorePass="KEYSTORE_PASSWORD"
                   clientAuth="false" sslProtocol="TLS" />

        <Engine name="Catalina" defaultHost="localhost">
            <Host name="localhost" appBase="webapps"
                  unpackWARs="true" autoDeploy="false">
                <Valve className="org.apache.catalina.valves.AccessLogValve"
                       directory="logs" prefix="access_log." suffix=".txt"
                       pattern="%h %l %u %t &quot;%r&quot; %s %b" />
            </Host>
        </Engine>
    </Service>
</Server>
```

### 12.4 Deployment Process

**Deployment Steps:**
1. Build WAR file: `ant clean war`
2. Stop Tomcat: `/opt/edms/scripts/stop.sh`
3. Backup current deployment: `cp /opt/edms/tomcat/webapps/edms.war /var/backup/edms/`
4. Copy new WAR: `cp build/edms.war /opt/edms/tomcat/webapps/`
5. Clear work directory: `rm -rf /opt/edms/tomcat/work/Catalina`
6. Start Tomcat: `/opt/edms/scripts/start.sh`
7. Verify deployment: Check logs and access application

**Deployment Script (deploy.sh):**
```bash
#!/bin/bash

TOMCAT_HOME=/opt/edms/tomcat
WEBAPP_NAME=edms
BACKUP_DIR=/var/backup/edms
LOG_FILE=/opt/edms/logs/deploy.log

echo "Starting deployment at $(date)" | tee -a $LOG_FILE

# Stop Tomcat
echo "Stopping Tomcat..." | tee -a $LOG_FILE
$TOMCAT_HOME/bin/shutdown.sh
sleep 10

# Backup current WAR
if [ -f "$TOMCAT_HOME/webapps/$WEBAPP_NAME.war" ]; then
    echo "Backing up current WAR..." | tee -a $LOG_FILE
    cp $TOMCAT_HOME/webapps/$WEBAPP_NAME.war $BACKUP_DIR/$WEBAPP_NAME-$(date +%Y%m%d-%H%M%S).war
fi

# Remove old deployment
echo "Removing old deployment..." | tee -a $LOG_FILE
rm -rf $TOMCAT_HOME/webapps/$WEBAPP_NAME
rm -f $TOMCAT_HOME/webapps/$WEBAPP_NAME.war

# Copy new WAR
echo "Deploying new WAR..." | tee -a $LOG_FILE
cp build/$WEBAPP_NAME.war $TOMCAT_HOME/webapps/

# Clear work directory
echo "Clearing work directory..." | tee -a $LOG_FILE
rm -rf $TOMCAT_HOME/work/Catalina

# Start Tomcat
echo "Starting Tomcat..." | tee -a $LOG_FILE
$TOMCAT_HOME/bin/startup.sh

echo "Deployment completed at $(date)" | tee -a $LOG_FILE
echo "Check application logs for startup status" | tee -a $LOG_FILE
```

---

## 13. Development Plan

### 13.1 Development Phases

#### Phase 1: Foundation (Weeks 1-4)
**Objectives:** Setup infrastructure and core framework

**Week 1-2: Environment Setup**
- [ ] Setup development environment (Java 5, Tomcat 6, MySQL 5.7)
- [ ] Create Git repository
- [ ] Setup Ant build scripts
- [ ] Create database schema
- [ ] Configure Hibernate
- [ ] Setup Log4j
- [ ] Create project structure

**Week 3-4: Core Framework**
- [ ] Implement base classes (BaseAction, BaseDAO, BaseService)
- [ ] Implement HibernateUtil
- [ ] Create authentication filter
- [ ] Implement login/logout functionality
- [ ] Create master page layout
- [ ] Implement user management (CRUD)
- [ ] Implement role and permission management
- [ ] Write unit tests for core utilities

**Deliverables:**
- Working development environment
- Database schema created
- User authentication working
- Basic user management functional

#### Phase 2: Document Management (Weeks 5-8)
**Objectives:** Implement core document management features

**Week 5-6: Document Upload and Storage**
- [ ] Implement document upload (single file)
- [ ] Implement file validation
- [ ] Implement file storage service
- [ ] Create document metadata management
- [ ] Implement category management
- [ ] Create document listing page
- [ ] Implement document view/details page

**Week 7-8: Document Operations**
- [ ] Implement document download
- [ ] Implement document editing (metadata)
- [ ] Implement document deletion (soft delete)
- [ ] Implement bulk upload
- [ ] Implement bulk download (ZIP)
- [ ] Create tag management
- [ ] Implement document permissions

**Deliverables:**
- Complete document upload/download functionality
- Document CRUD operations working
- Category and tag management functional

#### Phase 3: Version Control (Weeks 9-10)
**Objectives:** Implement version control system

- [ ] Implement version creation on file replacement
- [ ] Create version history display
- [ ] Implement version download
- [ ] Implement version comparison (text files)
- [ ] Implement version rollback
- [ ] Create version comments UI
- [ ] Write version control tests

**Deliverables:**
- Full version control functionality
- Version history tracking
- Version comparison and rollback

#### Phase 4: Search and Indexing (Weeks 11-12)
**Objectives:** Implement full-text search using Apache Lucene

- [ ] Setup Lucene index structure
- [ ] Implement document indexing service
- [ ] Implement text extraction (PDF, DOC, TXT)
- [ ] Create basic search functionality
- [ ] Implement advanced search with filters
- [ ] Create search results page with highlighting
- [ ] Implement saved searches
- [ ] Implement search autocomplete
- [ ] Optimize index performance

**Deliverables:**
- Full-text search working
- Advanced search with multiple filters
- Fast search performance (<2 seconds)

#### Phase 5: Workflow Management (Weeks 13-16)
**Objectives:** Implement approval workflow system

**Week 13-14: Workflow Templates**
- [ ] Create workflow model and database tables
- [ ] Implement workflow template CRUD
- [ ] Create workflow step management
- [ ] Implement workflow visualization
- [ ] Create workflow admin UI

**Week 15-16: Workflow Execution**
- [ ] Implement workflow submission
- [ ] Create task assignment logic
- [ ] Implement approval/rejection
- [ ] Create "My Tasks" page
- [ ] Implement workflow notifications
- [ ] Implement task reassignment
- [ ] Create workflow history tracking
- [ ] Test workflow scenarios

**Deliverables:**
- Workflow template management
- Workflow execution engine
- Task management interface
- Email notifications

#### Phase 6: Reporting and Analytics (Weeks 17-18)
**Objectives:** Implement reporting functionality

- [ ] Implement document activity report
- [ ] Implement user activity report
- [ ] Implement storage utilization report
- [ ] Implement workflow performance report
- [ ] Implement audit trail report
- [ ] Create PDF report generation (iText)
- [ ] Create Excel export (Apache POI)
- [ ] Create report scheduling (optional)

**Deliverables:**
- 5 standard reports functional
- PDF and Excel export working

#### Phase 7: Administration and Configuration (Week 19)
**Objectives:** Implement admin features

- [ ] Create system configuration UI
- [ ] Implement database maintenance tools
- [ ] Create system log viewer
- [ ] Implement user preference management
- [ ] Create dashboard with metrics
- [ ] Implement license management

**Deliverables:**
- Complete admin panel
- System configuration management
- Monitoring tools

#### Phase 8: Testing and Quality Assurance (Weeks 20-22)
**Objectives:** Comprehensive testing

**Week 20: Unit and Integration Testing**
- [ ] Write unit tests for all services (target 70% coverage)
- [ ] Write integration tests for DAOs
- [ ] Write tests for workflow engine
- [ ] Run code coverage analysis
- [ ] Fix bugs found in testing

**Week 21: System and Performance Testing**
- [ ] Perform end-to-end testing
- [ ] Load testing (500 concurrent users)
- [ ] Performance testing (response times)
- [ ] Security testing (penetration test)
- [ ] Compatibility testing (browsers, OS)

**Week 22: User Acceptance Testing**
- [ ] Deploy to UAT environment
- [ ] Conduct UAT with stakeholders
- [ ] Document and fix issues
- [ ] Update user documentation

**Deliverables:**
- Test reports
- Bug fixes
- Performance benchmarks
- UAT sign-off

#### Phase 9: Documentation and Training (Week 23)
**Objectives:** Create documentation and training materials

- [ ] Write user manual (PDF)
- [ ] Create admin guide
- [ ] Write technical documentation
- [ ] Create video tutorials (optional)
- [ ] Prepare training materials
- [ ] Conduct training sessions
- [ ] Create FAQ document

**Deliverables:**
- Complete user documentation
- Admin documentation
- Training materials

#### Phase 10: Deployment and Go-Live (Week 24)
**Objectives:** Production deployment

- [ ] Setup production environment
- [ ] Deploy application
- [ ] Migrate data (if applicable)
- [ ] Configure SSL certificates
- [ ] Setup backups
- [ ] Configure monitoring
- [ ] Perform smoke tests
- [ ] Go-live
- [ ] Post-deployment support

**Deliverables:**
- Production system live
- Backup and monitoring configured
- Support plan in place

### 13.2 Resource Plan

**Development Team:**
- 1 Project Manager (full-time, 24 weeks)
- 2 Senior Java Developers (full-time, 24 weeks)
- 1 Frontend Developer (full-time, 16 weeks)
- 1 Database Administrator (part-time, 24 weeks)
- 1 QA Engineer (full-time, 12 weeks)
- 1 Technical Writer (part-time, 4 weeks)

**Estimated Effort:** ~180 person-weeks (~4.5 person-years)

### 13.3 Milestones

| Milestone | Target Date | Deliverable |
|-----------|-------------|-------------|
| M1: Environment Setup | End of Week 2 | Dev environment ready |
| M2: Core Framework | End of Week 4 | Authentication working |
| M3: Document Management | End of Week 8 | Upload/download working |
| M4: Version Control | End of Week 10 | Versioning complete |
| M5: Search | End of Week 12 | Full-text search working |
| M6: Workflows | End of Week 16 | Workflow system complete |
| M7: Reporting | End of Week 18 | Reports functional |
| M8: Testing Complete | End of Week 22 | UAT sign-off |
| M9: Documentation | End of Week 23 | Docs complete |
| M10: Go-Live | End of Week 24 | Production live |

---

## 14. Testing Strategy

### 14.1 Testing Types

#### 14.1.1 Unit Testing

**Framework:** JUnit 4.12

**Coverage Target:** 70% code coverage minimum

**Example Unit Test:**
```java
package com.example.edms.service;

import com.example.edms.model.User;
import com.example.edms.dao.UserDAO;
import com.example.edms.service.impl.UserServiceImpl;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class UserServiceTest {

    @Mock
    private UserDAO userDAO;

    private UserService userService;

    @Before
    public void setUp() {
        userService = new UserServiceImpl();
        ((UserServiceImpl) userService).setUserDAO(userDAO);
    }

    @Test
    public void testAuthenticateSuccess() {
        // Setup
        String username = "testuser";
        String password = "password123";
        User mockUser = new User();
        mockUser.setUsername(username);
        mockUser.setPasswordHash("hashed_password");
        mockUser.setStatus("ACTIVE");

        when(userDAO.findByUsername(username)).thenReturn(mockUser);

        // Execute
        User result = userService.authenticate(username, password);

        // Verify
        assertNotNull(result);
        assertEquals(username, result.getUsername());
        verify(userDAO, times(1)).findByUsername(username);
    }

    @Test(expected = AuthenticationException.class)
    public void testAuthenticateUserNotFound() {
        when(userDAO.findByUsername("nonexistent")).thenReturn(null);
        userService.authenticate("nonexistent", "password");
    }

    @Test(expected = AuthenticationException.class)
    public void testAuthenticateLockedAccount() {
        User mockUser = new User();
        mockUser.setStatus("LOCKED");
        when(userDAO.findByUsername("locked")).thenReturn(mockUser);
        userService.authenticate("locked", "password");
    }
}
```

**Test Categories:**
- Service layer tests (business logic)
- DAO layer tests (with DBUnit for database)
- Utility class tests
- Validation tests
- Model tests (getters/setters, business methods)

#### 14.1.2 Integration Testing

**Framework:** JUnit + DBUnit

**Database:** In-memory H2 or MySQL test instance

**Example Integration Test:**
```java
@Test
public void testDocumentUploadAndRetrieve() throws Exception {
    // Create test user
    User user = createTestUser("testuser");

    // Create test category
    Category category = createTestCategory("Test Category");

    // Prepare file upload
    FileItem fileItem = createMockFileItem("test.pdf", "application/pdf", 1024);

    Map<String, String> metadata = new HashMap<String, String>();
    metadata.put("title", "Test Document");
    metadata.put("description", "Test Description");
    metadata.put("categoryId", String.valueOf(category.getId()));

    // Upload document
    Document document = documentService.uploadDocument(fileItem, metadata, user.getId());

    // Verify document created
    assertNotNull(document);
    assertNotNull(document.getId());
    assertEquals("Test Document", document.getTitle());

    // Retrieve document
    Document retrieved = documentDAO.findById(document.getId());
    assertNotNull(retrieved);
    assertEquals(document.getId(), retrieved.getId());

    // Verify file exists
    File file = new File(retrieved.getFilePath());
    assertTrue(file.exists());
}
```

#### 14.1.3 Functional Testing

**Test Cases by Feature:**

**Document Upload Test Cases:**
1. Upload valid PDF file
2. Upload valid Word document
3. Upload invalid file type (expect error)
4. Upload file exceeding size limit (expect error)
5. Upload without title (expect validation error)
6. Upload without category (expect validation error)
7. Bulk upload multiple files
8. Upload with special characters in filename

**Search Test Cases:**
1. Basic keyword search
2. Search with no results
3. Advanced search with multiple filters
4. Search by category
5. Search by date range
6. Search with special characters
7. Search result pagination
8. Saved search functionality

**Workflow Test Cases:**
1. Submit document to workflow
2. Approve workflow task
3. Reject workflow task
4. Reassign workflow task
5. Complete multi-step workflow
6. Workflow timeout handling
7. Parallel workflow steps
8. Workflow cancellation

#### 14.1.4 Performance Testing

**Tool:** Apache JMeter

**Performance Test Scenarios:**

**Test 1: Concurrent User Load**
- Users: 500 concurrent
- Duration: 30 minutes
- Actions: Mix of browse, search, upload, download
- Success Criteria: < 5% error rate, avg response < 3 sec

**Test 2: Document Upload Stress**
- Concurrent uploads: 50
- File size: 10MB each
- Duration: 10 minutes
- Success Criteria: All uploads complete, < 10 sec each

**Test 3: Search Performance**
- Concurrent searches: 100
- Query complexity: Basic and advanced
- Document count: 100,000
- Success Criteria: Avg response < 2 sec

**Test 4: Database Query Performance**
- Measure query execution times
- Identify slow queries (> 1 sec)
- Optimize with indexes
- Success Criteria: 95% queries < 500ms

**JMeter Test Plan Example:**
```xml
<jmeterTestPlan>
    <ThreadGroup>
        <stringProp name="ThreadGroup.num_threads">500</stringProp>
        <stringProp name="ThreadGroup.ramp_time">60</stringProp>
        <stringProp name="ThreadGroup.duration">1800</stringProp>
        <HTTPSamplerProxy>
            <stringProp name="HTTPSampler.domain">edms.example.com</stringProp>
            <stringProp name="HTTPSampler.port">8080</stringProp>
            <stringProp name="HTTPSampler.path">/edms/search.do</stringProp>
            <stringProp name="HTTPSampler.method">GET</stringProp>
        </HTTPSamplerProxy>
    </ThreadGroup>
</jmeterTestPlan>
```

#### 14.1.5 Security Testing

**Security Test Checklist:**

**Authentication Tests:**
- [ ] SQL injection in login form
- [ ] Brute force attack prevention
- [ ] Session fixation
- [ ] Session hijacking
- [ ] Password complexity enforcement
- [ ] Account lockout after failed attempts

**Authorization Tests:**
- [ ] Unauthorized access to documents
- [ ] Privilege escalation
- [ ] Direct object reference
- [ ] Missing function level access control

**Input Validation Tests:**
- [ ] XSS in document title
- [ ] XSS in comments
- [ ] SQL injection in search
- [ ] Path traversal in file download
- [ ] File upload validation bypass

**Data Protection Tests:**
- [ ] HTTPS enforcement
- [ ] Password storage (hashed)
- [ ] Session cookie security (HttpOnly, Secure)
- [ ] CSRF token validation

**Tool:** OWASP ZAP (Zed Attack Proxy)

#### 14.1.6 Browser Compatibility Testing

**Browser Matrix:**
| Browser | Version | Priority | Status |
|---------|---------|----------|--------|
| IE | 8 | High | Required |
| IE | 7 | Medium | Best effort |
| Firefox | 3.6+ | High | Required |
| Chrome | 10+ | Medium | Required |
| Safari | 5+ | Low | Best effort |

**Test Cases:**
- Page rendering
- Form submission
- File upload
- AJAX functionality
- JavaScript errors
- CSS layout
- Responsive design (1024x768+)

### 14.2 Test Data

**Test Data Requirements:**
- 100 test users (various roles)
- 10 categories with hierarchy
- 1,000 test documents (various types and sizes)
- 50 workflow templates
- 500 workflow instances
- 100 tags

**Test Data Generation Script:**
```sql
-- Generate test users
INSERT INTO user (username, password_hash, full_name, email, department, status)
SELECT
    CONCAT('user', n),
    '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', -- password: Admin@123
    CONCAT('Test User ', n),
    CONCAT('user', n, '@example.com'),
    ELT(MOD(n, 5) + 1, 'Finance', 'HR', 'IT', 'Legal', 'Marketing'),
    'ACTIVE'
FROM
    (SELECT @row := @row + 1 AS n FROM
    (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION
     SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
    (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION
     SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
    (SELECT @row := 0) t3) numbers
WHERE n <= 100;
```

### 14.3 Defect Management

**Defect Severity Levels:**
- **Critical:** System crash, data loss, security breach
- **High:** Major functionality broken, no workaround
- **Medium:** Functionality broken, workaround exists
- **Low:** Cosmetic issue, minor inconvenience

**Defect Tracking:** JIRA or Bugzilla

**Defect Workflow:** Open → In Progress → Fixed → Testing → Closed

---

## 15. Risk Management

### 15.1 Identified Risks

| Risk ID | Risk Description | Probability | Impact | Severity |
|---------|------------------|-------------|--------|----------|
| R1 | Legacy technology stack compatibility issues | Medium | High | High |
| R2 | Performance degradation with large document volume | High | High | Critical |
| R3 | Security vulnerabilities due to outdated libraries | High | Critical | Critical |
| R4 | Browser compatibility issues (IE8) | Medium | Medium | Medium |
| R5 | Data migration complexity | Low | High | Medium |
| R6 | Staff expertise in legacy technologies | Medium | Medium | Medium |
| R7 | Third-party library availability | Low | High | Medium |
| R8 | File system storage scalability | Medium | High | High |
| R9 | Database performance bottlenecks | High | High | Critical |
| R10 | User adoption and training | Medium | Medium | Medium |

### 15.2 Risk Mitigation Strategies

**R1: Legacy Technology Compatibility**
- **Mitigation:** Thorough compatibility testing in dev environment
- **Contingency:** Maintain library version matrix, test thoroughly
- **Owner:** Technical Lead

**R2: Performance Degradation**
- **Mitigation:**
  - Implement database indexing strategy
  - Use Hibernate second-level cache
  - Implement pagination for all lists
  - Optimize Lucene index
  - Regular performance testing
- **Contingency:** Vertical scaling (more RAM, faster disk)
- **Owner:** Development Team

**R3: Security Vulnerabilities**
- **Mitigation:**
  - Use parameterized queries (Hibernate)
  - Implement input validation
  - Use HTTPS/TLS
  - Regular security audits
  - Keep libraries updated (within Java 5 constraints)
- **Contingency:** Security patches, WAF deployment
- **Owner:** Security Team

**R4: Browser Compatibility**
- **Mitigation:**
  - Test on all target browsers
  - Use jQuery for cross-browser compatibility
  - Avoid modern CSS features
  - Provide fallbacks
- **Contingency:** Display browser requirements, recommend upgrades
- **Owner:** Frontend Developer

**R8: File System Scalability**
- **Mitigation:**
  - Hierarchical directory structure (year/month/day)
  - Monitor disk usage
  - Implement archival strategy
  - Use SSD for better I/O
- **Contingency:** Add storage, implement compression
- **Owner:** System Administrator

**R9: Database Performance**
- **Mitigation:**
  - Proper indexing
  - Query optimization
  - Connection pooling (C3P0)
  - Regular maintenance
  - Monitoring and alerting
- **Contingency:** Database tuning, read replicas
- **Owner:** DBA

### 15.3 Assumptions and Dependencies

**Assumptions:**
- Java 5 will remain supported for project duration
- MySQL 5.7 available and licensed
- Storage capacity available for documents
- Network infrastructure adequate
- Users have compatible browsers
- Training provided before go-live

**Dependencies:**
- IT infrastructure team for server provisioning
- Security team for SSL certificates
- Network team for firewall rules
- Database team for MySQL setup
- Business users for requirements validation
- Training team for user education

---

## 16. Appendices

### 16.1 Glossary

| Term | Definition |
|------|------------|
| **DMS** | Document Management System |
| **EDMS** | Enterprise Document Management System |
| **DAO** | Data Access Object - design pattern for database operations |
| **DTO** | Data Transfer Object - object for transferring data between layers |
| **CRUD** | Create, Read, Update, Delete - basic database operations |
| **ORM** | Object-Relational Mapping - technique to map objects to database |
| **RBAC** | Role-Based Access Control - security model |
| **CSRF** | Cross-Site Request Forgery - security vulnerability |
| **XSS** | Cross-Site Scripting - security vulnerability |
| **WAR** | Web Application Archive - Java web app deployment package |
| **AJAX** | Asynchronous JavaScript and XML - web technique |
| **JSP** | JavaServer Pages - Java web view technology |
| **JSTL** | JSP Standard Tag Library |
| **HQL** | Hibernate Query Language |
| **Lucene** | Apache Lucene - full-text search library |
| **POI** | Apache POI - library for Microsoft document formats |
| **iText** | PDF generation library |
| **C3P0** | JDBC connection pooling library |
| **EHCache** | Second-level cache implementation |
| **MD5** | Message Digest algorithm for checksums |
| **SHA-256** | Secure Hash Algorithm for password hashing |
| **SSL/TLS** | Secure Sockets Layer / Transport Layer Security |
| **SMTP** | Simple Mail Transfer Protocol |

### 16.2 References

**Technology Documentation:**
- Java 5 API Documentation: https://docs.oracle.com/javase/1.5.0/docs/api/
- Struts 1.3 Documentation: https://struts.apache.org/struts13/
- Hibernate 3.6 Documentation: https://docs.jboss.org/hibernate/orm/3.6/
- MySQL 5.7 Reference Manual: https://dev.mysql.com/doc/refman/5.7/en/
- jQuery 1.12 Documentation: https://api.jquery.com/
- Apache Lucene 3.6: https://lucene.apache.org/core/3_6_2/
- Apache Tomcat 6: https://tomcat.apache.org/tomcat-6.0-doc/

**Design Patterns:**
- "Core J2EE Patterns" by Deepak Alur, John Crupi, Dan Malks
- "Patterns of Enterprise Application Architecture" by Martin Fowler

**Best Practices:**
- OWASP Top 10 Security Risks
- Java Coding Conventions
- MySQL Performance Tuning Guide

### 16.3 Sample Configurations

**log4j.properties:**
```properties
# Root logger
log4j.rootLogger=INFO, FILE, CONSOLE

# Console appender
log4j.appender.CONSOLE=org.apache.log4j.ConsoleAppender
log4j.appender.CONSOLE.layout=org.apache.log4j.PatternLayout
log4j.appender.CONSOLE.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n

# File appender
log4j.appender.FILE=org.apache.log4j.DailyRollingFileAppender
log4j.appender.FILE.File=/opt/edms/logs/application.log
log4j.appender.FILE.DatePattern='.'yyyy-MM-dd
log4j.appender.FILE.layout=org.apache.log4j.PatternLayout
log4j.appender.FILE.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n

# Package-specific logging levels
log4j.logger.com.example.edms=DEBUG
log4j.logger.org.hibernate=WARN
log4j.logger.org.hibernate.SQL=DEBUG
log4j.logger.org.hibernate.type=TRACE
log4j.logger.org.apache.struts=INFO
```

**web.xml (partial):**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.5"
         xmlns="http://java.sun.com/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
         http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">

    <display-name>Enterprise Document Management System</display-name>

    <!-- Context Parameters -->
    <context-param>
        <param-name>configLocation</param-name>
        <param-value>/opt/edms/config</param-value>
    </context-param>

    <!-- Listeners -->
    <listener>
        <listener-class>com.example.edms.listener.AppContextListener</listener-class>
    </listener>

    <!-- Filters -->
    <filter>
        <filter-name>EncodingFilter</filter-name>
        <filter-class>com.example.edms.filter.EncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
    </filter>

    <filter>
        <filter-name>AuthenticationFilter</filter-name>
        <filter-class>com.example.edms.filter.AuthenticationFilter</filter-class>
    </filter>

    <filter-mapping>
        <filter-name>EncodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>AuthenticationFilter</filter-name>
        <url-pattern>*.do</url-pattern>
    </filter-mapping>

    <!-- Struts Action Servlet -->
    <servlet>
        <servlet-name>action</servlet-name>
        <servlet-class>org.apache.struts.action.ActionServlet</servlet-class>
        <init-param>
            <param-name>config</param-name>
            <param-value>/WEB-INF/struts-config.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>action</servlet-name>
        <url-pattern>*.do</url-pattern>
    </servlet-mapping>

    <!-- Session Configuration -->
    <session-config>
        <session-timeout>30</session-timeout>
    </session-config>

    <!-- Welcome Files -->
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

    <!-- Error Pages -->
    <error-page>
        <error-code>404</error-code>
        <location>/error404.jsp</location>
    </error-page>

    <error-page>
        <error-code>500</error-code>
        <location>/error500.jsp</location>
    </error-page>
</web-app>
```

### 16.4 Change Log

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 1.0 | 2025-10-12 | Development Team | Initial specification |

---

**END OF DOCUMENT**

---

**Document Information:**
- **Total Pages:** ~130 pages (estimated when printed)
- **Word Count:** ~25,000 words
- **Last Updated:** October 12, 2025
- **Status:** Final for Development
- **Approval:** Pending

---

