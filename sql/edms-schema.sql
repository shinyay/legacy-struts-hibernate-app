-- Enterprise Document Management System (EDMS) Database Schema
-- MySQL 5.7 compatible schema
-- Created for legacy Struts 1.3 + Hibernate 3.6 application

-- Drop existing tables (in reverse order of dependencies)
DROP TABLE IF EXISTS workflow_tasks;
DROP TABLE IF EXISTS workflow_instances;
DROP TABLE IF EXISTS workflow_steps;
DROP TABLE IF EXISTS workflows;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS audit_logs;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS role_permissions;
DROP TABLE IF EXISTS permissions;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS document_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS document_versions;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

-- Users table (enhanced from existing)
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    department VARCHAR(100),
    profile_picture_path VARCHAR(255),
    status VARCHAR(20) DEFAULT 'ACTIVE', -- ACTIVE, INACTIVE, LOCKED
    failed_login_attempts INT DEFAULT 0,
    last_login_at DATETIME,
    password_changed_at DATETIME,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    created_by BIGINT,
    updated_by BIGINT,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Categories table for document organization
CREATE TABLE categories (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500),
    parent_id BIGINT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    INDEX idx_parent_id (parent_id),
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Documents table
CREATE TABLE documents (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size BIGINT NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    mime_type VARCHAR(100),
    category_id BIGINT NOT NULL,
    author_id BIGINT NOT NULL,
    department VARCHAR(100),
    access_level VARCHAR(20) DEFAULT 'PRIVATE', -- PUBLIC, PRIVATE, RESTRICTED
    status VARCHAR(20) DEFAULT 'ACTIVE', -- ACTIVE, ARCHIVED, DELETED
    current_version INT DEFAULT 1,
    download_count INT DEFAULT 0,
    view_count INT DEFAULT 0,
    expiration_date DATETIME,
    custom_field1 VARCHAR(255),
    custom_field2 VARCHAR(255),
    custom_field3 VARCHAR(255),
    custom_field4 VARCHAR(255),
    custom_field5 VARCHAR(255),
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    created_by BIGINT NOT NULL,
    updated_by BIGINT NOT NULL,
    INDEX idx_title (title),
    INDEX idx_category_id (category_id),
    INDEX idx_author_id (author_id),
    INDEX idx_access_level (access_level),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at),
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FULLTEXT INDEX ft_title_description (title, description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Document versions table
CREATE TABLE document_versions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    document_id BIGINT NOT NULL,
    version_number INT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size BIGINT NOT NULL,
    version_comment TEXT,
    change_summary VARCHAR(500),
    created_at DATETIME NOT NULL,
    created_by BIGINT NOT NULL,
    INDEX idx_document_id (document_id),
    INDEX idx_version_number (version_number),
    UNIQUE KEY uk_document_version (document_id, version_number),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tags table
CREATE TABLE tags (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL,
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Document-Tag association table (many-to-many)
CREATE TABLE document_tags (
    document_id BIGINT NOT NULL,
    tag_id BIGINT NOT NULL,
    PRIMARY KEY (document_id, tag_id),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Roles table
CREATE TABLE roles (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    is_system_role BOOLEAN DEFAULT FALSE,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Permissions table
CREATE TABLE permissions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    resource VARCHAR(50) NOT NULL, -- DOCUMENT, USER, WORKFLOW, REPORT, SYSTEM
    action VARCHAR(50) NOT NULL, -- CREATE, READ, UPDATE, DELETE, EXECUTE
    description VARCHAR(255),
    created_at DATETIME NOT NULL,
    INDEX idx_resource_action (resource, action)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Role-Permission association table (many-to-many)
CREATE TABLE role_permissions (
    role_id BIGINT NOT NULL,
    permission_id BIGINT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- User-Role association table (many-to-many)
CREATE TABLE user_roles (
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    assigned_at DATETIME NOT NULL,
    assigned_by BIGINT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Audit logs table
CREATE TABLE audit_logs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    action VARCHAR(100) NOT NULL,
    resource_type VARCHAR(50) NOT NULL, -- DOCUMENT, USER, WORKFLOW, SYSTEM
    resource_id BIGINT,
    details TEXT,
    ip_address VARCHAR(45),
    user_agent VARCHAR(255),
    created_at DATETIME NOT NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_resource (resource_type, resource_id),
    INDEX idx_created_at (created_at),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Comments table
CREATE TABLE comments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    document_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    parent_comment_id BIGINT,
    comment_text TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    INDEX idx_document_id (document_id),
    INDEX idx_user_id (user_id),
    INDEX idx_parent_comment_id (parent_comment_id),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_comment_id) REFERENCES comments(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Notifications table
CREATE TABLE notifications (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(50) NOT NULL, -- INFO, WARNING, ERROR, SUCCESS
    is_read BOOLEAN DEFAULT FALSE,
    related_resource_type VARCHAR(50), -- DOCUMENT, WORKFLOW, USER
    related_resource_id BIGINT,
    created_at DATETIME NOT NULL,
    read_at DATETIME,
    INDEX idx_user_id_read (user_id, is_read),
    INDEX idx_created_at (created_at),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Workflows table (workflow definitions)
CREATE TABLE workflows (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    created_by BIGINT NOT NULL,
    INDEX idx_name (name),
    FOREIGN KEY (created_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Workflow steps table (steps in a workflow definition)
CREATE TABLE workflow_steps (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    workflow_id BIGINT NOT NULL,
    step_order INT NOT NULL,
    step_name VARCHAR(100) NOT NULL,
    step_type VARCHAR(50) NOT NULL, -- APPROVAL, REVIEW, NOTIFICATION
    assigned_role_id BIGINT,
    assigned_user_id BIGINT,
    required_approvals INT DEFAULT 1,
    deadline_days INT,
    created_at DATETIME NOT NULL,
    INDEX idx_workflow_id (workflow_id),
    FOREIGN KEY (workflow_id) REFERENCES workflows(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_role_id) REFERENCES roles(id),
    FOREIGN KEY (assigned_user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Workflow instances table (actual workflow executions)
CREATE TABLE workflow_instances (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    workflow_id BIGINT NOT NULL,
    document_id BIGINT NOT NULL,
    current_step_id BIGINT,
    status VARCHAR(50) NOT NULL, -- PENDING, IN_PROGRESS, APPROVED, REJECTED, CANCELLED
    started_at DATETIME NOT NULL,
    completed_at DATETIME,
    started_by BIGINT NOT NULL,
    INDEX idx_workflow_id (workflow_id),
    INDEX idx_document_id (document_id),
    INDEX idx_status (status),
    FOREIGN KEY (workflow_id) REFERENCES workflows(id),
    FOREIGN KEY (document_id) REFERENCES documents(id),
    FOREIGN KEY (current_step_id) REFERENCES workflow_steps(id),
    FOREIGN KEY (started_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Workflow tasks table (individual tasks in a workflow instance)
CREATE TABLE workflow_tasks (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    workflow_instance_id BIGINT NOT NULL,
    workflow_step_id BIGINT NOT NULL,
    assigned_to_user_id BIGINT,
    status VARCHAR(50) NOT NULL, -- PENDING, IN_PROGRESS, APPROVED, REJECTED
    comments TEXT,
    due_date DATETIME,
    completed_at DATETIME,
    completed_by BIGINT,
    created_at DATETIME NOT NULL,
    INDEX idx_instance_id (workflow_instance_id),
    INDEX idx_assigned_to (assigned_to_user_id),
    INDEX idx_status (status),
    FOREIGN KEY (workflow_instance_id) REFERENCES workflow_instances(id) ON DELETE CASCADE,
    FOREIGN KEY (workflow_step_id) REFERENCES workflow_steps(id),
    FOREIGN KEY (assigned_to_user_id) REFERENCES users(id),
    FOREIGN KEY (completed_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insert default system data

-- Insert default roles
INSERT INTO roles (name, description, is_system_role, created_at, updated_at) VALUES
('ADMINISTRATOR', 'System administrator with full access', TRUE, NOW(), NOW()),
('MANAGER', 'Department manager with approval rights', TRUE, NOW(), NOW()),
('USER', 'Regular user with basic document access', TRUE, NOW(), NOW()),
('AUDITOR', 'Read-only access to audit logs and reports', TRUE, NOW(), NOW()),
('GUEST', 'Limited read-only access to public documents', TRUE, NOW(), NOW());

-- Insert default permissions
INSERT INTO permissions (name, resource, action, description, created_at) VALUES
-- Document permissions
('DOCUMENT_CREATE', 'DOCUMENT', 'CREATE', 'Create new documents', NOW()),
('DOCUMENT_READ', 'DOCUMENT', 'READ', 'View documents', NOW()),
('DOCUMENT_UPDATE', 'DOCUMENT', 'UPDATE', 'Edit document metadata', NOW()),
('DOCUMENT_DELETE', 'DOCUMENT', 'DELETE', 'Delete documents', NOW()),
('DOCUMENT_DOWNLOAD', 'DOCUMENT', 'EXECUTE', 'Download documents', NOW()),
('DOCUMENT_VERSION', 'DOCUMENT', 'EXECUTE', 'Manage document versions', NOW()),
-- User permissions
('USER_CREATE', 'USER', 'CREATE', 'Create user accounts', NOW()),
('USER_READ', 'USER', 'READ', 'View user information', NOW()),
('USER_UPDATE', 'USER', 'UPDATE', 'Edit user accounts', NOW()),
('USER_DELETE', 'USER', 'DELETE', 'Delete user accounts', NOW()),
-- Workflow permissions
('WORKFLOW_CREATE', 'WORKFLOW', 'CREATE', 'Create workflows', NOW()),
('WORKFLOW_READ', 'WORKFLOW', 'READ', 'View workflows', NOW()),
('WORKFLOW_UPDATE', 'WORKFLOW', 'UPDATE', 'Edit workflows', NOW()),
('WORKFLOW_DELETE', 'WORKFLOW', 'DELETE', 'Delete workflows', NOW()),
('WORKFLOW_APPROVE', 'WORKFLOW', 'EXECUTE', 'Approve workflow tasks', NOW()),
-- Report permissions
('REPORT_VIEW', 'REPORT', 'READ', 'View reports', NOW()),
('REPORT_GENERATE', 'REPORT', 'EXECUTE', 'Generate reports', NOW()),
('REPORT_EXPORT', 'REPORT', 'EXECUTE', 'Export reports', NOW()),
-- System permissions
('SYSTEM_ADMIN', 'SYSTEM', 'EXECUTE', 'System administration', NOW()),
('AUDIT_VIEW', 'SYSTEM', 'READ', 'View audit logs', NOW());

-- Assign permissions to roles
-- Administrator: All permissions
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id 
FROM roles r, permissions p 
WHERE r.name = 'ADMINISTRATOR';

-- Manager: Document + Workflow + Report permissions
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id 
FROM roles r, permissions p 
WHERE r.name = 'MANAGER' 
AND p.name IN ('DOCUMENT_CREATE', 'DOCUMENT_READ', 'DOCUMENT_UPDATE', 'DOCUMENT_DELETE', 
               'DOCUMENT_DOWNLOAD', 'DOCUMENT_VERSION', 'WORKFLOW_READ', 'WORKFLOW_APPROVE', 
               'REPORT_VIEW', 'REPORT_GENERATE', 'USER_READ');

-- User: Basic document permissions
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id 
FROM roles r, permissions p 
WHERE r.name = 'USER' 
AND p.name IN ('DOCUMENT_CREATE', 'DOCUMENT_READ', 'DOCUMENT_UPDATE', 'DOCUMENT_DOWNLOAD', 
               'DOCUMENT_VERSION', 'WORKFLOW_READ', 'USER_READ');

-- Auditor: Read-only permissions
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id 
FROM roles r, permissions p 
WHERE r.name = 'AUDITOR' 
AND p.name IN ('DOCUMENT_READ', 'USER_READ', 'WORKFLOW_READ', 'REPORT_VIEW', 
               'REPORT_GENERATE', 'REPORT_EXPORT', 'AUDIT_VIEW');

-- Guest: Minimal read permissions
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id 
FROM roles r, permissions p 
WHERE r.name = 'GUEST' 
AND p.name IN ('DOCUMENT_READ');

-- Insert default admin user (password: admin123)
-- Password is MD5 hash of 'admin123'
INSERT INTO users (username, password, email, full_name, department, status, created_at, updated_at, password_changed_at) VALUES
('admin', '0192023A7BBD73250516F069DF18B500', 'admin@example.com', 'System Administrator', 'IT', 'ACTIVE', NOW(), NOW(), NOW());

-- Assign admin role to default admin user
INSERT INTO user_roles (user_id, role_id, assigned_at) 
SELECT u.id, r.id, NOW() 
FROM users u, roles r 
WHERE u.username = 'admin' AND r.name = 'ADMINISTRATOR';

-- Insert default categories
INSERT INTO categories (name, description, created_at, updated_at) VALUES
('General', 'General documents', NOW(), NOW()),
('Financial', 'Financial documents and reports', NOW(), NOW()),
('Legal', 'Legal documents and contracts', NOW(), NOW()),
('Human Resources', 'HR documents and policies', NOW(), NOW()),
('Technical', 'Technical documentation', NOW(), NOW()),
('Marketing', 'Marketing materials', NOW(), NOW()),
('Operations', 'Operational documents', NOW(), NOW());

-- Create indexes for better performance
CREATE INDEX idx_documents_created_at_desc ON documents(created_at DESC);
CREATE INDEX idx_audit_logs_created_at_desc ON audit_logs(created_at DESC);
CREATE INDEX idx_notifications_user_created_desc ON notifications(user_id, created_at DESC);
