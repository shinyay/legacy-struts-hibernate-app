# Enterprise Document Management System (EDMS)

## Overview

This is an Enterprise Document Management System (EDMS) implementation built on legacy technologies:
- **Java 1.7+** (compatible with Java 17 runtime)
- **Apache Struts 1.3.10** (MVC web framework)
- **Hibernate 3.6.10** (ORM framework)
- **MySQL 5.7** (Database)
- **jQuery 1.12.4** (Frontend JavaScript)

## Architecture

### Package Structure

```
com.example.edms
├── model/              # Hibernate entities (domain model)
│   ├── User.java       # Enhanced user entity with roles and authentication
│   ├── Document.java   # Core document entity with metadata and versioning
│   ├── Category.java   # Document categorization
│   ├── Role.java       # RBAC roles
│   ├── Permission.java # Granular permissions
│   ├── Tag.java        # Document tags
│   └── AuditLog.java   # Audit trail
├── dao/                # Data Access Objects
│   └── impl/           # DAO implementations
├── service/            # Business logic layer
│   └── impl/           # Service implementations
├── action/             # Struts Action controllers
├── form/               # Struts ActionForm beans
├── util/               # Utility classes
│   ├── Constants.java  # Application constants
│   └── PasswordUtil.java # Password hashing utilities
├── filter/             # Servlet filters
└── exception/          # Custom exceptions
```

### Database Schema

The complete database schema is defined in `sql/edms-schema.sql` and includes:

#### Core Tables
- **users** - User accounts with authentication and profile information
- **roles** - System roles (Administrator, Manager, User, Auditor, Guest)
- **permissions** - Granular access permissions
- **user_roles** - User-Role associations (many-to-many)
- **role_permissions** - Role-Permission associations (many-to-many)

#### Document Management Tables
- **documents** - Document metadata and file information
- **document_versions** - Version history for documents
- **categories** - Hierarchical document categories
- **tags** - Document tags
- **document_tags** - Document-Tag associations (many-to-many)

#### Workflow Tables
- **workflows** - Workflow definitions
- **workflow_steps** - Steps in workflow definitions
- **workflow_instances** - Workflow executions
- **workflow_tasks** - Individual workflow tasks

#### Supporting Tables
- **audit_logs** - Complete audit trail of all system activities
- **comments** - Document comments
- **notifications** - User notifications

### Default Data

The schema includes default system data:

#### Default Roles
1. **ADMINISTRATOR** - Full system access
2. **MANAGER** - Department management and approvals
3. **USER** - Basic document operations
4. **AUDITOR** - Read-only access to logs and reports
5. **GUEST** - Limited public document access

#### Default Admin Account
- **Username**: `admin`
- **Password**: `admin123`
- **Email**: admin@example.com
- **Role**: Administrator

#### Default Categories
- General
- Financial
- Legal
- Human Resources
- Technical
- Marketing
- Operations

## Features Implemented

### Phase 1: Core Infrastructure ✓
- [x] Domain model (entities)
  - [x] User entity with roles and authentication
  - [x] Document entity with comprehensive metadata
  - [x] Category, Role, Permission entities
  - [x] Tag and AuditLog entities
- [x] Database schema with complete relationships
- [x] Utility classes
  - [x] Password hashing (MD5 for legacy compatibility)
  - [x] Password complexity validation
  - [x] Application constants

### Phase 2-8: To Be Implemented
- [ ] DAO layer implementation
- [ ] Service layer (business logic)
- [ ] Struts Actions (controllers)
- [ ] JSP views
- [ ] Security filters
- [ ] Hibernate mappings
- [ ] User authentication
- [ ] Document upload/download
- [ ] Search functionality
- [ ] Version control
- [ ] Workflow management
- [ ] Reporting

## Entity Model Details

### User Entity
Enhanced user model with:
- Basic profile (username, email, full name, phone, department)
- Security features (password, failed login attempts, account locking)
- Audit fields (created_at, updated_at, created_by, updated_by)
- Role associations (many-to-many with Role)
- Business methods (isActive(), isLocked(), incrementFailedLoginAttempts())

### Document Entity
Comprehensive document model with:
- Metadata (title, description, custom fields 1-5)
- File information (filename, path, size, type, MIME type)
- Categorization (category, tags)
- Access control (access level: PUBLIC/PRIVATE/RESTRICTED)
- Status tracking (status: ACTIVE/ARCHIVED/DELETED)
- Version management (current version number)
- Usage tracking (download count, view count)
- Expiration management
- Business methods (isPublic(), isActive(), isExpired(), getFileSizeFormatted())

### Role and Permission Model
Role-Based Access Control (RBAC) with:
- Roles: System-defined and custom roles
- Permissions: Granular permissions for resources and actions
- Many-to-many relationships between Users-Roles and Roles-Permissions
- Resources: DOCUMENT, USER, WORKFLOW, REPORT, SYSTEM
- Actions: CREATE, READ, UPDATE, DELETE, EXECUTE

## Security Features

### Password Security
- MD5 hashing (legacy compatibility)
- Password complexity validation
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one number
  - At least one special character
- Failed login attempt tracking
- Account locking after 5 failed attempts

### Access Control
- Role-based access control (RBAC)
- Document-level access control (PUBLIC, PRIVATE, RESTRICTED)
- Granular permissions for all operations
- Audit logging for all activities

### Audit Trail
Complete audit logging of:
- User authentication (login, logout, failed attempts)
- Document operations (upload, download, view, update, delete)
- User management operations
- IP address and user agent tracking

## Technology Stack

### Backend
- **Java**: 1.7+ (for Java 17 runtime compatibility)
- **Struts**: 1.3.10 (MVC framework)
- **Hibernate**: 3.6.10.Final (ORM)
- **MySQL**: 5.7 (Database)

### Frontend
- **JSP**: 2.1 (View layer)
- **JSTL**: 1.2 (Tag library)
- **jQuery**: 1.12.4 (JavaScript library)

### Libraries
- **Commons FileUpload**: 1.3.3 (File uploads)
- **Commons IO**: 2.4 (I/O operations)
- **Commons Lang**: 2.6 (Utilities)
- **Log4j**: 1.2.17 (Logging)

## Build and Deploy

### Prerequisites
- Java 7+ (tested with Java 17)
- Apache Ant 1.6.5+
- MySQL 5.7+
- Apache Tomcat 6.0+ (tested with 8.5)

### Build Commands
```bash
# Download required libraries
./download-hibernate-libs.sh
bash lib/download-essential.sh

# Clean and compile
ant clean compile

# Build WAR file
ant war

# Full build with documentation
ant build
```

### Database Setup
```bash
# Connect to MySQL
mysql -u root -p

# Create database and user
CREATE DATABASE legacy_db;
CREATE USER 'legacy_user'@'%' IDENTIFIED BY 'legacy_pass';
GRANT ALL PRIVILEGES ON legacy_db.* TO 'legacy_user'@'%';
FLUSH PRIVILEGES;

# Load schema
mysql -u legacy_user -p legacy_db < sql/edms-schema.sql
```

### Deploy
```bash
# Copy WAR to Tomcat
cp dist/legacy-app.war $TOMCAT_HOME/webapps/

# Or deploy manually
# WAR file will be at: dist/legacy-app.war
```

## Configuration

### Hibernate Configuration
Edit `src/main/resources/hibernate.cfg.xml`:
- Database connection settings
- Session factory configuration
- Entity mappings

### Struts Configuration
Edit `src/main/webapp/WEB-INF/struts-config.xml`:
- Action mappings
- Form beans
- Forward definitions

### Application Configuration
Edit `src/main/resources/ApplicationResources.properties`:
- Internationalization messages
- Application settings

## API Documentation

Generate Javadoc:
```bash
ant javadoc
# Output: build/docs/javadoc/
```

## Testing

### Unit Tests
```bash
ant test
```

### Manual Testing
1. Deploy application
2. Access: http://localhost:8080/legacy-app/
3. Login with: admin / admin123
4. Test document upload, download, and management

## License

This project is part of a legacy application modernization effort.

## Support

For issues and questions, please refer to the main project documentation in the `docs/` directory.
