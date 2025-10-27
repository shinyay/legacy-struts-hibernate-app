package com.example.edms.util;

/**
 * Constants for the EDMS application.
 */
public class Constants {

    // User status constants
    public static final String USER_STATUS_ACTIVE = "ACTIVE";
    public static final String USER_STATUS_INACTIVE = "INACTIVE";
    public static final String USER_STATUS_LOCKED = "LOCKED";
    
    // Document status constants
    public static final String DOC_STATUS_ACTIVE = "ACTIVE";
    public static final String DOC_STATUS_ARCHIVED = "ARCHIVED";
    public static final String DOC_STATUS_DELETED = "DELETED";
    
    // Document access level constants
    public static final String ACCESS_PUBLIC = "PUBLIC";
    public static final String ACCESS_PRIVATE = "PRIVATE";
    public static final String ACCESS_RESTRICTED = "RESTRICTED";
    
    // Role names
    public static final String ROLE_ADMINISTRATOR = "ADMINISTRATOR";
    public static final String ROLE_MANAGER = "MANAGER";
    public static final String ROLE_USER = "USER";
    public static final String ROLE_AUDITOR = "AUDITOR";
    public static final String ROLE_GUEST = "GUEST";
    
    // Permission resources
    public static final String RESOURCE_DOCUMENT = "DOCUMENT";
    public static final String RESOURCE_USER = "USER";
    public static final String RESOURCE_WORKFLOW = "WORKFLOW";
    public static final String RESOURCE_REPORT = "REPORT";
    public static final String RESOURCE_SYSTEM = "SYSTEM";
    
    // Permission actions
    public static final String ACTION_CREATE = "CREATE";
    public static final String ACTION_READ = "READ";
    public static final String ACTION_UPDATE = "UPDATE";
    public static final String ACTION_DELETE = "DELETE";
    public static final String ACTION_EXECUTE = "EXECUTE";
    
    // Session attributes
    public static final String SESSION_USER = "currentUser";
    public static final String SESSION_USER_ID = "currentUserId";
    public static final String SESSION_USERNAME = "currentUsername";
    public static final String SESSION_USER_ROLES = "userRoles";
    
    // File upload constants
    public static final long MAX_FILE_SIZE = 50 * 1024 * 1024; // 50MB
    public static final String UPLOAD_DIRECTORY = "/uploads/documents";
    public static final String[] ALLOWED_FILE_TYPES = {
        "pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", 
        "txt", "jpg", "jpeg", "png", "gif"
    };
    
    // Pagination constants
    public static final int DEFAULT_PAGE_SIZE = 20;
    public static final int MAX_PAGE_SIZE = 100;
    
    // Login constants
    public static final int MAX_LOGIN_ATTEMPTS = 5;
    public static final int SESSION_TIMEOUT_MINUTES = 30;
    
    // Audit log actions
    public static final String AUDIT_USER_LOGIN = "USER_LOGIN";
    public static final String AUDIT_USER_LOGOUT = "USER_LOGOUT";
    public static final String AUDIT_USER_LOGIN_FAILED = "USER_LOGIN_FAILED";
    public static final String AUDIT_DOCUMENT_UPLOAD = "DOCUMENT_UPLOAD";
    public static final String AUDIT_DOCUMENT_DOWNLOAD = "DOCUMENT_DOWNLOAD";
    public static final String AUDIT_DOCUMENT_VIEW = "DOCUMENT_VIEW";
    public static final String AUDIT_DOCUMENT_DELETE = "DOCUMENT_DELETE";
    public static final String AUDIT_DOCUMENT_UPDATE = "DOCUMENT_UPDATE";
    public static final String AUDIT_USER_CREATE = "USER_CREATE";
    public static final String AUDIT_USER_UPDATE = "USER_UPDATE";
    public static final String AUDIT_USER_DELETE = "USER_DELETE";
    
    // Message keys for internationalization
    public static final String MSG_LOGIN_SUCCESS = "login.success";
    public static final String MSG_LOGIN_FAILED = "login.failed";
    public static final String MSG_ACCOUNT_LOCKED = "account.locked";
    public static final String MSG_UPLOAD_SUCCESS = "upload.success";
    public static final String MSG_UPLOAD_FAILED = "upload.failed";
    public static final String MSG_DOWNLOAD_SUCCESS = "download.success";
    public static final String MSG_DELETE_SUCCESS = "delete.success";
    public static final String MSG_UPDATE_SUCCESS = "update.success";
    public static final String MSG_ACCESS_DENIED = "access.denied";
    public static final String MSG_FILE_TOO_LARGE = "file.too.large";
    public static final String MSG_INVALID_FILE_TYPE = "file.invalid.type";
    
    // Workflow status constants
    public static final String WORKFLOW_STATUS_PENDING = "PENDING";
    public static final String WORKFLOW_STATUS_IN_PROGRESS = "IN_PROGRESS";
    public static final String WORKFLOW_STATUS_APPROVED = "APPROVED";
    public static final String WORKFLOW_STATUS_REJECTED = "REJECTED";
    public static final String WORKFLOW_STATUS_CANCELLED = "CANCELLED";
    
    private Constants() {
        // Prevent instantiation
    }
}
