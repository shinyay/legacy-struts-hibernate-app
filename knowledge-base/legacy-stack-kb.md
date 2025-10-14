# Legacy Application Stacks Development Knowledge Base

## Table of Contents

1. Development Environment Overview
2. Technology Stack Integration
3. Project Structure and Organization
4. Development Workflow
5. Database Development with MySQL and Hibernate
6. Frontend Development with jQuery
7. Struts Integration Patterns
8. Build and Deployment
9. Testing Strategies
10. Debugging and Troubleshooting
11. Performance Optimization
12. Security Best Practices

---

## 1. Development Environment Overview

### 1.1 Environment Architecture

This workspace provides a complete legacy Java development environment using VS Code Dev Containers:

```
┌─────────────────────────────────────────────────────────────┐
│                  Development Environment                     │
├─────────────────────────────────────────────────────────────┤
│  Dev Container (java5-dev)                                  │
│  ├─ Java 1.5.0_22 (J2SE 5.0)                              │
│  ├─ Apache Ant 1.6.5                                       │
│  ├─ VS Code Extensions                                     │
│  └─ Development Tools                                      │
├─────────────────────────────────────────────────────────────┤
│  Application Services (Host Network)                        │
│  ├─ Tomcat 5.5/6.0 (Port 8080/8081)                       │
│  ├─ MySQL 5.7 (Port 3306)                                 │
│  └─ phpMyAdmin (Port 8082)                                 │
└─────────────────────────────────────────────────────────────┘
```

### 1.2 Key Components

#### Java Runtime
- **Version**: Java 1.5.0_22 (J2SE 5.0)
- **Location**: `/usr/java/jdk1.5.0_22/`
- **JAVA_HOME**: Set automatically in Dev Container
- **Features**: Generics, enhanced for-loop, autoboxing, enums, varargs

#### Build System
- **Tool**: Apache Ant 1.6.5
- **Build File**: `build.xml`
- **Ant Home**: Pre-configured in Dev Container
- **Target Java**: 1.5 compatibility

#### Application Server
- **Primary**: Tomcat 6.0.53 (recommended for Struts 1.x)
- **Alternative**: Tomcat 5.5.36 or 8.5
- **Configuration**: See `.devcontainer/compose.services.yaml`
- **Deployment**: Automatic via volume mount to `dist`

#### Database
- **DBMS**: MySQL 5.7
- **Connection**: JDBC 5.1.x compatible
- **ORM**: Hibernate 3.6.10.Final
- **Admin UI**: phpMyAdmin 5.1

### 1.3 Development Tools

#### VS Code Extensions (Auto-installed)
| Extension | Purpose |
|-----------|---------|
| `redhat.java` | Java language support |
| `redhat.vscode-xml` | XML/JSP editing |
| `eamodio.gitlens` | Git integration |
| `gabrielgrinberg.ant-gradle-xml-formatter` | Ant build files |
| `ithildir.java-properties` | Properties files |

#### Command Line Tools
```bash
# Available in Dev Container
java -version     # Java 1.5.0_22
ant -version      # Apache Ant 1.6.5
git --version     # Git (latest)
gh --version      # GitHub CLI
mysql --version   # MySQL client
curl --version    # HTTP client
```

### 1.4 File System Layout

```
/app/
├── src/
│   ├── main/
│   │   ├── java/              # Java source code
│   │   │   └── com/example/
│   │   │       ├── action/    # Struts Actions
│   │   │       ├── form/      # ActionForms
│   │   │       ├── dao/       # Data Access Objects
│   │   │       ├── model/     # Domain models (Hibernate entities)
│   │   │       ├── service/   # Business logic layer
│   │   │       └── util/      # Utility classes
│   │   ├── resources/         # Configuration files
│   │   │   ├── hibernate.cfg.xml
│   │   │   └── *.hbm.xml      # Hibernate mappings
│   │   └── webapp/            # Web application files
│   │       ├── WEB-INF/
│   │       │   ├── web.xml
│   │       │   ├── struts-config.xml
│   │       │   └── lib/       # Runtime JARs
│   │       ├── css/           # Stylesheets
│   │       ├── js/            # JavaScript (jQuery)
│   │       ├── images/        # Static images
│   │       └── *.jsp          # JSP pages
│   └── test/
│       └── java/              # Test classes
├── lib/                       # Build-time dependencies
├── build/                     # Compiled output (generated)
├── dist/                      # WAR files (generated)
├── config/                    # Environment configs
├── docs/                      # Documentation
│   ├── ARCHITECTURE.md
│   ├── QUICK_REFERENCE.md
│   └── TROUBLESHOOTING.md
├── knowledge-base/            # Knowledge bases
│   ├── struts-kb.md
│   └── legacy-stack-kb.md
├── build.xml                  # Ant build script
└── .devcontainer/            # Dev Container configuration
```

### 1.5 Network and Ports

| Service | Port | Access URL | Purpose |
|---------|------|------------|---------|
| Tomcat | 8080/8081 | http://localhost:8080/legacy-app/ | Application server |
| MySQL | 3306 | localhost:3306 | Database server |
| phpMyAdmin | 8082 | http://localhost:8082/ | Database UI |
| Debug Port | 9000 | localhost:9000 | Remote debugging |

### 1.6 Environment Variables

```bash
# Java Configuration
JAVA_HOME=/usr/java/jdk1.5.0_22
PATH=$JAVA_HOME/bin:$PATH

# Tomcat Configuration
CATALINA_HOME=/usr/local/tomcat
CATALINA_OPTS="-Xms256m -Xmx512m"

# Database Configuration
DB_HOST=mysql
DB_PORT=3306
DB_NAME=legacy_db
DB_USER=legacy_user
DB_PASSWORD=legacy_pass
```

---

## 2. Technology Stack Integration

### 2.1 Stack Overview

This environment integrates five core technologies:

```
┌─────────────┐
│   Browser   │
└──────┬──────┘
       │ HTTP
       ↓
┌─────────────────────────────────┐
│  Tomcat (Servlet Container)     │
│  ┌──────────────────────────┐   │
│  │  Struts 1.3.10 (MVC)    │   │
│  │  - ActionServlet        │   │
│  │  - Actions              │   │
│  │  - ActionForms          │   │
│  └──────────┬───────────────┘   │
│             │                    │
│  ┌──────────▼───────────────┐   │
│  │  JSP Pages               │   │
│  │  - Struts Tags          │   │
│  │  - jQuery 1.12.4        │   │
│  └──────────────────────────┘   │
└─────────────┬───────────────────┘
              │
       ┌──────▼──────┐
       │  Hibernate  │
       │  3.6.10     │
       └──────┬──────┘
              │ JDBC
       ┌──────▼──────┐
       │  MySQL 5.7  │
       └─────────────┘
```

### 2.2 Technology Versions and Compatibility

| Technology | Version | Java 5 Compatible | Notes |
|------------|---------|-------------------|-------|
| Java | 1.5.0_22 | ✅ Core | J2SE 5.0 |
| Struts | 1.3.10 | ✅ Yes | Last stable release |
| Hibernate | 3.6.10.Final | ✅ Yes | Supports Java 5 |
| jQuery | 1.12.4 | ✅ Yes | IE 6-8 compatible |
| MySQL Connector | 5.1.49 | ✅ Yes | JDBC 3.0 compatible |
| Servlet API | 2.5 | ✅ Yes | Java EE 5 |
| JSP API | 2.1 | ✅ Yes | Java EE 5 |
| Commons Collections | 3.2.2 | ✅ Yes | Struts dependency |
| Commons BeanUtils | 1.8.0 | ✅ Yes | Struts dependency |

### 2.3 Library Dependencies

#### Required JARs (in `lib/`)
```
# Struts Framework (12 JARs)
struts-core-1.3.10.jar
struts-taglib-1.3.10.jar
servlet-api-2.5.jar
jsp-api-2.1.jar
commons-beanutils-1.8.0.jar
commons-chain-1.2.jar
commons-digester-1.8.jar
commons-fileupload-1.1.1.jar
commons-io-1.1.jar
commons-logging-1.0.4.jar
commons-validator-1.3.1.jar
oro-2.0.8.jar

# Hibernate ORM (8 JARs - downloaded via script)
hibernate-core-3.6.10.Final.jar
hibernate-commons-annotations-3.2.0.Final.jar
hibernate-jpa-2.0-api-1.0.1.Final.jar
javassist-3.12.0.GA.jar
jta-1.1.jar
slf4j-api-1.6.1.jar
slf4j-simple-1.6.1.jar
antlr-2.7.6.jar

# MySQL JDBC Driver
mysql-connector-java-5.1.49.jar

# Additional Dependencies
dom4j-1.6.1.jar (XML processing)
jstl-1.2.jar (JSP Standard Tag Library)
```

#### Download Script
```bash
# Hibernate libraries
./download-hibernate-libs.sh

# Manual download alternative
# See: lib/HIBERNATE_LIBRARIES.md
```

### 2.4 Integration Points

#### Struts + Hibernate Integration
```java
// Action class using Hibernate
public class UserAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                               ActionForm form,
                               HttpServletRequest request,
                               HttpServletResponse response) throws Exception {

        // Get Hibernate session from filter
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();

        // Begin transaction
        session.beginTransaction();

        try {
            // Use DAO with Hibernate
            UserDAO userDAO = new UserDAOImpl();
            List<User> users = userDAO.findAll();

            // Store in request for JSP
            request.setAttribute("users", users);

            // Commit transaction
            session.getTransaction().commit();

            return mapping.findForward("success");

        } catch (Exception e) {
            session.getTransaction().rollback();
            throw e;
        }
    }
}
```

#### jQuery + Struts AJAX Integration
```jsp
<%-- JSP with jQuery AJAX calling Struts Action --%>
<script src="js/jquery-1.12.4.min.js"></script>
<script>
$(document).ready(function() {
    $('#saveUserBtn').click(function() {
        $.ajax({
            url: 'user/save.do',
            type: 'POST',
            data: {
                username: $('#username').val(),
                email: $('#email').val(),
                password: $('#password').val()
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert('User saved successfully!');
                    loadUserList();
                } else {
                    alert('Error: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                alert('AJAX error: ' + error);
            }
        });
    });
});
</script>
```

```java
// Struts Action returning JSON for jQuery
public class UserAction extends Action {

    public ActionForward saveUser(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) throws Exception {

        // Process user data
        UserForm userForm = (UserForm) form;
        UserDAO userDAO = new UserDAOImpl();

        try {
            User user = new User();
            user.setUsername(userForm.getUsername());
            user.setEmail(userForm.getEmail());
            user.setPassword(userForm.getPassword());

            userDAO.save(user);

            // Return JSON response
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\":true,\"message\":\"User saved\"}");
            out.flush();

        } catch (Exception e) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
            out.flush();
        }

        return null; // No forward needed for AJAX
    }
}
```

#### Hibernate Session Management
```java
// HibernateUtil.java - Session Factory management
public class HibernateUtil {

    private static final SessionFactory sessionFactory;

    static {
        try {
            Configuration configuration = new Configuration();
            configuration.configure("hibernate.cfg.xml");
            sessionFactory = configuration.buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        getSessionFactory().close();
    }
}
```

```java
// HibernateSessionFilter.java - Filter for session-per-request
public class HibernateSessionFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();

        try {
            chain.doFilter(request, response);
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
            throw new ServletException(e);
        } finally {
            session.close();
        }
    }

    public void init(FilterConfig config) throws ServletException {}
    public void destroy() {}
}
```

---

## 3. Project Structure and Organization

### 3.1 Layered Architecture Pattern

This workspace follows a classic enterprise Java layered architecture:

```
┌─────────────────────────────────────────────────────┐
│              Presentation Layer (View)              │
│  - JSP Pages                                        │
│  - Struts Tag Libraries                            │
│  - jQuery Scripts                                  │
│  - CSS Stylesheets                                 │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│            Controller Layer (Struts)                │
│  - ActionServlet (Front Controller)                │
│  - Action Classes (Request Handlers)               │
│  - ActionForms (Data Binding)                      │
│  - ActionMappings (Routing)                        │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│              Business Logic Layer                   │
│  - Service Classes (Optional)                      │
│  - Business Rules                                  │
│  - Transaction Management                          │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│          Data Access Layer (DAO Pattern)            │
│  - DAO Interfaces                                  │
│  - DAO Implementations                             │
│  - Hibernate Session Management                    │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│               Domain Model Layer                    │
│  - Entity Classes (POJOs)                          │
│  - Hibernate Mappings (*.hbm.xml)                  │
│  - Value Objects                                   │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                Database (MySQL)                     │
│  - Tables, Views, Stored Procedures                │
└─────────────────────────────────────────────────────┘
```

### 3.2 Package Structure

```java
com.example/
├── action/                    // Controller Layer (Struts Actions)
│   ├── BaseAction.java       // Common action functionality
│   ├── UserAction.java       // User management actions
│   ├── SampleAction.java     // Sample/demo actions
│   └── LoginAction.java      // Authentication actions
│
├── form/                      // Form Beans (Data Transfer)
│   ├── UserForm.java         // User form data
│   ├── LoginForm.java        // Login form data
│   └── SearchForm.java       // Search criteria form
│
├── model/                     // Domain Model (Hibernate Entities)
│   ├── User.java             // User entity
│   ├── User.hbm.xml          // Hibernate mapping for User
│   ├── BaseEntity.java       // Common entity properties
│   └── package-info.java     // Package documentation
│
├── dao/                       // Data Access Layer
│   ├── UserDAO.java          // User DAO interface
│   ├── BaseDAO.java          // Generic DAO interface
│   └── impl/                 // DAO Implementations
│       ├── UserDAOImpl.java  // User DAO implementation
│       └── BaseDAOImpl.java  // Generic DAO implementation
│
├── service/                   // Business Logic Layer (Optional)
│   ├── UserService.java      // User business logic interface
│   └── impl/
│       └── UserServiceImpl.java
│
├── util/                      // Utility Classes
│   ├── HibernateUtil.java    // Hibernate session factory
│   ├── DateUtil.java         // Date formatting/parsing
│   ├── StringUtil.java       // String operations
│   └── Constants.java        // Application constants
│
├── filter/                    // Servlet Filters
│   ├── HibernateSessionFilter.java  // Session-per-request
│   ├── EncodingFilter.java          // Character encoding
│   └── AuthenticationFilter.java    // Security filter
│
├── listener/                  // Servlet Listeners
│   ├── HibernateSessionFactoryListener.java
│   └── ApplicationContextListener.java
│
└── exception/                 // Custom Exceptions
    ├── DAOException.java
    ├── ServiceException.java
    └── BusinessException.java
```

### 3.3 Source Directory Structure

```
src/main/
├── java/                                    # Java source files
│   └── com/example/                        # Root package
│       ├── action/                         # Struts Actions
│       ├── form/                           # ActionForms
│       ├── model/                          # Domain entities
│       ├── dao/                            # Data access
│       ├── service/                        # Business logic
│       ├── util/                           # Utilities
│       ├── filter/                         # Filters
│       ├── listener/                       # Listeners
│       └── exception/                      # Exceptions
│
├── resources/                               # Configuration files
│   ├── hibernate.cfg.xml                   # Hibernate configuration
│   ├── ApplicationResources.properties     # i18n messages
│   ├── log4j.properties                    # Logging configuration
│   └── com/example/model/                  # Hibernate mappings
│       ├── User.hbm.xml
│       └── *.hbm.xml
│
└── webapp/                                  # Web application root
    ├── index.jsp                           # Default page
    ├── sample.jsp                          # Sample page
    ├── users.jsp                           # User listing
    ├── test-db.jsp                         # DB connection test
    │
    ├── css/                                # Stylesheets
    │   ├── style.css                       # Main stylesheet
    │   └── legacy.css                      # Legacy styles
    │
    ├── js/                                 # JavaScript files
    │   ├── jquery-1.12.4.min.js           # jQuery library
    │   ├── app.js                          # Application scripts
    │   └── validation.js                   # Form validation
    │
    ├── images/                             # Static images
    │   ├── logo.png
    │   └── icons/
    │
    ├── includes/                           # JSP includes
    │   ├── header.jsp                      # Common header
    │   ├── footer.jsp                      # Common footer
    │   └── navigation.jsp                  # Navigation menu
    │
    └── WEB-INF/                            # Protected resources
        ├── web.xml                         # Deployment descriptor
        ├── struts-config.xml               # Struts configuration
        ├── validation.xml                  # Validation rules
        ├── validator-rules.xml             # Validator definitions
        │
        ├── struts-bean.tld                 # Struts bean tag library
        ├── struts-html.tld                 # Struts HTML tag library
        ├── struts-logic.tld                # Struts logic tag library
        ├── struts-nested.tld               # Struts nested tag library
        │
        ├── classes/                        # Compiled classes (build output)
        │   ├── com/example/                # Compiled Java classes
        │   ├── hibernate.cfg.xml           # Hibernate config (copied)
        │   └── ApplicationResources.properties
        │
        └── lib/                            # Runtime libraries
            ├── struts-core-1.3.10.jar
            ├── hibernate-core-3.6.10.Final.jar
            ├── mysql-connector-java-5.1.49.jar
            └── *.jar                       # All dependencies
```

### 3.4 Build Output Structure

```
build/                                       # Ant build output directory
├── classes/                                # Compiled .class files
│   ├── com/example/                        # Package hierarchy
│   │   ├── action/*.class
│   │   ├── form/*.class
│   │   ├── model/*.class
│   │   └── dao/*.class
│   ├── hibernate.cfg.xml                   # Copied from resources
│   └── ApplicationResources.properties     # Copied from resources
│
├── war/                                     # Exploded WAR structure
│   ├── *.jsp                               # JSP files
│   ├── css/                                # Stylesheets
│   ├── js/                                 # JavaScript
│   ├── images/                             # Images
│   └── WEB-INF/
│       ├── web.xml
│       ├── struts-config.xml
│       ├── classes/                        # Compiled classes
│       └── lib/                            # JAR dependencies
│
├── docs/                                    # Generated documentation
│   └── javadoc/                            # Javadoc API docs
│       ├── index.html
│       ├── overview-summary.html
│       └── com/example/                    # Package docs
│
└── test-classes/                           # Compiled test classes
    └── com/example/test/
```

### 3.5 Distribution Structure

```
dist/                                        # Distribution directory
├── legacy-app.war                          # Deployable WAR file
└── legacy-app-src.zip                      # Source distribution (optional)
```

### 3.6 Configuration Files Organization

#### Web Application Configuration
```
WEB-INF/
├── web.xml                    # Servlet configuration
├── struts-config.xml          # Struts routing and configuration
├── validation.xml             # Form validation rules
└── validator-rules.xml        # Validation rule definitions
```

#### Hibernate Configuration
```
resources/
├── hibernate.cfg.xml          # Main Hibernate config
└── com/example/model/
    ├── User.hbm.xml          # User entity mapping
    ├── Role.hbm.xml          # Role entity mapping
    └── *.hbm.xml             # Other entity mappings
```

#### Application Properties
```
resources/
├── ApplicationResources.properties              # Default (English)
├── ApplicationResources_ja.properties           # Japanese
├── ApplicationResources_es.properties           # Spanish
└── log4j.properties                            # Logging config
```

### 3.7 Naming Conventions

#### Java Classes
| Type | Convention | Example |
|------|------------|---------|
| Action | `<Entity>Action` | `UserAction`, `LoginAction` |
| Form | `<Entity>Form` | `UserForm`, `SearchForm` |
| Entity | `<Entity>` | `User`, `Role`, `Product` |
| DAO Interface | `<Entity>DAO` | `UserDAO`, `ProductDAO` |
| DAO Impl | `<Entity>DAOImpl` | `UserDAOImpl`, `ProductDAOImpl` |
| Service | `<Entity>Service` | `UserService`, `OrderService` |
| Service Impl | `<Entity>ServiceImpl` | `UserServiceImpl` |
| Util | `<Purpose>Util` | `DateUtil`, `StringUtil` |
| Filter | `<Purpose>Filter` | `EncodingFilter`, `AuthFilter` |
| Listener | `<Purpose>Listener` | `HibernateListener` |
| Exception | `<Type>Exception` | `DAOException`, `ServiceException` |

#### Configuration Files
| Type | Convention | Example |
|------|------------|---------|
| Struts Config | `struts-config.xml` | Main config |
| Struts Module | `struts-config-<module>.xml` | `struts-config-admin.xml` |
| Hibernate Config | `hibernate.cfg.xml` | Main config |
| Hibernate Mapping | `<Entity>.hbm.xml` | `User.hbm.xml` |
| Properties | `<purpose>.properties` | `database.properties` |
| i18n | `ApplicationResources_<locale>.properties` | `ApplicationResources_ja.properties` |

#### Web Resources
| Type | Convention | Example |
|------|------------|---------|
| JSP Pages | `lowercase-hyphen.jsp` | `user-list.jsp`, `login.jsp` |
| CSS Files | `lowercase-hyphen.css` | `main-style.css` |
| JavaScript | `lowercase-hyphen.js` | `form-validation.js` |
| Images | `lowercase-hyphen.<ext>` | `company-logo.png` |

#### URL Mappings
| Type | Convention | Example |
|------|------------|---------|
| Action URL | `/<path>/<action>.do` | `/user/list.do`, `/admin/delete.do` |
| JSP Direct | `/<page>.jsp` | `/index.jsp`, `/about.jsp` |
| Static | `/<type>/<file>` | `/css/style.css`, `/js/app.js` |

### 3.8 File Organization Best Practices

#### 1. Separation of Concerns
- Keep presentation logic in JSP files
- Keep business logic in Action/Service classes
- Keep data access logic in DAO classes
- Keep domain logic in Entity classes

#### 2. Configuration Centralization
- All Struts mappings in `struts-config.xml`
- All Hibernate mappings in `*.hbm.xml` files
- All application messages in `ApplicationResources.properties`
- All database settings in `hibernate.cfg.xml`

#### 3. Resource Modularization
```
webapp/
├── modules/                   # Feature modules
│   ├── user/                 # User management
│   │   ├── user-list.jsp
│   │   ├── user-edit.jsp
│   │   └── user-view.jsp
│   ├── admin/                # Admin module
│   └── reports/              # Reports module
│
└── common/                    # Shared resources
    ├── includes/             # Common JSP includes
    ├── css/                  # Shared styles
    └── js/                   # Shared scripts
```

#### 4. Test Organization
```
src/test/
├── java/                      # Test source
│   └── com/example/
│       ├── action/           # Action tests
│       ├── dao/              # DAO tests
│       └── service/          # Service tests
│
└── resources/                 # Test resources
    ├── test-hibernate.cfg.xml
    └── test-data.sql
```

### 3.9 Documentation Structure

```
docs/
├── ARCHITECTURE.md            # System architecture
├── SETUP-GUIDE.md            # Setup instructions
├── TROUBLESHOOTING.md        # Common issues
├── API.md                    # API documentation
├── DEPLOYMENT.md             # Deployment guide
│
├── diagrams/                  # Architecture diagrams
│   ├── system-architecture.png
│   ├── database-schema.png
│   └── request-flow.png
│
└── templates/                 # Code templates
    ├── Action-template.java
    ├── DAO-template.java
    └── Entity-template.java
```

### 3.10 Version Control Organization

#### .gitignore Best Practices
```gitignore
# Build outputs
/build/
/dist/
*.war
*.jar (except lib/)

# IDE files
.settings/
.classpath
.project
*.iml
.idea/

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary files
*.tmp
*.bak
*~

# Database files (local only)
*.db
*.sqlite

# Keep these
!lib/*.jar
!src/
!docs/
```

#### Repository Structure
```
project-root/
├── .git/                      # Git repository
├── .gitignore                # Ignore patterns
├── .devcontainer/            # Dev container config
├── README.md                 # Project overview
├── build.xml                 # Build script
├── src/                      # Source code (tracked)
├── lib/                      # Dependencies (tracked)
├── docs/                     # Documentation (tracked)
├── config/                   # Configurations (tracked)
└── knowledge-base/           # Knowledge bases (tracked)
```

---

## 4. Development Workflow

### 4.1 Daily Development Cycle

```
┌──────────────────────────────────────────────────────────────┐
│                    Development Workflow                       │
└──────────────────────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────────────────────┐
│ 1. Start Dev Container                                       │
│    - VS Code: Reopen in Container                           │
│    - Services auto-start: Tomcat, MySQL                     │
└──────────────────────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────────────────────┐
│ 2. Code Changes                                              │
│    - Edit Java classes (Actions, DAOs, Entities)            │
│    - Modify JSP pages                                        │
│    - Update configurations (struts-config.xml, etc.)        │
│    - Add/modify JavaScript (jQuery)                         │
└──────────────────────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────────────────────┐
│ 3. Build Application                                         │
│    - Run: ant clean compile                                 │
│    - Or: ant war (for full WAR)                            │
└──────────────────────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────────────────────┐
│ 4. Deploy to Tomcat                                          │
│    - Auto-deploy: WAR copied to dist/ (volume mount)        │
│    - Or manual: Copy to Tomcat webapps/                     │
└──────────────────────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────────────────────┐
│ 5. Test in Browser                                           │
│    - Open: http://localhost:8080/legacy-app/               │
│    - Test functionality                                      │
│    - Check logs in Tomcat console                           │
└──────────────────────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────────────────────┐
│ 6. Debug (if needed)                                         │
│    - Check Tomcat logs                                       │
│    - Use VS Code debugger                                    │
│    - Add logging statements                                  │
└──────────────────────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────────────────────┐
│ 7. Iterate                                                   │
│    - Repeat steps 2-6 until feature complete                │
└──────────────────────────────────────────────────────────────┘
    ↓
┌──────────────────────────────────────────────────────────────┐
│ 8. Commit Changes                                            │
│    - git add .                                              │
│    - git commit -m "Feature description"                    │
│    - git push                                               │
└──────────────────────────────────────────────────────────────┘
```

### 4.2 Common Development Tasks

#### Task 1: Creating a New Entity

**Step-by-step workflow:**

```bash
# 1. Create the entity class
# File: src/main/java/com/example/model/Product.java
```

```java
package com.example.model;

import java.io.Serializable;
import java.util.Date;

public class Product implements Serializable {
    private Long id;
    private String name;
    private String description;
    private Double price;
    private Date createdDate;

    // Default constructor (required by Hibernate)
    public Product() {}

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', price=" + price + "}";
    }
}
```

```bash
# 2. Create Hibernate mapping
# File: src/main/resources/com/example/model/Product.hbm.xml
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC
    "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
    "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">

<hibernate-mapping package="com.example.model">
    <class name="Product" table="products">
        <id name="id" column="id">
            <generator class="native"/>
        </id>

        <property name="name" column="name" type="string" length="100" not-null="true"/>
        <property name="description" column="description" type="text"/>
        <property name="price" column="price" type="double"/>
        <property name="createdDate" column="created_date" type="timestamp"/>
    </class>
</hibernate-mapping>
```

```bash
# 3. Register mapping in hibernate.cfg.xml
# Add to src/main/resources/hibernate.cfg.xml
```

```xml
<mapping resource="com/example/model/Product.hbm.xml"/>
```

```bash
# 4. Create database table
# Connect to MySQL and run:
```

```sql
CREATE TABLE products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DOUBLE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

```bash
# 5. Build and test
ant clean compile
```

#### Task 2: Creating a New DAO

```java
// 1. Create DAO interface
// File: src/main/java/com/example/dao/ProductDAO.java
package com.example.dao;

import com.example.model.Product;
import java.util.List;

public interface ProductDAO {
    void save(Product product);
    void update(Product product);
    void delete(Long id);
    Product findById(Long id);
    List<Product> findAll();
    List<Product> findByName(String name);
}
```

```java
// 2. Create DAO implementation
// File: src/main/java/com/example/dao/impl/ProductDAOImpl.java
package com.example.dao.impl;

import com.example.dao.ProductDAO;
import com.example.model.Product;
import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Query;
import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public void save(Product product) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.save(product);
    }

    @Override
    public void update(Product product) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.update(product);
    }

    @Override
    public void delete(Long id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Product product = (Product) session.get(Product.class, id);
        if (product != null) {
            session.delete(product);
        }
    }

    @Override
    public Product findById(Long id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        return (Product) session.get(Product.class, id);
    }

    @Override
    public List<Product> findAll() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Product order by name");
        return query.list();
    }

    @Override
    public List<Product> findByName(String name) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Product where name like :name");
        query.setParameter("name", "%" + name + "%");
        return query.list();
    }
}
```

```bash
# 3. Build and test
ant clean compile
```

#### Task 3: Creating a New Struts Action

```java
// 1. Create ActionForm
// File: src/main/java/com/example/form/ProductForm.java
package com.example.form;

import org.apache.struts.action.ActionForm;

public class ProductForm extends ActionForm {
    private String id;
    private String name;
    private String description;
    private String price;

    // Getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPrice() { return price; }
    public void setPrice(String price) { this.price = price; }

    // Reset method
    @Override
    public void reset(org.apache.struts.action.ActionMapping mapping,
                     javax.servlet.http.HttpServletRequest request) {
        this.id = null;
        this.name = null;
        this.description = null;
        this.price = null;
    }
}
```

```java
// 2. Create Action class
// File: src/main/java/com/example/action/ProductAction.java
package com.example.action;

import com.example.dao.ProductDAO;
import com.example.dao.impl.ProductDAOImpl;
import com.example.form.ProductForm;
import com.example.model.Product;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class ProductAction extends Action {

    // List all products
    public ActionForward list(ActionMapping mapping,
                             ActionForm form,
                             HttpServletRequest request,
                             HttpServletResponse response) throws Exception {

        ProductDAO productDAO = new ProductDAOImpl();
        List<Product> products = productDAO.findAll();

        request.setAttribute("products", products);
        return mapping.findForward("list");
    }

    // View product details
    public ActionForward view(ActionMapping mapping,
                             ActionForm form,
                             HttpServletRequest request,
                             HttpServletResponse response) throws Exception {

        String idStr = request.getParameter("id");
        Long id = Long.parseLong(idStr);

        ProductDAO productDAO = new ProductDAOImpl();
        Product product = productDAO.findById(id);

        request.setAttribute("product", product);
        return mapping.findForward("view");
    }

    // Save product
    public ActionForward save(ActionMapping mapping,
                             ActionForm form,
                             HttpServletRequest request,
                             HttpServletResponse response) throws Exception {

        ProductForm productForm = (ProductForm) form;

        Product product = new Product();
        product.setName(productForm.getName());
        product.setDescription(productForm.getDescription());
        product.setPrice(Double.parseDouble(productForm.getPrice()));

        ProductDAO productDAO = new ProductDAOImpl();
        productDAO.save(product);

        return mapping.findForward("success");
    }
}
```

```xml
<!-- 3. Configure in struts-config.xml -->
<!-- File: src/main/webapp/WEB-INF/struts-config.xml -->

<!-- Add form-bean -->
<form-beans>
    <form-bean name="productForm" type="com.example.form.ProductForm"/>
</form-beans>

<!-- Add action mappings -->
<action-mappings>
    <action path="/product/list"
            type="com.example.action.ProductAction"
            parameter="list">
        <forward name="list" path="/product-list.jsp"/>
    </action>

    <action path="/product/view"
            type="com.example.action.ProductAction"
            parameter="view">
        <forward name="view" path="/product-view.jsp"/>
    </action>

    <action path="/product/save"
            type="com.example.action.ProductAction"
            name="productForm"
            parameter="save"
            validate="true"
            input="/product-form.jsp">
        <forward name="success" path="/product/list.do" redirect="true"/>
    </action>
</action-mappings>
```

```jsp
<!-- 4. Create JSP page -->
<!-- File: src/main/webapp/product-list.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<html:html>
<head>
    <title>Product List</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <h1>Product List</h1>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <logic:iterate id="product" name="products">
                <tr>
                    <td><bean:write name="product" property="id"/></td>
                    <td><bean:write name="product" property="name"/></td>
                    <td><bean:write name="product" property="price"/></td>
                    <td>
                        <html:link action="/product/view" paramId="id" paramName="product" paramProperty="id">
                            View
                        </html:link>
                    </td>
                </tr>
            </logic:iterate>
        </tbody>
    </table>

    <p>
        <html:link action="/product/add">Add New Product</html:link>
    </p>
</body>
</html:html>
```

```bash
# 5. Build and deploy
ant clean war
# Access: http://localhost:8080/legacy-app/product/list.do
```

#### Task 4: Adding jQuery AJAX Functionality

```jsp
<!-- 1. Create JSP with jQuery -->
<!-- File: src/main/webapp/product-ajax.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management (AJAX)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.min.js"></script>
    <script>
    $(document).ready(function() {
        // Load products on page load
        loadProducts();

        // Save product via AJAX
        $('#saveProductBtn').click(function() {
            $.ajax({
                url: '${pageContext.request.contextPath}/product/save.do',
                type: 'POST',
                data: {
                    name: $('#productName').val(),
                    description: $('#productDesc').val(),
                    price: $('#productPrice').val()
                },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert('Product saved successfully!');
                        $('#productForm')[0].reset();
                        loadProducts();
                    } else {
                        alert('Error: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert('AJAX error: ' + error);
                }
            });
        });

        // Delete product via AJAX
        $(document).on('click', '.delete-btn', function() {
            var productId = $(this).data('id');
            if (confirm('Are you sure?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/product/delete.do',
                    type: 'POST',
                    data: { id: productId },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            loadProducts();
                        } else {
                            alert('Error: ' + response.message);
                        }
                    }
                });
            }
        });
    });

    function loadProducts() {
        $.ajax({
            url: '${pageContext.request.contextPath}/product/listJson.do',
            type: 'GET',
            dataType: 'json',
            success: function(products) {
                var html = '';
                $.each(products, function(i, product) {
                    html += '<tr>';
                    html += '<td>' + product.id + '</td>';
                    html += '<td>' + product.name + '</td>';
                    html += '<td>' + product.price + '</td>';
                    html += '<td><button class="delete-btn" data-id="' + product.id + '">Delete</button></td>';
                    html += '</tr>';
                });
                $('#productTable tbody').html(html);
            }
        });
    }
    </script>
</head>
<body>
    <h1>Product Management (AJAX)</h1>

    <form id="productForm">
        <input type="text" id="productName" placeholder="Name" required>
        <input type="text" id="productDesc" placeholder="Description">
        <input type="number" id="productPrice" placeholder="Price" step="0.01" required>
        <button type="button" id="saveProductBtn">Save</button>
    </form>

    <table id="productTable" border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Populated via AJAX -->
        </tbody>
    </table>
</body>
</html>
```

```java
// 2. Add JSON response methods to Action
// File: src/main/java/com/example/action/ProductAction.java

import java.io.PrintWriter;
import org.json.JSONArray;
import org.json.JSONObject;

public ActionForward listJson(ActionMapping mapping,
                              ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response) throws Exception {

    ProductDAO productDAO = new ProductDAOImpl();
    List<Product> products = productDAO.findAll();

    // Build JSON array
    JSONArray jsonArray = new JSONArray();
    for (Product product : products) {
        JSONObject json = new JSONObject();
        json.put("id", product.getId());
        json.put("name", product.getName());
        json.put("price", product.getPrice());
        jsonArray.put(json);
    }

    // Send JSON response
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();
    out.print(jsonArray.toString());
    out.flush();

    return null; // No forward for AJAX
}
```

### 4.3 Ant Build Tasks

#### Available Build Targets

```bash
# View all available targets
ant -projecthelp
```

| Target | Description | Usage |
|--------|-------------|-------|
| `clean` | Delete build and dist directories | `ant clean` |
| `init` | Create build directories | `ant init` |
| `compile` | Compile Java source files | `ant compile` |
| `war` | Create WAR file | `ant war` |
| `javadoc` | Generate API documentation | `ant javadoc` |
| `test` | Run unit tests | `ant test` |
| `deploy` | Deploy to Tomcat | `ant deploy` |
| `all` | Clean, compile, and create WAR | `ant all` |

#### Common Build Commands

```bash
# Full clean build
ant clean compile

# Create deployable WAR
ant clean war

# Quick compile (no clean)
ant compile

# Compile and deploy
ant compile deploy

# Generate documentation
ant javadoc

# Run all tests
ant test

# Complete rebuild with docs
ant clean compile javadoc war
```

#### Build Properties

```properties
# build.properties (optional - create if needed)
app.name=legacy-app
app.version=1.0.0
tomcat.home=/usr/local/tomcat
deploy.path=${tomcat.home}/webapps
java.source=1.5
java.target=1.5
```

### 4.4 Hot Deployment Workflow

#### Option 1: Exploded WAR Deployment

```bash
# 1. Build to exploded directory
ant compile

# 2. Tomcat picks up changes automatically (if configured)
# Changes appear in: build/war/

# 3. For immediate reload, touch web.xml
touch build/war/WEB-INF/web.xml
```

#### Option 2: WAR File Deployment

```bash
# 1. Build WAR file
ant war

# 2. WAR is copied to dist/ (auto-deployed via volume mount)
# Tomcat detects new WAR and redeploys automatically

# 3. Check deployment
curl http://localhost:8080/legacy-app/
```

#### Option 3: Manual Deployment

```bash
# 1. Build WAR
ant war

# 2. Copy to Tomcat webapps
cp dist/legacy-app.war /path/to/tomcat/webapps/

# 3. Wait for auto-deployment or restart Tomcat
```

### 4.5 Testing Workflow

#### Database Testing

```bash
# 1. Test database connection
# Open: http://localhost:8080/legacy-app/test-db.jsp

# 2. Or use MySQL client
mysql -h localhost -P 3306 -u legacy_user -p
# Password: legacy_pass

# 3. Verify tables
USE legacy_db;
SHOW TABLES;
DESCRIBE users;
SELECT * FROM users;
```

#### Application Testing

```bash
# 1. Access application homepage
http://localhost:8080/legacy-app/

# 2. Test specific features
http://localhost:8080/legacy-app/user/list.do
http://localhost:8080/legacy-app/sample.do

# 3. Check logs
# View in terminal or:
docker logs tomcat6
```

#### jQuery/AJAX Testing

```javascript
// Browser console testing
// Open Developer Tools (F12)

// Test AJAX endpoint
$.ajax({
    url: '/legacy-app/user/list.do',
    success: function(data) { console.log(data); }
});

// Check jQuery version
console.log($().jquery);  // Should show 1.12.4
```

### 4.6 Debugging Workflow

#### Enable Debug Logging

```xml
<!-- Add to src/main/resources/log4j.properties -->
log4j.rootLogger=DEBUG, stdout

log4j.logger.org.hibernate=DEBUG
log4j.logger.org.hibernate.SQL=DEBUG
log4j.logger.org.hibernate.type=TRACE

log4j.logger.com.example=DEBUG

log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n
```

#### View Tomcat Logs

```bash
# Real-time log viewing
docker logs -f tomcat6

# Or access log files directly
docker exec -it tomcat6 tail -f /usr/local/tomcat/logs/catalina.out
```

#### VS Code Debugging

```json
// .vscode/launch.json (create if needed)
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "java",
            "name": "Debug Tomcat",
            "request": "attach",
            "hostName": "localhost",
            "port": 9000
        }
    ]
}
```

```bash
# Start Tomcat with debug enabled
# In docker-compose.services.yaml, add:
# CATALINA_OPTS: "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=9000"
```

### 4.7 Version Control Workflow

#### Git Best Practices

```bash
# 1. Create feature branch
git checkout -b feature/product-management

# 2. Make changes and commit frequently
git add src/main/java/com/example/action/ProductAction.java
git commit -m "Add ProductAction for product management"

# 3. Add related files
git add src/main/webapp/WEB-INF/struts-config.xml
git commit -m "Configure ProductAction in struts-config"

# 4. Push to remote
git push origin feature/product-management

# 5. Create pull request (via GitHub)

# 6. Merge to main after review
git checkout main
git merge feature/product-management
git push origin main
```

#### Commit Message Conventions

```
feat: Add product listing page
fix: Correct SQL query in UserDAO
docs: Update README with setup instructions
style: Format ProductAction code
refactor: Extract common DAO methods to BaseDAO
test: Add unit tests for ProductDAO
chore: Update Ant build script
```

### 4.8 Code Review Checklist

#### Before Committing

- [ ] Code compiles without errors: `ant clean compile`
- [ ] Application deploys successfully: `ant war`
- [ ] No console errors in browser
- [ ] Hibernate mappings are correct
- [ ] Struts configuration is valid
- [ ] jQuery scripts have no syntax errors
- [ ] CSS is properly formatted
- [ ] No hardcoded values (use properties/constants)
- [ ] Proper exception handling
- [ ] Logging statements added where needed
- [ ] Code follows naming conventions
- [ ] No commented-out code (unless temporarily needed)
- [ ] Database schema updated if needed
- [ ] Documentation updated

#### Code Quality Standards

```java
// ✅ GOOD: Proper error handling
try {
    userDAO.save(user);
    session.getTransaction().commit();
} catch (Exception e) {
    session.getTransaction().rollback();
    log.error("Failed to save user", e);
    throw new DAOException("Failed to save user", e);
}

// ❌ BAD: Swallowing exceptions
try {
    userDAO.save(user);
} catch (Exception e) {
    // Do nothing
}

// ✅ GOOD: Resource cleanup
Session session = null;
try {
    session = HibernateUtil.getSessionFactory().openSession();
    // Use session
} finally {
    if (session != null) {
        session.close();
    }
}

// ❌ BAD: Resource leak
Session session = HibernateUtil.getSessionFactory().openSession();
// Use session without closing
```

---

## 5. Database Development with MySQL and Hibernate

### 5.1 MySQL Configuration

#### Database Setup

```bash
# 1. Connect to MySQL container
docker exec -it mysql bash

# 2. Login to MySQL
mysql -u root -p
# Password: rootpass (or as configured)
```

```sql
-- 3. Create database
CREATE DATABASE IF NOT EXISTS legacy_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- 4. Create user
CREATE USER IF NOT EXISTS 'legacy_user'@'%' IDENTIFIED BY 'legacy_pass';

-- 5. Grant privileges
GRANT ALL PRIVILEGES ON legacy_db.* TO 'legacy_user'@'%';
FLUSH PRIVILEGES;

-- 6. Verify
USE legacy_db;
SHOW TABLES;
```

#### Connection Configuration

```xml
<!-- File: src/main/resources/hibernate.cfg.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-configuration PUBLIC
    "-//Hibernate/Hibernate Configuration DTD 3.0//EN"
    "http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">

<hibernate-configuration>
    <session-factory>
        <!-- Database Connection Settings -->
        <property name="connection.driver_class">com.mysql.jdbc.Driver</property>
        <property name="connection.url">jdbc:mysql://mysql:3306/legacy_db?useUnicode=true&amp;characterEncoding=UTF-8</property>
        <property name="connection.username">legacy_user</property>
        <property name="connection.password">legacy_pass</property>

        <!-- Connection Pool Settings (C3P0) -->
        <property name="hibernate.c3p0.min_size">5</property>
        <property name="hibernate.c3p0.max_size">20</property>
        <property name="hibernate.c3p0.timeout">300</property>
        <property name="hibernate.c3p0.max_statements">50</property>
        <property name="hibernate.c3p0.idle_test_period">3000</property>

        <!-- SQL Dialect -->
        <property name="dialect">org.hibernate.dialect.MySQL5InnoDBDialect</property>

        <!-- Echo SQL to console -->
        <property name="show_sql">true</property>
        <property name="format_sql">true</property>
        <property name="use_sql_comments">true</property>

        <!-- Session Context -->
        <property name="current_session_context_class">thread</property>

        <!-- Schema Auto-update -->
        <property name="hbm2ddl.auto">update</property>

        <!-- Disable second-level cache -->
        <property name="cache.provider_class">org.hibernate.cache.NoCacheProvider</property>

        <!-- Entity Mappings -->
        <mapping resource="com/example/model/User.hbm.xml"/>
        <!-- Add more mappings here -->
    </session-factory>
</hibernate-configuration>
```

#### Environment-Specific Configuration

```properties
# File: config/development.properties
db.host=mysql
db.port=3306
db.name=legacy_db
db.username=legacy_user
db.password=legacy_pass
db.pool.min=5
db.pool.max=20

# File: config/production.properties
db.host=production-mysql-server
db.port=3306
db.name=legacy_db_prod
db.username=app_user
db.password=secure_prod_password
db.pool.min=10
db.pool.max=50
```

### 5.2 Hibernate Entity Mapping

#### Basic Entity Mapping

```java
// File: src/main/java/com/example/model/User.java
package com.example.model;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String username;
    private String password;
    private String email;
    private String firstName;
    private String lastName;
    private Boolean active;
    private Date createdDate;
    private Date lastModifiedDate;

    // Default constructor (required by Hibernate)
    public User() {}

    // Constructor with essential fields
    public User(String username, String email) {
        this.username = username;
        this.email = email;
        this.active = true;
        this.createdDate = new Date();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public Boolean getActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public Date getLastModifiedDate() { return lastModifiedDate; }
    public void setLastModifiedDate(Date lastModifiedDate) { this.lastModifiedDate = lastModifiedDate; }

    // Helper methods
    public String getFullName() {
        return (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "");
    }

    @Override
    public String toString() {
        return "User{id=" + id + ", username='" + username + "', email='" + email + "'}";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id != null && id.equals(user.id);
    }

    @Override
    public int hashCode() {
        return 31;
    }
}
```

```xml
<!-- File: src/main/resources/com/example/model/User.hbm.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC
    "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
    "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">

<hibernate-mapping package="com.example.model">
    <class name="User" table="users">

        <!-- Primary Key -->
        <id name="id" column="id" type="long">
            <generator class="native"/>
        </id>

        <!-- Basic Properties -->
        <property name="username" column="username" type="string"
                  length="50" not-null="true" unique="true"/>

        <property name="password" column="password" type="string"
                  length="255" not-null="true"/>

        <property name="email" column="email" type="string"
                  length="100" not-null="true" unique="true"/>

        <property name="firstName" column="first_name" type="string"
                  length="50"/>

        <property name="lastName" column="last_name" type="string"
                  length="50"/>

        <property name="active" column="active" type="boolean"
                  not-null="true"/>

        <!-- Timestamp Properties -->
        <property name="createdDate" column="created_date" type="timestamp"
                  not-null="true" update="false"/>

        <property name="lastModifiedDate" column="last_modified_date" type="timestamp"/>
    </class>
</hibernate-mapping>
```

#### Corresponding SQL Schema

```sql
-- Generated table structure
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_modified_date TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_active (active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 5.3 Advanced Hibernate Mappings

#### One-to-Many Relationship

```java
// File: src/main/java/com/example/model/Department.java
package com.example.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class Department implements Serializable {

    private Long id;
    private String name;
    private String description;
    private Set<Employee> employees = new HashSet<Employee>();

    public Department() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Set<Employee> getEmployees() { return employees; }
    public void setEmployees(Set<Employee> employees) { this.employees = employees; }

    // Helper methods
    public void addEmployee(Employee employee) {
        employees.add(employee);
        employee.setDepartment(this);
    }

    public void removeEmployee(Employee employee) {
        employees.remove(employee);
        employee.setDepartment(null);
    }
}
```

```java
// File: src/main/java/com/example/model/Employee.java
package com.example.model;

import java.io.Serializable;

public class Employee implements Serializable {

    private Long id;
    private String name;
    private String email;
    private Department department;

    public Employee() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }
}
```

```xml
<!-- File: src/main/resources/com/example/model/Department.hbm.xml -->
<hibernate-mapping package="com.example.model">
    <class name="Department" table="departments">
        <id name="id" column="id">
            <generator class="native"/>
        </id>

        <property name="name" column="name" type="string" length="100" not-null="true"/>
        <property name="description" column="description" type="text"/>

        <!-- One-to-Many: Department has many Employees -->
        <set name="employees" inverse="true" cascade="all" lazy="true">
            <key column="department_id"/>
            <one-to-many class="Employee"/>
        </set>
    </class>
</hibernate-mapping>
```

```xml
<!-- File: src/main/resources/com/example/model/Employee.hbm.xml -->
<hibernate-mapping package="com.example.model">
    <class name="Employee" table="employees">
        <id name="id" column="id">
            <generator class="native"/>
        </id>

        <property name="name" column="name" type="string" length="100" not-null="true"/>
        <property name="email" column="email" type="string" length="100"/>

        <!-- Many-to-One: Many Employees belong to one Department -->
        <many-to-one name="department" column="department_id" class="Department"
                     not-null="false" lazy="proxy"/>
    </class>
</hibernate-mapping>
```

#### Many-to-Many Relationship

```java
// File: src/main/java/com/example/model/Student.java
package com.example.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class Student implements Serializable {

    private Long id;
    private String name;
    private String studentNumber;
    private Set<Course> courses = new HashSet<Course>();

    public Student() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getStudentNumber() { return studentNumber; }
    public void setStudentNumber(String studentNumber) { this.studentNumber = studentNumber; }

    public Set<Course> getCourses() { return courses; }
    public void setCourses(Set<Course> courses) { this.courses = courses; }
}
```

```java
// File: src/main/java/com/example/model/Course.java
package com.example.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class Course implements Serializable {

    private Long id;
    private String name;
    private String code;
    private Set<Student> students = new HashSet<Student>();

    public Course() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public Set<Student> getStudents() { return students; }
    public void setStudents(Set<Student> students) { this.students = students; }
}
```

```xml
<!-- File: src/main/resources/com/example/model/Student.hbm.xml -->
<hibernate-mapping package="com.example.model">
    <class name="Student" table="students">
        <id name="id" column="id">
            <generator class="native"/>
        </id>

        <property name="name" column="name" type="string" length="100" not-null="true"/>
        <property name="studentNumber" column="student_number" type="string"
                  length="20" not-null="true" unique="true"/>

        <!-- Many-to-Many: Students enrolled in Courses -->
        <set name="courses" table="student_courses" cascade="save-update" lazy="true">
            <key column="student_id"/>
            <many-to-many column="course_id" class="Course"/>
        </set>
    </class>
</hibernate-mapping>
```

```xml
<!-- File: src/main/resources/com/example/model/Course.hbm.xml -->
<hibernate-mapping package="com.example.model">
    <class name="Course" table="courses">
        <id name="id" column="id">
            <generator class="native"/>
        </id>

        <property name="name" column="name" type="string" length="100" not-null="true"/>
        <property name="code" column="code" type="string" length="20"
                  not-null="true" unique="true"/>

        <!-- Many-to-Many: Courses have many Students -->
        <set name="students" table="student_courses" inverse="true"
             cascade="save-update" lazy="true">
            <key column="course_id"/>
            <many-to-many column="student_id" class="Student"/>
        </set>
    </class>
</hibernate-mapping>
```

```sql
-- Join table for many-to-many relationship
CREATE TABLE student_courses (
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
) ENGINE=InnoDB;
```

### 5.4 Hibernate Query Language (HQL)

#### Basic HQL Queries

```java
// File: src/main/java/com/example/dao/impl/UserDAOImpl.java

// 1. Select all users
public List<User> findAll() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery("from User order by username");
    return query.list();
}

// 2. Find by ID
public User findById(Long id) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    return (User) session.get(User.class, id);
}

// 3. Find by username (exact match)
public User findByUsername(String username) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery("from User where username = :username");
    query.setParameter("username", username);
    return (User) query.uniqueResult();
}

// 4. Find by email pattern (like search)
public List<User> findByEmailPattern(String pattern) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery("from User where email like :pattern");
    query.setParameter("pattern", "%" + pattern + "%");
    return query.list();
}

// 5. Find active users
public List<User> findActiveUsers() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery("from User where active = true order by username");
    return query.list();
}

// 6. Count users
public long countUsers() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery("select count(*) from User");
    return ((Long) query.uniqueResult()).longValue();
}

// 7. Pagination
public List<User> findUsers(int page, int pageSize) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery("from User order by id");
    query.setFirstResult((page - 1) * pageSize);
    query.setMaxResults(pageSize);
    return query.list();
}

// 8. Find users created after date
public List<User> findUsersCreatedAfter(Date date) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery("from User where createdDate > :date");
    query.setParameter("date", date);
    return query.list();
}
```

#### Advanced HQL Queries

```java
// 9. Join queries
public List<Employee> findEmployeesWithDepartment() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery(
        "select e from Employee e join fetch e.department d order by e.name"
    );
    return query.list();
}

// 10. Left join
public List<Employee> findAllEmployeesWithOptionalDepartment() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery(
        "select e from Employee e left join fetch e.department order by e.name"
    );
    return query.list();
}

// 11. Aggregate functions
public Map<String, Object> getUserStatistics() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery(
        "select count(*), min(createdDate), max(createdDate) from User"
    );
    Object[] result = (Object[]) query.uniqueResult();

    Map<String, Object> stats = new HashMap<String, Object>();
    stats.put("totalUsers", result[0]);
    stats.put("firstUserDate", result[1]);
    stats.put("lastUserDate", result[2]);
    return stats;
}

// 12. Group by
public List<Object[]> getUserCountByDomain() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery(
        "select substring(email, locate('@', email) + 1), count(*) " +
        "from User group by substring(email, locate('@', email) + 1)"
    );
    return query.list();
}

// 13. Subquery
public List<User> findUsersWithNoOrders() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery(
        "from User u where u.id not in " +
        "(select distinct o.user.id from Order o)"
    );
    return query.list();
}
```

#### Named Queries

```xml
<!-- Add to User.hbm.xml -->
<hibernate-mapping package="com.example.model">
    <class name="User" table="users">
        <!-- ... properties ... -->

        <!-- Named Queries -->
        <query name="User.findAll">
            <![CDATA[from User order by username]]>
        </query>

        <query name="User.findByUsername">
            <![CDATA[from User where username = :username]]>
        </query>

        <query name="User.findActiveUsers">
            <![CDATA[from User where active = true order by username]]>
        </query>

        <query name="User.countByDomain">
            <![CDATA[
                select substring(email, locate('@', email) + 1) as domain, count(*) as total
                from User
                group by substring(email, locate('@', email) + 1)
                order by total desc
            ]]>
        </query>
    </class>
</hibernate-mapping>
```

```java
// Using named queries
public List<User> findAll() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.getNamedQuery("User.findAll");
    return query.list();
}

public User findByUsername(String username) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.getNamedQuery("User.findByUsername");
    query.setParameter("username", username);
    return (User) query.uniqueResult();
}
```

### 5.5 Criteria API

```java
// File: src/main/java/com/example/dao/impl/UserDAOImpl.java

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;

// 1. Basic criteria query
public List<User> findAllCriteria() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Criteria criteria = session.createCriteria(User.class);
    criteria.addOrder(Order.asc("username"));
    return criteria.list();
}

// 2. Criteria with restrictions
public List<User> findActiveUsersCriteria() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Criteria criteria = session.createCriteria(User.class);
    criteria.add(Restrictions.eq("active", true));
    criteria.addOrder(Order.asc("username"));
    return criteria.list();
}

// 3. Multiple restrictions (AND)
public List<User> findUsersByEmailAndActive(String emailPattern, boolean active) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Criteria criteria = session.createCriteria(User.class);
    criteria.add(Restrictions.like("email", "%" + emailPattern + "%"));
    criteria.add(Restrictions.eq("active", active));
    return criteria.list();
}

// 4. OR restrictions
public List<User> findUsersByUsernameOrEmail(String searchTerm) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Criteria criteria = session.createCriteria(User.class);
    criteria.add(Restrictions.or(
        Restrictions.like("username", "%" + searchTerm + "%"),
        Restrictions.like("email", "%" + searchTerm + "%")
    ));
    return criteria.list();
}

// 5. Between dates
public List<User> findUsersCreatedBetween(Date startDate, Date endDate) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Criteria criteria = session.createCriteria(User.class);
    criteria.add(Restrictions.between("createdDate", startDate, endDate));
    return criteria.list();
}

// 6. Pagination with Criteria
public List<User> findUsersPaginated(int page, int pageSize) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Criteria criteria = session.createCriteria(User.class);
    criteria.setFirstResult((page - 1) * pageSize);
    criteria.setMaxResults(pageSize);
    criteria.addOrder(Order.asc("id"));
    return criteria.list();
}

// 7. Count with Criteria
public long countUsersCriteria() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Criteria criteria = session.createCriteria(User.class);
    criteria.setProjection(Projections.rowCount());
    return ((Long) criteria.uniqueResult()).longValue();
}

// 8. Dynamic search criteria
public List<User> searchUsers(String username, String email, Boolean active) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Criteria criteria = session.createCriteria(User.class);

    if (username != null && !username.isEmpty()) {
        criteria.add(Restrictions.like("username", "%" + username + "%"));
    }

    if (email != null && !email.isEmpty()) {
        criteria.add(Restrictions.like("email", "%" + email + "%"));
    }

    if (active != null) {
        criteria.add(Restrictions.eq("active", active));
    }

    criteria.addOrder(Order.asc("username"));
    return criteria.list();
}
```

### 5.6 Transaction Management

#### Programmatic Transactions

```java
// File: src/main/java/com/example/dao/impl/UserDAOImpl.java

// Method 1: Manual transaction management
public void saveUser(User user) {
    Session session = null;
    Transaction tx = null;

    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();

        session.save(user);

        tx.commit();

    } catch (Exception e) {
        if (tx != null) {
            tx.rollback();
        }
        throw new DAOException("Failed to save user", e);

    } finally {
        if (session != null) {
            session.close();
        }
    }
}

// Method 2: Using getCurrentSession (managed by filter)
public void saveUserWithFilter(User user) {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    // Transaction is managed by HibernateSessionFilter
    session.save(user);
}

// Method 3: Batch operations
public void saveUsers(List<User> users) {
    Session session = null;
    Transaction tx = null;

    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();

        int batchSize = 20;
        for (int i = 0; i < users.size(); i++) {
            session.save(users.get(i));

            if (i % batchSize == 0) {
                // Flush and clear session every 20 records
                session.flush();
                session.clear();
            }
        }

        tx.commit();

    } catch (Exception e) {
        if (tx != null) {
            tx.rollback();
        }
        throw new DAOException("Failed to save users", e);

    } finally {
        if (session != null) {
            session.close();
        }
    }
}
```

#### Filter-based Transaction Management

```java
// File: src/main/java/com/example/filter/HibernateSessionFilter.java
package com.example.filter;

import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import javax.servlet.*;
import java.io.IOException;

public class HibernateSessionFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialize if needed
    }

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();

            // Store session in thread-local for getCurrentSession()
            // (if using thread-based session context)

            chain.doFilter(request, response);

            if (tx != null && tx.isActive()) {
                tx.commit();
            }

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new ServletException("Transaction failed", e);

        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }

    public void destroy() {
        HibernateUtil.shutdown();
    }
}
```

```xml
<!-- Configure in web.xml -->
<filter>
    <filter-name>hibernateFilter</filter-name>
    <filter-class>com.example.filter.HibernateSessionFilter</filter-class>
</filter>

<filter-mapping>
    <filter-name>hibernateFilter</filter-name>
    <url-pattern>*.do</url-pattern>
</filter-mapping>
```

### 5.7 Database Schema Management

#### Schema Generation

```xml
<!-- Configure in hibernate.cfg.xml -->

<!-- Option 1: Validate existing schema -->
<property name="hbm2ddl.auto">validate</property>

<!-- Option 2: Update schema (add new tables/columns) -->
<property name="hbm2ddl.auto">update</property>

<!-- Option 3: Drop and recreate (DANGEROUS - data loss!) -->
<property name="hbm2ddl.auto">create-drop</property>

<!-- Option 4: Create schema on startup -->
<property name="hbm2ddl.auto">create</property>

<!-- Option 5: No automatic schema management (RECOMMENDED for production) -->
<!-- Remove or comment out hbm2ddl.auto property -->
```

#### Manual Schema Creation

```sql
-- File: config/mysql/schema.sql

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_modified_date TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_active (active),
    INDEX idx_created_date (created_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Departments table
CREATE TABLE IF NOT EXISTS departments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Employees table
CREATE TABLE IF NOT EXISTS employees (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    department_id BIGINT,
    INDEX idx_name (name),
    INDEX idx_department (department_id),
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

```bash
# Execute schema
mysql -h localhost -P 3306 -u legacy_user -p legacy_db < config/mysql/schema.sql
```

#### Database Migration Strategy

```sql
-- File: config/mysql/migrations/001_initial_schema.sql
-- Create initial tables

-- File: config/mysql/migrations/002_add_user_status.sql
ALTER TABLE users ADD COLUMN status VARCHAR(20) DEFAULT 'ACTIVE';

-- File: config/mysql/migrations/003_add_indexes.sql
CREATE INDEX idx_user_status ON users(status);
CREATE INDEX idx_employee_email ON employees(email);
```

```bash
# Apply migrations in order
for file in config/mysql/migrations/*.sql; do
    echo "Applying $file"
    mysql -h localhost -P 3306 -u legacy_user -p legacy_db < "$file"
done
```

### 5.8 Performance Optimization

#### Connection Pooling (C3P0)

```xml
<!-- Add to hibernate.cfg.xml -->
<property name="hibernate.connection.provider_class">
    org.hibernate.connection.C3P0ConnectionProvider
</property>

<!-- C3P0 Configuration -->
<property name="hibernate.c3p0.min_size">5</property>
<property name="hibernate.c3p0.max_size">20</property>
<property name="hibernate.c3p0.timeout">1800</property>
<property name="hibernate.c3p0.max_statements">50</property>
<property name="hibernate.c3p0.idle_test_period">3000</property>
<property name="hibernate.c3p0.acquire_increment">1</property>
<property name="hibernate.c3p0.validate">true</property>
```

#### Lazy Loading

```xml
<!-- Enable lazy loading (default) -->
<set name="employees" inverse="true" cascade="all" lazy="true">
    <key column="department_id"/>
    <one-to-many class="Employee"/>
</set>

<!-- Eager loading (loads immediately) -->
<set name="employees" inverse="true" cascade="all" lazy="false">
    <key column="department_id"/>
    <one-to-many class="Employee"/>
</set>

<!-- Extra lazy (only loads when accessed) -->
<set name="employees" inverse="true" cascade="all" lazy="extra">
    <key column="department_id"/>
    <one-to-many class="Employee"/>
</set>
```

#### Batch Fetching

```xml
<!-- Configure in hibernate.cfg.xml -->
<property name="hibernate.default_batch_fetch_size">16</property>

<!-- Or in mapping file -->
<class name="User" table="users" batch-size="10">
    <!-- ... -->
</class>
```

#### Query Optimization

```java
// Use fetch join to avoid N+1 problem
public List<Employee> findEmployeesWithDepartments() {
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
    Query query = session.createQuery(
        "select distinct e from Employee e " +
        "left join fetch e.department " +
        "order by e.name"
    );
    return query.list();
}

// Set query hints
query.setFetchSize(50);
query.setTimeout(30);
query.setCacheable(true);
query.setCacheRegion("employee-query-cache");
```

---

## 6. Frontend Development with jQuery

### 6.1 jQuery Setup and Integration

#### Including jQuery in Your Application

```jsp
<!-- Method 1: Local jQuery (Recommended for legacy apps) -->
<!-- File: src/main/webapp/includes/header.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <!-- Local jQuery 1.12.4 (last version supporting IE 6-8) -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.min.js"></script>

    <!-- Application CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div id="wrapper">
        <header>
            <h1>Legacy Application</h1>
            <nav>
                <!-- Navigation menu -->
            </nav>
        </header>
        <main>
```

```jsp
<!-- Method 2: CDN (requires internet connection) -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
        integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
        crossorigin="anonymous"></script>

<!-- Fallback to local if CDN fails -->
<script>
    if (typeof jQuery == 'undefined') {
        document.write('<script src="${pageContext.request.contextPath}/js/jquery-1.12.4.min.js"><\/script>');
    }
</script>
```

#### Verify jQuery Installation

```jsp
<!-- Test page: src/main/webapp/test-jquery.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>jQuery Test</title>
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.min.js"></script>
</head>
<body>
    <h1>jQuery Test Page</h1>
    <p id="test">Click the button to test jQuery</p>
    <button id="testBtn">Test jQuery</button>

    <script>
        // Check jQuery version
        console.log('jQuery version: ' + $.fn.jquery);

        // Test jQuery functionality
        $(document).ready(function() {
            $('#testBtn').click(function() {
                $('#test').html('jQuery is working! Version: ' + $.fn.jquery);
                $('#test').css('color', 'green');
            });
        });
    </script>
</body>
</html>
```

### 6.2 jQuery Basics for Legacy Applications

#### Document Ready Pattern

```javascript
// File: src/main/webapp/js/app.js

// Method 1: Standard document ready
$(document).ready(function() {
    console.log('DOM is ready');
    initializeApp();
});

// Method 2: Shorthand
$(function() {
    console.log('DOM is ready (shorthand)');
    initializeApp();
});

// Method 3: jQuery 3.0+ syntax (not available in 1.12.4)
// jQuery(function($) { ... });

function initializeApp() {
    // Initialize form validation
    setupFormValidation();

    // Initialize event handlers
    setupEventHandlers();

    // Load initial data
    loadInitialData();
}
```

#### Selectors

```javascript
// ID selector
var username = $('#username').val();

// Class selector
$('.error-message').hide();

// Element selector
$('input[type="text"]').css('border', '1px solid #ccc');

// Attribute selector
$('input[name="email"]').focus();

// Multiple selectors
$('input, select, textarea').addClass('form-control');

// Descendant selector
$('#userForm input').each(function() {
    console.log($(this).val());
});

// Child selector
$('#menu > li').addClass('menu-item');

// Filter selectors
$('tr:even').css('background-color', '#f5f5f5');
$('tr:odd').css('background-color', '#ffffff');
$('input:checked').val();
$('option:selected').text();

// Custom filters
$('div:hidden').show();
$('div:visible').hide();
$('input:disabled').prop('disabled', false);
```

#### DOM Manipulation

```javascript
// Get/Set content
var text = $('#message').text();
$('#message').text('New message');

var html = $('#content').html();
$('#content').html('<p>New content</p>');

var value = $('#username').val();
$('#username').val('admin');

// Get/Set attributes
var src = $('#image').attr('src');
$('#image').attr('src', 'new-image.png');
$('#link').attr({
    'href': 'http://example.com',
    'target': '_blank'
});

// Add/Remove/Toggle classes
$('#element').addClass('active');
$('#element').removeClass('disabled');
$('#element').toggleClass('selected');
$('#element').hasClass('active'); // returns boolean

// CSS manipulation
$('#element').css('color', 'red');
$('#element').css({
    'color': 'blue',
    'font-size': '16px',
    'font-weight': 'bold'
});

// Show/Hide elements
$('#message').show();
$('#message').hide();
$('#message').toggle();
$('#message').fadeIn();
$('#message').fadeOut();
$('#message').slideDown();
$('#message').slideUp();

// Create elements
var newDiv = $('<div>').addClass('container').text('Hello');
$('#container').append(newDiv);

// Insert elements
$('#list').append('<li>Last item</li>');
$('#list').prepend('<li>First item</li>');
$('<li>After item</li>').insertAfter('#item2');
$('<li>Before item</li>').insertBefore('#item1');

// Remove elements
$('#element').remove();
$('#element').empty(); // Remove children only
```

#### Event Handling

```javascript
// Click event
$('#saveBtn').click(function() {
    console.log('Button clicked');
    saveData();
});

// Submit event
$('#userForm').submit(function(e) {
    e.preventDefault(); // Prevent default form submission

    if (validateForm()) {
        submitFormAjax();
    }

    return false;
});

// Change event
$('#category').change(function() {
    var selectedValue = $(this).val();
    loadSubcategories(selectedValue);
});

// Keyup event (for search-as-you-type)
$('#searchInput').keyup(function() {
    var searchTerm = $(this).val();
    if (searchTerm.length >= 3) {
        performSearch(searchTerm);
    }
});

// Multiple events
$('#element').on('click mouseover', function() {
    console.log('Event triggered');
});

// Event delegation (for dynamic elements)
$(document).on('click', '.delete-btn', function() {
    var id = $(this).data('id');
    deleteItem(id);
});

// Custom events
$('#element').on('customEvent', function(e, data) {
    console.log('Custom event:', data);
});
$('#element').trigger('customEvent', {message: 'Hello'});

// One-time event
$('#element').one('click', function() {
    console.log('This will only fire once');
});

// Unbind events
$('#element').off('click');
```

### 6.3 AJAX with jQuery and Struts

#### Basic AJAX Patterns

```javascript
// File: src/main/webapp/js/ajax-utils.js

// Pattern 1: GET request
function loadUserList() {
    $.ajax({
        url: '${pageContext.request.contextPath}/user/listJson.do',
        type: 'GET',
        dataType: 'json',
        success: function(users) {
            displayUsers(users);
        },
        error: function(xhr, status, error) {
            console.error('Error loading users:', error);
            showErrorMessage('Failed to load users');
        }
    });
}

// Pattern 2: POST request
function saveUser(userData) {
    $.ajax({
        url: '${pageContext.request.contextPath}/user/save.do',
        type: 'POST',
        data: userData,
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                showSuccessMessage('User saved successfully');
                loadUserList();
            } else {
                showErrorMessage(response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('Save error:', error);
            showErrorMessage('Failed to save user');
        }
    });
}

// Pattern 3: DELETE request
function deleteUser(userId) {
    if (!confirm('Are you sure you want to delete this user?')) {
        return;
    }

    $.ajax({
        url: '${pageContext.request.contextPath}/user/delete.do',
        type: 'POST',
        data: { id: userId },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                showSuccessMessage('User deleted');
                loadUserList();
            } else {
                showErrorMessage(response.message);
            }
        },
        error: function(xhr, status, error) {
            showErrorMessage('Failed to delete user');
        }
    });
}

// Pattern 4: $.get() shorthand
function getUserById(userId) {
    $.get('${pageContext.request.contextPath}/user/view.do',
          { id: userId },
          function(data) {
              displayUserDetails(data);
          },
          'json');
}

// Pattern 5: $.post() shorthand
function quickSave(formData) {
    $.post('${pageContext.request.contextPath}/user/save.do',
           formData,
           function(response) {
               if (response.success) {
                   alert('Saved!');
               }
           },
           'json');
}

// Pattern 6: $.getJSON() shorthand
function loadJSON() {
    $.getJSON('${pageContext.request.contextPath}/data/users.json', function(data) {
        console.log('Loaded:', data);
    });
}
```

#### Struts Action for AJAX

```java
// File: src/main/java/com/example/action/UserAction.java
package com.example.action;

import com.example.dao.UserDAO;
import com.example.dao.impl.UserDAOImpl;
import com.example.model.User;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

public class UserAction extends Action {

    // Return JSON array
    public ActionForward listJson(ActionMapping mapping,
                                  ActionForm form,
                                  HttpServletRequest request,
                                  HttpServletResponse response) throws Exception {

        UserDAO userDAO = new UserDAOImpl();
        List<User> users = userDAO.findAll();

        // Build JSON manually (simple approach for Java 1.5)
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < users.size(); i++) {
            User user = users.get(i);
            if (i > 0) json.append(",");
            json.append("{");
            json.append("\"id\":").append(user.getId()).append(",");
            json.append("\"username\":\"").append(escapeJson(user.getUsername())).append("\",");
            json.append("\"email\":\"").append(escapeJson(user.getEmail())).append("\",");
            json.append("\"active\":").append(user.getActive());
            json.append("}");
        }
        json.append("]");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();

        return null; // No forward for AJAX
    }

    // Return JSON object
    public ActionForward saveJson(ActionMapping mapping,
                                  ActionForm form,
                                  HttpServletRequest request,
                                  HttpServletResponse response) throws Exception {

        UserDAO userDAO = new UserDAOImpl();
        StringBuilder json = new StringBuilder();

        try {
            // Get parameters
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Create user
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setActive(true);

            // Save
            userDAO.save(user);

            // Success response
            json.append("{");
            json.append("\"success\":true,");
            json.append("\"message\":\"User saved successfully\",");
            json.append("\"userId\":").append(user.getId());
            json.append("}");

        } catch (Exception e) {
            // Error response
            json.append("{");
            json.append("\"success\":false,");
            json.append("\"message\":\"").append(escapeJson(e.getMessage())).append("\"");
            json.append("}");
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();

        return null;
    }

    // Helper method to escape JSON strings
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
```

### 6.4 Complete AJAX CRUD Example

#### HTML/JSP Page

```jsp
<!-- File: src/main/webapp/user-management.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management (AJAX)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.min.js"></script>
    <style>
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0;
                width: 100%; height: 100%; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fff; margin: 10% auto; padding: 20px;
                        border: 1px solid #888; width: 50%; border-radius: 5px; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer; }
        .close:hover { color: #000; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:hover { background-color: #f5f5f5; }
        .btn { padding: 5px 10px; margin: 2px; cursor: pointer; border: none; border-radius: 3px; }
        .btn-primary { background-color: #4CAF50; color: white; }
        .btn-danger { background-color: #f44336; color: white; }
        .btn-warning { background-color: #ff9800; color: white; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 3px; }
        .alert { padding: 10px; margin: 10px 0; border-radius: 3px; }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
    <div id="container">
        <h1>User Management</h1>

        <div id="message" style="display:none;"></div>

        <button id="addUserBtn" class="btn btn-primary">Add New User</button>

        <table id="userTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Active</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Populated via AJAX -->
            </tbody>
        </table>
    </div>

    <!-- User Form Modal -->
    <div id="userModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="modalTitle">Add User</h2>
            <form id="userForm">
                <input type="hidden" id="userId" name="id">

                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <div class="form-group">
                    <label>
                        <input type="checkbox" id="active" name="active" checked>
                        Active
                    </label>
                </div>

                <button type="submit" class="btn btn-primary">Save</button>
                <button type="button" class="btn" onclick="closeModal()">Cancel</button>
            </form>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/user-management.js"></script>
</body>
</html>
```

#### JavaScript File

```javascript
// File: src/main/webapp/js/user-management.js

var contextPath = ''; // Set this via JSP if needed

$(document).ready(function() {
    // Initialize
    loadUsers();

    // Add user button
    $('#addUserBtn').click(function() {
        openModal('add');
    });

    // Close modal
    $('.close').click(function() {
        closeModal();
    });

    // Close modal on outside click
    $(window).click(function(event) {
        if (event.target.id === 'userModal') {
            closeModal();
        }
    });

    // Form submit
    $('#userForm').submit(function(e) {
        e.preventDefault();
        saveUser();
    });

    // Edit button (delegated event)
    $(document).on('click', '.edit-btn', function() {
        var userId = $(this).data('id');
        editUser(userId);
    });

    // Delete button (delegated event)
    $(document).on('click', '.delete-btn', function() {
        var userId = $(this).data('id');
        deleteUser(userId);
    });

    // Toggle active button
    $(document).on('click', '.toggle-active-btn', function() {
        var userId = $(this).data('id');
        toggleUserActive(userId);
    });
});

// Load users from server
function loadUsers() {
    $.ajax({
        url: contextPath + '/user/listJson.do',
        type: 'GET',
        dataType: 'json',
        success: function(users) {
            displayUsers(users);
        },
        error: function(xhr, status, error) {
            console.error('Error loading users:', error);
            showMessage('Failed to load users', 'error');
        }
    });
}

// Display users in table
function displayUsers(users) {
    var tbody = $('#userTable tbody');
    tbody.empty();

    if (users.length === 0) {
        tbody.append('<tr><td colspan="5">No users found</td></tr>');
        return;
    }

    $.each(users, function(i, user) {
        var row = $('<tr>');
        row.append($('<td>').text(user.id));
        row.append($('<td>').text(user.username));
        row.append($('<td>').text(user.email));
        row.append($('<td>').text(user.active ? 'Yes' : 'No'));

        var actions = $('<td>');
        actions.append(
            $('<button>').addClass('btn btn-warning edit-btn')
                        .attr('data-id', user.id)
                        .text('Edit')
        );
        actions.append(
            $('<button>').addClass('btn btn-danger delete-btn')
                        .attr('data-id', user.id)
                        .text('Delete')
        );
        actions.append(
            $('<button>').addClass('btn toggle-active-btn')
                        .attr('data-id', user.id)
                        .text(user.active ? 'Deactivate' : 'Activate')
        );

        row.append(actions);
        tbody.append(row);
    });
}

// Open modal
function openModal(mode, userId) {
    if (mode === 'add') {
        $('#modalTitle').text('Add User');
        $('#userForm')[0].reset();
        $('#userId').val('');
        $('#password').prop('required', true);
    } else if (mode === 'edit') {
        $('#modalTitle').text('Edit User');
        $('#password').prop('required', false);
        // Load user data
        loadUserForEdit(userId);
    }
    $('#userModal').show();
}

// Close modal
function closeModal() {
    $('#userModal').hide();
    $('#userForm')[0].reset();
}

// Load user for editing
function loadUserForEdit(userId) {
    $.ajax({
        url: contextPath + '/user/getJson.do',
        type: 'GET',
        data: { id: userId },
        dataType: 'json',
        success: function(user) {
            $('#userId').val(user.id);
            $('#username').val(user.username);
            $('#email').val(user.email);
            $('#active').prop('checked', user.active);
        },
        error: function() {
            showMessage('Failed to load user data', 'error');
        }
    });
}

// Save user
function saveUser() {
    var formData = {
        id: $('#userId').val(),
        username: $('#username').val(),
        email: $('#email').val(),
        password: $('#password').val(),
        active: $('#active').is(':checked')
    };

    $.ajax({
        url: contextPath + '/user/saveJson.do',
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                showMessage('User saved successfully', 'success');
                closeModal();
                loadUsers();
            } else {
                showMessage(response.message, 'error');
            }
        },
        error: function(xhr, status, error) {
            showMessage('Failed to save user', 'error');
        }
    });
}

// Edit user
function editUser(userId) {
    openModal('edit', userId);
}

// Delete user
function deleteUser(userId) {
    if (!confirm('Are you sure you want to delete this user?')) {
        return;
    }

    $.ajax({
        url: contextPath + '/user/deleteJson.do',
        type: 'POST',
        data: { id: userId },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                showMessage('User deleted successfully', 'success');
                loadUsers();
            } else {
                showMessage(response.message, 'error');
            }
        },
        error: function() {
            showMessage('Failed to delete user', 'error');
        }
    });
}

// Toggle user active status
function toggleUserActive(userId) {
    $.ajax({
        url: contextPath + '/user/toggleActiveJson.do',
        type: 'POST',
        data: { id: userId },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                showMessage('User status updated', 'success');
                loadUsers();
            } else {
                showMessage(response.message, 'error');
            }
        },
        error: function() {
            showMessage('Failed to update status', 'error');
        }
    });
}

// Show message
function showMessage(message, type) {
    var messageDiv = $('#message');
    messageDiv.removeClass('alert-success alert-error');
    messageDiv.addClass('alert alert-' + type);
    messageDiv.text(message);
    messageDiv.show();

    // Auto-hide after 3 seconds
    setTimeout(function() {
        messageDiv.fadeOut();
    }, 3000);
}
```

### 6.5 Form Validation with jQuery

#### Client-Side Validation

```javascript
// File: src/main/webapp/js/validation.js

// Basic validation
function validateUserForm() {
    var isValid = true;
    var errors = [];

    // Username validation
    var username = $('#username').val().trim();
    if (username === '') {
        errors.push('Username is required');
        $('#username').addClass('error');
        isValid = false;
    } else if (username.length < 3) {
        errors.push('Username must be at least 3 characters');
        $('#username').addClass('error');
        isValid = false;
    } else {
        $('#username').removeClass('error');
    }

    // Email validation
    var email = $('#email').val().trim();
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (email === '') {
        errors.push('Email is required');
        $('#email').addClass('error');
        isValid = false;
    } else if (!emailRegex.test(email)) {
        errors.push('Invalid email format');
        $('#email').addClass('error');
        isValid = false;
    } else {
        $('#email').removeClass('error');
    }

    // Password validation
    var password = $('#password').val();
    if ($('#userId').val() === '') { // New user
        if (password === '') {
            errors.push('Password is required');
            $('#password').addClass('error');
            isValid = false;
        } else if (password.length < 6) {
            errors.push('Password must be at least 6 characters');
            $('#password').addClass('error');
            isValid = false;
        } else {
            $('#password').removeClass('error');
        }
    }

    // Display errors
    if (!isValid) {
        var errorHtml = '<ul>';
        $.each(errors, function(i, error) {
            errorHtml += '<li>' + error + '</li>';
        });
        errorHtml += '</ul>';
        $('#validationErrors').html(errorHtml).show();
    } else {
        $('#validationErrors').hide();
    }

    return isValid;
}

// Real-time validation
$(document).ready(function() {
    // Validate on blur
    $('#username').blur(function() {
        var username = $(this).val().trim();
        if (username.length > 0 && username.length < 3) {
            $(this).addClass('error');
            showFieldError($(this), 'Username must be at least 3 characters');
        } else {
            $(this).removeClass('error');
            hideFieldError($(this));
        }
    });

    // Validate email on blur
    $('#email').blur(function() {
        var email = $(this).val().trim();
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email.length > 0 && !emailRegex.test(email)) {
            $(this).addClass('error');
            showFieldError($(this), 'Invalid email format');
        } else {
            $(this).removeClass('error');
            hideFieldError($(this));
        }
    });

    // Password strength indicator
    $('#password').keyup(function() {
        var password = $(this).val();
        var strength = getPasswordStrength(password);
        $('#passwordStrength').text(strength.text)
                             .css('color', strength.color);
    });
});

function showFieldError(field, message) {
    var errorSpan = field.next('.field-error');
    if (errorSpan.length === 0) {
        field.after('<span class="field-error">' + message + '</span>');
    } else {
        errorSpan.text(message);
    }
}

function hideFieldError(field) {
    field.next('.field-error').remove();
}

function getPasswordStrength(password) {
    if (password.length === 0) {
        return { text: '', color: '' };
    } else if (password.length < 6) {
        return { text: 'Weak', color: 'red' };
    } else if (password.length < 10) {
        return { text: 'Medium', color: 'orange' };
    } else {
        return { text: 'Strong', color: 'green' };
    }
}
```

### 6.6 jQuery UI Integration (Optional)

#### Include jQuery UI

```jsp
<!-- Add to header -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
```

#### Datepicker

```javascript
// Initialize datepicker
$('#birthDate').datepicker({
    dateFormat: 'yy-mm-dd',
    changeMonth: true,
    changeYear: true,
    yearRange: '1950:2010',
    maxDate: new Date()
});
```

#### Autocomplete

```javascript
// Username autocomplete
$('#searchUser').autocomplete({
    source: function(request, response) {
        $.ajax({
            url: contextPath + '/user/searchJson.do',
            data: { term: request.term },
            dataType: 'json',
            success: function(data) {
                response($.map(data, function(item) {
                    return {
                        label: item.username + ' (' + item.email + ')',
                        value: item.username,
                        id: item.id
                    };
                }));
            }
        });
    },
    minLength: 2,
    select: function(event, ui) {
        console.log('Selected user ID:', ui.item.id);
    }
});
```

#### Dialog

```javascript
// Confirmation dialog
$('#deleteDialog').dialog({
    autoOpen: false,
    modal: true,
    buttons: {
        'Delete': function() {
            deleteUser(selectedUserId);
            $(this).dialog('close');
        },
        'Cancel': function() {
            $(this).dialog('close');
        }
    }
});

// Show dialog
$('.delete-btn').click(function() {
    selectedUserId = $(this).data('id');
    $('#deleteDialog').dialog('open');
});
```

### 6.7 jQuery Best Practices for Legacy Apps

#### Performance Optimization

```javascript
// ❌ BAD: Repeated jQuery selections
$('#element').addClass('active');
$('#element').css('color', 'red');
$('#element').fadeIn();

// ✅ GOOD: Cache jQuery objects
var $element = $('#element');
$element.addClass('active');
$element.css('color', 'red');
$element.fadeIn();

// ✅ BETTER: Method chaining
$('#element').addClass('active')
             .css('color', 'red')
             .fadeIn();

// ❌ BAD: Creating jQuery objects in loops
for (var i = 0; i < items.length; i++) {
    $('#list').append('<li>' + items[i] + '</li>');
}

// ✅ GOOD: Build HTML string first
var html = '';
for (var i = 0; i < items.length; i++) {
    html += '<li>' + items[i] + '</li>';
}
$('#list').html(html);

// ✅ BETTER: Use array join
var html = $.map(items, function(item) {
    return '<li>' + item + '</li>';
}).join('');
$('#list').html(html);
```

#### Event Delegation

```javascript
// ❌ BAD: Binding events to dynamic elements
$('.delete-btn').click(function() {
    // This won't work for dynamically added buttons
});

// ✅ GOOD: Event delegation
$(document).on('click', '.delete-btn', function() {
    // Works for all current and future .delete-btn elements
});

// ✅ BETTER: Delegate to closest static parent
$('#userTable').on('click', '.delete-btn', function() {
    // More efficient than delegating to document
});
```

#### Memory Management

```javascript
// Remove event handlers when done
$('#element').off('click');

// Empty containers before removing
$('#container').empty().remove();

// Avoid memory leaks with AJAX
var xhr;
if (xhr && xhr.readyState !== 4) {
    xhr.abort();
}
xhr = $.ajax({ /* ... */ });
```

---

## 7. Struts Integration Patterns

### 7.1 Struts Configuration Deep Dive

#### web.xml Configuration

```xml
<!-- File: src/main/webapp/WEB-INF/web.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
         http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
         version="2.5">

    <display-name>Legacy Application</display-name>
    <description>Legacy Struts 1.x Application</description>

    <!-- Context Parameters -->
    <context-param>
        <param-name>javax.servlet.jsp.jstl.fmt.localizationContext</param-name>
        <param-value>ApplicationResources</param-value>
    </context-param>

    <!-- Listeners -->
    <listener>
        <listener-class>com.example.listener.HibernateSessionFactoryListener</listener-class>
    </listener>

    <!-- Filters -->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>com.example.filter.EncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
    </filter>

    <filter>
        <filter-name>hibernateFilter</filter-name>
        <filter-class>com.example.filter.HibernateSessionFilter</filter-class>
    </filter>

    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>hibernateFilter</filter-name>
        <url-pattern>*.do</url-pattern>
    </filter-mapping>

    <!-- Struts ActionServlet -->
    <servlet>
        <servlet-name>action</servlet-name>
        <servlet-class>org.apache.struts.action.ActionServlet</servlet-class>

        <!-- Main Configuration File -->
        <init-param>
            <param-name>config</param-name>
            <param-value>/WEB-INF/struts-config.xml</param-value>
        </init-param>

        <!-- Module Configuration (if using modules) -->
        <init-param>
            <param-name>config/admin</param-name>
            <param-value>/WEB-INF/struts-config-admin.xml</param-value>
        </init-param>

        <!-- Debug Level -->
        <init-param>
            <param-name>debug</param-name>
            <param-value>2</param-value>
        </init-param>

        <!-- Detail Level -->
        <init-param>
            <param-name>detail</param-name>
            <param-value>2</param-value>
        </init-param>

        <load-on-startup>1</load-on-startup>
    </servlet>

    <!-- Servlet Mapping -->
    <servlet-mapping>
        <servlet-name>action</servlet-name>
        <url-pattern>*.do</url-pattern>
    </servlet-mapping>

    <!-- Welcome Files -->
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

    <!-- Session Configuration -->
    <session-config>
        <session-timeout>30</session-timeout>
    </session-config>

    <!-- Error Pages -->
    <error-page>
        <error-code>404</error-code>
        <location>/error/404.jsp</location>
    </error-page>

    <error-page>
        <error-code>500</error-code>
        <location>/error/500.jsp</location>
    </error-page>

    <error-page>
        <exception-type>java.lang.Exception</exception-type>
        <location>/error/exception.jsp</location>
    </error-page>

    <!-- Tag Library Descriptors (Struts 1.x) -->
    <jsp-config>
        <taglib>
            <taglib-uri>http://struts.apache.org/tags-html</taglib-uri>
            <taglib-location>/WEB-INF/struts-html.tld</taglib-location>
        </taglib>
        <taglib>
            <taglib-uri>http://struts.apache.org/tags-bean</taglib-uri>
            <taglib-location>/WEB-INF/struts-bean.tld</taglib-location>
        </taglib>
        <taglib>
            <taglib-uri>http://struts.apache.org/tags-logic</taglib-uri>
            <taglib-location>/WEB-INF/struts-logic.tld</taglib-location>
        </taglib>
    </jsp-config>
</web-app>
```

#### struts-config.xml Structure

```xml
<!-- File: src/main/webapp/WEB-INF/struts-config.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE struts-config PUBLIC
    "-//Apache Software Foundation//DTD Struts Configuration 1.3//EN"
    "http://struts.apache.org/dtds/struts-config_1_3.dtd">

<struts-config>

    <!-- ========== Data Source Configuration ========== -->
    <!-- (Optional - can use Hibernate instead) -->

    <!-- ========== Form Bean Definitions ========== -->
    <form-beans>
        <!-- User Management Forms -->
        <form-bean name="userForm" type="com.example.form.UserForm"/>
        <form-bean name="loginForm" type="com.example.form.LoginForm"/>
        <form-bean name="searchForm" type="com.example.form.SearchForm"/>

        <!-- Dynamic Form Bean (no Java class needed) -->
        <form-bean name="dynamicForm" type="org.apache.struts.action.DynaActionForm">
            <form-property name="username" type="java.lang.String"/>
            <form-property name="email" type="java.lang.String"/>
            <form-property name="age" type="java.lang.Integer" initial="0"/>
        </form-bean>
    </form-beans>

    <!-- ========== Global Exceptions ========== -->
    <global-exceptions>
        <exception
            key="error.database"
            type="com.example.exception.DAOException"
            path="/error/database.jsp"/>

        <exception
            key="error.general"
            type="java.lang.Exception"
            path="/error/exception.jsp"/>
    </global-exceptions>

    <!-- ========== Global Forwards ========== -->
    <global-forwards>
        <forward name="login" path="/login.jsp" redirect="true"/>
        <forward name="logout" path="/logout.do" redirect="true"/>
        <forward name="home" path="/index.jsp" redirect="false"/>
        <forward name="unauthorized" path="/error/unauthorized.jsp"/>
    </global-forwards>

    <!-- ========== Action Mappings ========== -->
    <action-mappings>

        <!-- Welcome/Home Action -->
        <action path="/index"
                type="com.example.action.HomeAction"
                validate="false">
            <forward name="success" path="/index.jsp"/>
        </action>

        <!-- User Management Actions -->

        <!-- List all users -->
        <action path="/user/list"
                type="com.example.action.UserAction"
                parameter="list"
                validate="false">
            <forward name="success" path="/users.jsp"/>
        </action>

        <!-- View user details -->
        <action path="/user/view"
                type="com.example.action.UserAction"
                parameter="view"
                validate="false">
            <forward name="success" path="/user-view.jsp"/>
            <forward name="notfound" path="/error/notfound.jsp"/>
        </action>

        <!-- Show add user form -->
        <action path="/user/add"
                type="com.example.action.UserAction"
                parameter="prepareAdd"
                validate="false">
            <forward name="success" path="/user-form.jsp"/>
        </action>

        <!-- Show edit user form -->
        <action path="/user/edit"
                type="com.example.action.UserAction"
                parameter="prepareEdit"
                validate="false">
            <forward name="success" path="/user-form.jsp"/>
            <forward name="notfound" path="/error/notfound.jsp"/>
        </action>

        <!-- Save user (add or update) -->
        <action path="/user/save"
                type="com.example.action.UserAction"
                name="userForm"
                scope="request"
                parameter="save"
                validate="true"
                input="/user-form.jsp">
            <forward name="success" path="/user/list.do" redirect="true"/>
            <forward name="input" path="/user-form.jsp"/>
        </action>

        <!-- Delete user -->
        <action path="/user/delete"
                type="com.example.action.UserAction"
                parameter="delete"
                validate="false">
            <forward name="success" path="/user/list.do" redirect="true"/>
        </action>

        <!-- AJAX Actions (no forward needed) -->
        <action path="/user/listJson"
                type="com.example.action.UserAction"
                parameter="listJson"
                validate="false"/>

        <action path="/user/saveJson"
                type="com.example.action.UserAction"
                parameter="saveJson"
                validate="false"/>

        <!-- Login/Logout Actions -->
        <action path="/login"
                type="com.example.action.LoginAction"
                name="loginForm"
                scope="request"
                parameter="login"
                validate="true"
                input="/login.jsp">
            <forward name="success" path="/index.jsp" redirect="true"/>
            <forward name="failure" path="/login.jsp"/>
        </action>

        <action path="/logout"
                type="com.example.action.LoginAction"
                parameter="logout"
                validate="false">
            <forward name="success" path="/login.jsp" redirect="true"/>
        </action>

        <!-- DispatchAction Example -->
        <action path="/product/*"
                type="com.example.action.ProductDispatchAction"
                parameter="{1}"
                validate="false">
            <forward name="list" path="/product-list.jsp"/>
            <forward name="view" path="/product-view.jsp"/>
            <forward name="form" path="/product-form.jsp"/>
            <forward name="success" path="/product/list.do" redirect="true"/>
        </action>

    </action-mappings>

    <!-- ========== Controller Configuration ========== -->
    <controller
        processorClass="org.apache.struts.action.RequestProcessor"
        maxFileSize="2M"
        memoryThreshold="1M"
        tempDir="/tmp"
        locale="true"
        nocache="true"
        contentType="text/html;charset=UTF-8"/>

    <!-- ========== Message Resources ========== -->
    <message-resources parameter="ApplicationResources" null="false"/>

    <!-- ========== Plug-ins ========== -->
    <plug-in className="org.apache.struts.validator.ValidatorPlugIn">
        <set-property property="pathnames"
                      value="/WEB-INF/validator-rules.xml,/WEB-INF/validation.xml"/>
    </plug-in>

</struts-config>
```

### 7.2 Action Patterns

#### Pattern 1: Basic Action

```java
// File: src/main/java/com/example/action/UserAction.java
package com.example.action;

import com.example.dao.UserDAO;
import com.example.dao.impl.UserDAOImpl;
import com.example.form.UserForm;
import com.example.model.User;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class UserAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                               ActionForm form,
                               HttpServletRequest request,
                               HttpServletResponse response) throws Exception {

        UserDAO userDAO = new UserDAOImpl();
        List<User> users = userDAO.findAll();

        request.setAttribute("users", users);

        return mapping.findForward("success");
    }
}
```

#### Pattern 2: DispatchAction (Multiple Methods)

```java
// File: src/main/java/com/example/action/UserDispatchAction.java
package com.example.action;

import com.example.dao.UserDAO;
import com.example.dao.impl.UserDAOImpl;
import com.example.form.UserForm;
import com.example.model.User;
import org.apache.struts.action.*;
import org.apache.struts.actions.DispatchAction;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class UserDispatchAction extends DispatchAction {

    // List all users
    public ActionForward list(ActionMapping mapping,
                             ActionForm form,
                             HttpServletRequest request,
                             HttpServletResponse response) throws Exception {

        UserDAO userDAO = new UserDAOImpl();
        List<User> users = userDAO.findAll();

        request.setAttribute("users", users);
        return mapping.findForward("list");
    }

    // View user details
    public ActionForward view(ActionMapping mapping,
                             ActionForm form,
                             HttpServletRequest request,
                             HttpServletResponse response) throws Exception {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            return mapping.findForward("notfound");
        }

        Long id = Long.parseLong(idStr);
        UserDAO userDAO = new UserDAOImpl();
        User user = userDAO.findById(id);

        if (user == null) {
            return mapping.findForward("notfound");
        }

        request.setAttribute("user", user);
        return mapping.findForward("view");
    }

    // Prepare for adding new user
    public ActionForward prepareAdd(ActionMapping mapping,
                                   ActionForm form,
                                   HttpServletRequest request,
                                   HttpServletResponse response) throws Exception {

        request.setAttribute("mode", "add");
        return mapping.findForward("form");
    }

    // Prepare for editing existing user
    public ActionForward prepareEdit(ActionMapping mapping,
                                    ActionForm form,
                                    HttpServletRequest request,
                                    HttpServletResponse response) throws Exception {

        String idStr = request.getParameter("id");
        Long id = Long.parseLong(idStr);

        UserDAO userDAO = new UserDAOImpl();
        User user = userDAO.findById(id);

        if (user == null) {
            return mapping.findForward("notfound");
        }

        // Populate form with user data
        UserForm userForm = (UserForm) form;
        userForm.setId(user.getId().toString());
        userForm.setUsername(user.getUsername());
        userForm.setEmail(user.getEmail());
        userForm.setFirstName(user.getFirstName());
        userForm.setLastName(user.getLastName());

        request.setAttribute("mode", "edit");
        return mapping.findForward("form");
    }

    // Save user (add or update)
    public ActionForward save(ActionMapping mapping,
                             ActionForm form,
                             HttpServletRequest request,
                             HttpServletResponse response) throws Exception {

        UserForm userForm = (UserForm) form;
        UserDAO userDAO = new UserDAOImpl();

        User user;
        if (userForm.getId() != null && !userForm.getId().isEmpty()) {
            // Update existing user
            Long id = Long.parseLong(userForm.getId());
            user = userDAO.findById(id);
            if (user == null) {
                ActionMessages errors = new ActionMessages();
                errors.add(ActionMessages.GLOBAL_MESSAGE,
                          new ActionMessage("error.user.notfound"));
                saveErrors(request, errors);
                return mapping.getInputForward();
            }
        } else {
            // Create new user
            user = new User();
        }

        // Populate user from form
        user.setUsername(userForm.getUsername());
        user.setEmail(userForm.getEmail());
        user.setFirstName(userForm.getFirstName());
        user.setLastName(userForm.getLastName());

        if (userForm.getPassword() != null && !userForm.getPassword().isEmpty()) {
            user.setPassword(userForm.getPassword());
        }

        // Save
        if (user.getId() == null) {
            userDAO.save(user);
        } else {
            userDAO.update(user);
        }

        // Success message
        ActionMessages messages = new ActionMessages();
        messages.add(ActionMessages.GLOBAL_MESSAGE,
                    new ActionMessage("message.user.saved"));
        saveMessages(request, messages);

        return mapping.findForward("success");
    }

    // Delete user
    public ActionForward delete(ActionMapping mapping,
                               ActionForm form,
                               HttpServletRequest request,
                               HttpServletResponse response) throws Exception {

        String idStr = request.getParameter("id");
        Long id = Long.parseLong(idStr);

        UserDAO userDAO = new UserDAOImpl();
        userDAO.delete(id);

        ActionMessages messages = new ActionMessages();
        messages.add(ActionMessages.GLOBAL_MESSAGE,
                    new ActionMessage("message.user.deleted"));
        saveMessages(request, messages);

        return mapping.findForward("success");
    }
}
```

```xml
<!-- Configuration for DispatchAction -->
<action path="/user/list"
        type="com.example.action.UserDispatchAction"
        parameter="list">
    <forward name="list" path="/user-list.jsp"/>
</action>

<action path="/user/view"
        type="com.example.action.UserDispatchAction"
        parameter="view">
    <forward name="view" path="/user-view.jsp"/>
    <forward name="notfound" path="/error/notfound.jsp"/>
</action>
```

#### Pattern 3: Parameter-Based Method Selection

```java
// File: src/main/java/com/example/action/ProductAction.java
package com.example.action;

import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                               ActionForm form,
                               HttpServletRequest request,
                               HttpServletResponse response) throws Exception {

        // Get method parameter from struts-config.xml
        String parameter = mapping.getParameter();

        if ("list".equals(parameter)) {
            return list(mapping, form, request, response);
        } else if ("view".equals(parameter)) {
            return view(mapping, form, request, response);
        } else if ("save".equals(parameter)) {
            return save(mapping, form, request, response);
        } else if ("delete".equals(parameter)) {
            return delete(mapping, form, request, response);
        }

        return mapping.findForward("list");
    }

    private ActionForward list(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request, HttpServletResponse response) {
        // List logic
        return mapping.findForward("list");
    }

    private ActionForward view(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request, HttpServletResponse response) {
        // View logic
        return mapping.findForward("view");
    }

    private ActionForward save(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request, HttpServletResponse response) {
        // Save logic
        return mapping.findForward("success");
    }

    private ActionForward delete(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request, HttpServletResponse response) {
        // Delete logic
        return mapping.findForward("success");
    }
}
```

#### Pattern 4: LookupDispatchAction (Internationalized)

```java
// File: src/main/java/com/example/action/UserLookupAction.java
package com.example.action;

import org.apache.struts.actions.LookupDispatchAction;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class UserLookupAction extends LookupDispatchAction {

    @Override
    protected Map getKeyMethodMap() {
        Map map = new HashMap();
        map.put("button.add", "add");
        map.put("button.edit", "edit");
        map.put("button.delete", "delete");
        map.put("button.search", "search");
        return map;
    }

    public ActionForward add(ActionMapping mapping, ActionForm form,
                            HttpServletRequest request, HttpServletResponse response) {
        // Add logic
        return mapping.findForward("form");
    }

    public ActionForward edit(ActionMapping mapping, ActionForm form,
                             HttpServletRequest request, HttpServletResponse response) {
        // Edit logic
        return mapping.findForward("form");
    }

    public ActionForward delete(ActionMapping mapping, ActionForm form,
                               HttpServletRequest request, HttpServletResponse response) {
        // Delete logic
        return mapping.findForward("success");
    }

    public ActionForward search(ActionMapping mapping, ActionForm form,
                               HttpServletRequest request, HttpServletResponse response) {
        // Search logic
        return mapping.findForward("results");
    }
}
```

### 7.3 ActionForm Patterns

#### Pattern 1: Standard ActionForm

```java
// File: src/main/java/com/example/form/UserForm.java
package com.example.form;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMessage;
import javax.servlet.http.HttpServletRequest;

public class UserForm extends ActionForm {

    private String id;
    private String username;
    private String password;
    private String confirmPassword;
    private String email;
    private String firstName;
    private String lastName;
    private String active;

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getActive() { return active; }
    public void setActive(String active) { this.active = active; }

    // Reset method
    @Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
        this.id = null;
        this.username = null;
        this.password = null;
        this.confirmPassword = null;
        this.email = null;
        this.firstName = null;
        this.lastName = null;
        this.active = "true";
    }

    // Validation method
    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();

        // Username validation
        if (username == null || username.trim().isEmpty()) {
            errors.add("username", new ActionMessage("error.username.required"));
        } else if (username.length() < 3) {
            errors.add("username", new ActionMessage("error.username.length"));
        }

        // Email validation
        if (email == null || email.trim().isEmpty()) {
            errors.add("email", new ActionMessage("error.email.required"));
        } else if (!isValidEmail(email)) {
            errors.add("email", new ActionMessage("error.email.invalid"));
        }

        // Password validation (for new users)
        if (id == null || id.isEmpty()) {
            if (password == null || password.isEmpty()) {
                errors.add("password", new ActionMessage("error.password.required"));
            } else if (password.length() < 6) {
                errors.add("password", new ActionMessage("error.password.length"));
            }
        }

        // Confirm password validation
        if (password != null && !password.isEmpty()) {
            if (confirmPassword == null || confirmPassword.isEmpty()) {
                errors.add("confirmPassword",
                          new ActionMessage("error.confirmPassword.required"));
            } else if (!password.equals(confirmPassword)) {
                errors.add("confirmPassword",
                          new ActionMessage("error.password.mismatch"));
            }
        }

        return errors;
    }

    // Helper method for email validation
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email.matches(emailRegex);
    }
}
```

#### Pattern 2: DynaActionForm (XML-based)

```xml
<!-- In struts-config.xml -->
<form-beans>
    <form-bean name="productForm" type="org.apache.struts.action.DynaActionForm">
        <form-property name="id" type="java.lang.Long"/>
        <form-property name="name" type="java.lang.String"/>
        <form-property name="description" type="java.lang.String"/>
        <form-property name="price" type="java.lang.Double" initial="0.0"/>
        <form-property name="category" type="java.lang.String"/>
        <form-property name="active" type="java.lang.Boolean" initial="true"/>
    </form-bean>
</form-beans>
```

```java
// Using DynaActionForm in Action
public ActionForward save(ActionMapping mapping, ActionForm form,
                         HttpServletRequest request, HttpServletResponse response) {

    DynaActionForm productForm = (DynaActionForm) form;

    String name = (String) productForm.get("name");
    Double price = (Double) productForm.get("price");
    Boolean active = (Boolean) productForm.get("active");

    // Process data...

    return mapping.findForward("success");
}
```

#### Pattern 3: ValidatorForm (with Validator framework)

```java
// File: src/main/java/com/example/form/LoginForm.java
package com.example.form;

import org.apache.struts.validator.ValidatorForm;

public class LoginForm extends ValidatorForm {

    private String username;
    private String password;

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
```

```xml
<!-- File: src/main/webapp/WEB-INF/validation.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE form-validation PUBLIC
    "-//Apache Software Foundation//DTD Commons Validator Rules Configuration 1.1.3//EN"
    "http://jakarta.apache.org/commons/dtds/validator_1_1_3.dtd">

<form-validation>
    <formset>
        <form name="loginForm">
            <field property="username" depends="required,minlength">
                <arg key="label.username" position="0"/>
                <arg key="${var:minlength}" position="1" resource="false"/>
                <var>
                    <var-name>minlength</var-name>
                    <var-value>3</var-value>
                </var>
            </field>

            <field property="password" depends="required,minlength">
                <arg key="label.password" position="0"/>
                <arg key="${var:minlength}" position="1" resource="false"/>
                <var>
                    <var-name>minlength</var-name>
                    <var-value>6</var-value>
                </var>
            </field>
        </form>

        <form name="userForm">
            <field property="username" depends="required,minlength,maxlength">
                <arg key="label.username" position="0"/>
                <var>
                    <var-name>minlength</var-name>
                    <var-value>3</var-value>
                </var>
                <var>
                    <var-name>maxlength</var-name>
                    <var-value>50</var-value>
                </var>
            </field>

            <field property="email" depends="required,email">
                <arg key="label.email" position="0"/>
            </field>

            <field property="password" depends="required,minlength">
                <arg key="label.password" position="0"/>
                <var>
                    <var-name>minlength</var-name>
                    <var-value>6</var-value>
                </var>
            </field>
        </form>
    </formset>
</form-validation>
```

### 7.4 Message Resources and i18n

#### ApplicationResources.properties

```properties
# File: src/main/resources/ApplicationResources.properties

# Application Messages
app.title=Legacy Application
app.welcome=Welcome to Legacy Application

# Labels
label.username=Username
label.password=Password
label.email=Email
label.firstName=First Name
label.lastName=Last Name
label.active=Active
label.createdDate=Created Date

# Buttons
button.submit=Submit
button.cancel=Cancel
button.save=Save
button.delete=Delete
button.edit=Edit
button.add=Add
button.search=Search
button.login=Login
button.logout=Logout

# Success Messages
message.user.saved=User has been saved successfully
message.user.deleted=User has been deleted successfully
message.user.updated=User has been updated successfully
message.login.success=Login successful

# Error Messages
error.username.required=Username is required
error.username.length=Username must be at least 3 characters
error.password.required=Password is required
error.password.length=Password must be at least 6 characters
error.password.mismatch=Passwords do not match
error.email.required=Email is required
error.email.invalid=Invalid email format
error.confirmPassword.required=Please confirm your password

# Database Errors
error.database=Database error occurred
error.user.notfound=User not found
error.general=An error occurred. Please try again.

# Validation Errors (for Validator framework)
errors.required={0} is required
errors.minlength={0} must be at least {1} characters
errors.maxlength={0} cannot exceed {1} characters
errors.email={0} is not a valid email address
errors.date={0} is not a valid date
```

#### Japanese Resources (i18n)

```properties
# File: src/main/resources/ApplicationResources_ja.properties

app.title=レガシーアプリケーション
app.welcome=レガシーアプリケーションへようこそ

label.username=ユーザー名
label.password=パスワード
label.email=メールアドレス
label.firstName=名
label.lastName=姓
label.active=アクティブ

button.submit=送信
button.cancel=キャンセル
button.save=保存
button.delete=削除
button.edit=編集
button.add=追加

message.user.saved=ユーザーが正常に保存されました
message.user.deleted=ユーザーが正常に削除されました

error.username.required=ユーザー名は必須です
error.password.required=パスワードは必須です
error.email.invalid=無効なメールアドレス形式です
```

#### Using Messages in JSP

```jsp
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<!-- Display message from properties file -->
<h1><bean:message key="app.title"/></h1>
<p><bean:message key="app.welcome"/></p>

<!-- Display label -->
<label><bean:message key="label.username"/>:</label>

<!-- Display button text -->
<button><bean:message key="button.submit"/></button>

<!-- Display errors -->
<html:errors/>

<!-- Display messages -->
<html:messages id="message" message="true">
    <div class="alert-success">
        <bean:write name="message"/>
    </div>
</html:messages>

<!-- Display specific field error -->
<html:errors property="username"/>
```

### 7.5 Advanced Struts Patterns

#### Request Scope vs Session Scope

```xml
<!-- Request scope (default, recommended) -->
<action path="/user/save"
        type="com.example.action.UserAction"
        name="userForm"
        scope="request"
        validate="true"
        input="/user-form.jsp">
    <forward name="success" path="/user/list.do" redirect="true"/>
</action>

<!-- Session scope (use for wizard/multi-page forms) -->
<action path="/wizard/step1"
        type="com.example.action.WizardAction"
        name="wizardForm"
        scope="session"
        validate="false">
    <forward name="success" path="/wizard-step2.jsp"/>
</action>
```

#### Redirect vs Forward

```xml
<!-- Forward (server-side, preserves request attributes) -->
<forward name="success" path="/user-list.jsp" redirect="false"/>

<!-- Redirect (client-side, PRG pattern, loses request attributes) -->
<forward name="success" path="/user/list.do" redirect="true"/>
```

```java
// In Action class
// Forward
return mapping.findForward("success");

// Redirect
return mapping.findForward("success"); // If configured with redirect="true"

// Programmatic redirect
response.sendRedirect(request.getContextPath() + "/user/list.do");
return null;
```

#### Pre-populate and Post-process Patterns

```java
// File: src/main/java/com/example/action/BaseAction.java
package com.example.action;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class BaseAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
                               HttpServletRequest request, HttpServletResponse response)
                               throws Exception {

        // Pre-process: Load common data
        preProcess(request, response);

        // Execute actual action
        ActionForward forward = executeAction(mapping, form, request, response);

        // Post-process: Cleanup, logging, etc.
        postProcess(request, response);

        return forward;
    }

    protected void preProcess(HttpServletRequest request, HttpServletResponse response) {
        // Load common dropdown data
        request.setAttribute("categories", loadCategories());
        request.setAttribute("countries", loadCountries());
    }

    protected abstract ActionForward executeAction(ActionMapping mapping, ActionForm form,
                                                  HttpServletRequest request,
                                                  HttpServletResponse response)
                                                  throws Exception;

    protected void postProcess(HttpServletRequest request, HttpServletResponse response) {
        // Cleanup resources, log activity, etc.
    }

    private List loadCategories() {
        // Load categories from database
        return new ArrayList();
    }

    private List loadCountries() {
        // Load countries from database
        return new ArrayList();
    }
}
```

---

## 8. Build and Deployment

### 8.1 Apache Ant Build System

#### Complete build.xml

```xml
<!-- File: build.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<project name="legacy-app" default="war" basedir=".">

    <!-- ==================== Property Definitions ==================== -->

    <property name="app.name" value="legacy-app"/>
    <property name="app.version" value="1.0.0"/>
    <property name="app.war" value="${app.name}.war"/>

    <!-- Source directories -->
    <property name="src.dir" location="src/main/java"/>
    <property name="resources.dir" location="src/main/resources"/>
    <property name="webapp.dir" location="src/main/webapp"/>
    <property name="test.src.dir" location="src/test/java"/>

    <!-- Build directories -->
    <property name="build.dir" location="build"/>
    <property name="build.classes.dir" location="${build.dir}/classes"/>
    <property name="build.war.dir" location="${build.dir}/war"/>
    <property name="build.test.dir" location="${build.dir}/test-classes"/>
    <property name="build.docs.dir" location="${build.dir}/docs"/>

    <!-- Distribution directory -->
    <property name="dist.dir" location="dist"/>

    <!-- Library directory -->
    <property name="lib.dir" location="lib"/>

    <!-- Compilation settings -->
    <property name="compile.debug" value="true"/>
    <property name="compile.deprecation" value="false"/>
    <property name="compile.optimize" value="false"/>
    <property name="compile.source" value="1.5"/>
    <property name="compile.target" value="1.5"/>

    <!-- ==================== Classpath Definition ==================== -->

    <path id="compile.classpath">
        <fileset dir="${lib.dir}">
            <include name="**/*.jar"/>
        </fileset>
    </path>

    <path id="test.classpath">
        <path refid="compile.classpath"/>
        <pathelement location="${build.classes.dir}"/>
        <pathelement location="${build.test.dir}"/>
    </path>

    <!-- ==================== All Target ==================== -->

    <target name="all" depends="clean,compile,war"
            description="Clean build, compile, and create WAR file"/>

    <!-- ==================== Clean Target ==================== -->

    <target name="clean" description="Delete build and dist directories">
        <delete dir="${build.dir}"/>
        <delete dir="${dist.dir}"/>
    </target>

    <!-- ==================== Init Target ==================== -->

    <target name="init" description="Create build directories">
        <mkdir dir="${build.dir}"/>
        <mkdir dir="${build.classes.dir}"/>
        <mkdir dir="${build.war.dir}"/>
        <mkdir dir="${build.test.dir}"/>
        <mkdir dir="${build.docs.dir}"/>
        <mkdir dir="${dist.dir}"/>

        <!-- Create timestamp -->
        <tstamp>
            <format property="build.time" pattern="yyyy-MM-dd HH:mm:ss"/>
        </tstamp>

        <echo message="Building ${app.name} version ${app.version}"/>
        <echo message="Build time: ${build.time}"/>
    </target>

    <!-- ==================== Compile Target ==================== -->

    <target name="compile" depends="init" description="Compile Java sources">

        <!-- Compile Java classes -->
        <javac srcdir="${src.dir}"
               destdir="${build.classes.dir}"
               debug="${compile.debug}"
               deprecation="${compile.deprecation}"
               optimize="${compile.optimize}"
               source="${compile.source}"
               target="${compile.target}"
               includeantruntime="false">
            <classpath refid="compile.classpath"/>
        </javac>

        <!-- Copy resources to classes directory -->
        <copy todir="${build.classes.dir}">
            <fileset dir="${resources.dir}">
                <include name="**/*.xml"/>
                <include name="**/*.properties"/>
                <include name="**/*.hbm.xml"/>
            </fileset>
        </copy>

        <echo message="Compilation complete"/>
    </target>

    <!-- ==================== Compile Tests Target ==================== -->

    <target name="compile-tests" depends="compile"
            description="Compile test sources">

        <javac srcdir="${test.src.dir}"
               destdir="${build.test.dir}"
               debug="${compile.debug}"
               source="${compile.source}"
               target="${compile.target}"
               includeantruntime="false">
            <classpath refid="test.classpath"/>
        </javac>

        <echo message="Test compilation complete"/>
    </target>

    <!-- ==================== WAR Target ==================== -->

    <target name="war" depends="compile" description="Create WAR file">

        <!-- Copy web content -->
        <copy todir="${build.war.dir}">
            <fileset dir="${webapp.dir}">
                <include name="**/*"/>
            </fileset>
        </copy>

        <!-- Copy compiled classes -->
        <copy todir="${build.war.dir}/WEB-INF/classes">
            <fileset dir="${build.classes.dir}">
                <include name="**/*.class"/>
                <include name="**/*.xml"/>
                <include name="**/*.properties"/>
            </fileset>
        </copy>

        <!-- Copy libraries -->
        <copy todir="${build.war.dir}/WEB-INF/lib">
            <fileset dir="${lib.dir}">
                <include name="**/*.jar"/>
            </fileset>
        </copy>

        <!-- Create WAR file -->
        <war destfile="${dist.dir}/${app.war}"
             webxml="${build.war.dir}/WEB-INF/web.xml">
            <fileset dir="${build.war.dir}">
                <exclude name="WEB-INF/web.xml"/>
            </fileset>
            <manifest>
                <attribute name="Built-By" value="${user.name}"/>
                <attribute name="Built-Date" value="${build.time}"/>
                <attribute name="Implementation-Title" value="${app.name}"/>
                <attribute name="Implementation-Version" value="${app.version}"/>
            </manifest>
        </war>

        <echo message="WAR file created: ${dist.dir}/${app.war}"/>
    </target>

    <!-- ==================== Javadoc Target ==================== -->

    <target name="javadoc" depends="init" description="Generate Javadoc">

        <javadoc sourcepath="${src.dir}"
                 destdir="${build.docs.dir}/javadoc"
                 packagenames="com.example.*"
                 author="true"
                 version="true"
                 use="true"
                 windowtitle="${app.name} API Documentation"
                 doctitle="${app.name} API Documentation"
                 bottom="Copyright &#169; 2025. All Rights Reserved.">
            <classpath refid="compile.classpath"/>
        </javadoc>

        <echo message="Javadoc generated in ${build.docs.dir}/javadoc"/>
    </target>

    <!-- ==================== Test Target ==================== -->

    <target name="test" depends="compile-tests" description="Run unit tests">

        <junit printsummary="yes" haltonfailure="no" fork="yes">
            <classpath refid="test.classpath"/>

            <formatter type="plain" usefile="false"/>
            <formatter type="xml"/>

            <batchtest todir="${build.dir}/test-results">
                <fileset dir="${test.src.dir}">
                    <include name="**/*Test.java"/>
                </fileset>
            </batchtest>
        </junit>

        <echo message="Tests complete"/>
    </target>

    <!-- ==================== Deploy Target ==================== -->

    <target name="deploy" depends="war" description="Deploy WAR to Tomcat">

        <property name="tomcat.webapps" value="/usr/local/tomcat/webapps"/>

        <!-- Copy WAR to Tomcat -->
        <copy file="${dist.dir}/${app.war}"
              todir="${tomcat.webapps}"
              overwrite="true"/>

        <echo message="Deployed to ${tomcat.webapps}/${app.war}"/>
        <echo message="Application will be available at: http://localhost:8080/${app.name}/"/>
    </target>

    <!-- ==================== Undeploy Target ==================== -->

    <target name="undeploy" description="Remove application from Tomcat">

        <property name="tomcat.webapps" value="/usr/local/tomcat/webapps"/>

        <delete file="${tomcat.webapps}/${app.war}"/>
        <delete dir="${tomcat.webapps}/${app.name}"/>

        <echo message="Application undeployed"/>
    </target>

    <!-- ==================== Package Source Target ==================== -->

    <target name="package-src" depends="init" description="Create source distribution">

        <zip destfile="${dist.dir}/${app.name}-${app.version}-src.zip">
            <fileset dir=".">
                <include name="src/**"/>
                <include name="lib/**"/>
                <include name="build.xml"/>
                <include name="README.md"/>
                <include name="docs/**"/>
                <exclude name="**/.git/**"/>
                <exclude name="**/build/**"/>
                <exclude name="**/dist/**"/>
            </fileset>
        </zip>

        <echo message="Source package created: ${dist.dir}/${app.name}-${app.version}-src.zip"/>
    </target>

    <!-- ==================== Info Target ==================== -->

    <target name="info" description="Display build information">
        <echo message=""/>
        <echo message="Project Information"/>
        <echo message="=================="/>
        <echo message="Name: ${app.name}"/>
        <echo message="Version: ${app.version}"/>
        <echo message=""/>
        <echo message="Directories"/>
        <echo message="=================="/>
        <echo message="Source: ${src.dir}"/>
        <echo message="Build: ${build.dir}"/>
        <echo message="Dist: ${dist.dir}"/>
        <echo message="Lib: ${lib.dir}"/>
        <echo message=""/>
        <echo message="Java Settings"/>
        <echo message="=================="/>
        <echo message="Source: ${compile.source}"/>
        <echo message="Target: ${compile.target}"/>
        <echo message="Debug: ${compile.debug}"/>
        <echo message=""/>
    </target>

</project>
```

#### Common Ant Commands

```bash
# Display available targets
ant -projecthelp

# Clean build
ant clean

# Compile only
ant compile

# Create WAR file
ant war

# Full rebuild
ant clean compile war

# Generate Javadoc
ant javadoc

# Run tests
ant test

# Deploy to Tomcat
ant deploy

# Complete build with docs
ant clean compile javadoc war

# Display project info
ant info

# Package source code
ant package-src
```

### 8.2 Build Optimization

#### Incremental Compilation

```xml
<!-- Add to compile target -->
<target name="compile" depends="init" description="Compile Java sources">

    <javac srcdir="${src.dir}"
           destdir="${build.classes.dir}"
           debug="${compile.debug}"
           source="${compile.source}"
           target="${compile.target}"
           includeantruntime="false">

        <!-- Only compile changed files -->
        <compilerarg value="-Xlint:unchecked"/>
        <compilerarg value="-Xlint:deprecation"/>

        <classpath refid="compile.classpath"/>
    </javac>

    <!-- Use uptodate task to check if recompilation needed -->
    <uptodate property="compile.uptodate" targetfile="${build.classes.dir}/.compiled">
        <srcfiles dir="${src.dir}" includes="**/*.java"/>
    </uptodate>

</target>
```

#### Parallel Execution

```xml
<!-- Use parallel task for independent operations -->
<target name="build-parallel" depends="init">
    <parallel>
        <antcall target="compile"/>
        <antcall target="compile-tests"/>
        <antcall target="javadoc"/>
    </parallel>
</target>
```

#### Conditional Execution

```xml
<!-- Skip tests if not needed -->
<target name="war-no-tests" depends="compile" description="Create WAR without running tests">
    <property name="skip.tests" value="true"/>
    <antcall target="war"/>
</target>

<!-- Environment-specific builds -->
<target name="war-dev" depends="compile">
    <property name="env" value="development"/>
    <copy file="config/${env}/hibernate.cfg.xml"
          tofile="${build.classes.dir}/hibernate.cfg.xml"/>
    <antcall target="war"/>
</target>

<target name="war-prod" depends="compile">
    <property name="env" value="production"/>
    <copy file="config/${env}/hibernate.cfg.xml"
          tofile="${build.classes.dir}/hibernate.cfg.xml"/>
    <antcall target="war"/>
</target>
```

### 8.3 Deployment Strategies

#### Strategy 1: Manual WAR Deployment

```bash
# 1. Build WAR file
ant clean war

# 2. Stop Tomcat (if running)
docker stop tomcat6

# 3. Copy WAR to webapps
cp dist/legacy-app.war /path/to/tomcat/webapps/

# 4. Start Tomcat
docker start tomcat6

# 5. Verify deployment
curl http://localhost:8080/legacy-app/
```

#### Strategy 2: Hot Deployment (Auto-deploy)

```bash
# Tomcat auto-deploys WARs in webapps directory

# 1. Build WAR
ant war

# 2. Copy to webapps (Tomcat running)
cp dist/legacy-app.war /path/to/tomcat/webapps/

# Tomcat automatically:
# - Detects new/updated WAR
# - Undeploys old version
# - Deploys new version
# - No restart needed

# 3. Monitor deployment
tail -f /path/to/tomcat/logs/catalina.out
```

#### Strategy 3: Volume Mount Deployment (Docker)

```yaml
# File: .devcontainer/compose.services.yaml
services:
  tomcat6:
    image: tomcat:6.0.53-jre8
    container_name: tomcat6
    ports:
      - "8080:8080"
    volumes:
      # Mount dist directory to Tomcat webapps
      - ../dist:/usr/local/tomcat/webapps:rw
    networks:
      - legacy-network
```

```bash
# 1. Build WAR
ant war
# WAR is created in dist/legacy-app.war

# 2. Tomcat auto-deploys from mounted volume
# No manual copy needed!

# 3. Access application
curl http://localhost:8080/legacy-app/
```

#### Strategy 4: Tomcat Manager Deployment

```xml
<!-- Add to build.xml -->
<property name="tomcat.manager.url" value="http://localhost:8080/manager"/>
<property name="tomcat.manager.username" value="admin"/>
<property name="tomcat.manager.password" value="admin"/>

<target name="deploy-manager" depends="war" description="Deploy via Tomcat Manager">
    <taskdef name="deploy"
             classname="org.apache.catalina.ant.DeployTask"
             classpath="${lib.dir}/catalina-ant.jar"/>

    <deploy url="${tomcat.manager.url}"
            username="${tomcat.manager.username}"
            password="${tomcat.manager.password}"
            path="/${app.name}"
            war="file:${dist.dir}/${app.war}"/>
</target>

<target name="undeploy-manager" description="Undeploy via Tomcat Manager">
    <taskdef name="undeploy"
             classname="org.apache.catalina.ant.UndeployTask"
             classpath="${lib.dir}/catalina-ant.jar"/>

    <undeploy url="${tomcat.manager.url}"
              username="${tomcat.manager.username}"
              password="${tomcat.manager.password}"
              path="/${app.name}"/>
</target>

<target name="reload-manager" description="Reload via Tomcat Manager">
    <taskdef name="reload"
             classname="org.apache.catalina.ant.ReloadTask"
             classpath="${lib.dir}/catalina-ant.jar"/>

    <reload url="${tomcat.manager.url}"
            username="${tomcat.manager.username}"
            password="${tomcat.manager.password}"
            path="/${app.name}"/>
</target>
```

### 8.4 Environment Configuration

#### Environment-Specific Properties

```
config/
├── development/
│   ├── hibernate.cfg.xml
│   ├── database.properties
│   └── log4j.properties
├── staging/
│   ├── hibernate.cfg.xml
│   ├── database.properties
│   └── log4j.properties
└── production/
    ├── hibernate.cfg.xml
    ├── database.properties
    └── log4j.properties
```

```properties
# File: config/development/database.properties
db.driver=com.mysql.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/legacy_db_dev
db.username=dev_user
db.password=dev_password
db.pool.min=5
db.pool.max=10

# File: config/production/database.properties
db.driver=com.mysql.jdbc.Driver
db.url=jdbc:mysql://prod-server:3306/legacy_db_prod
db.username=prod_user
db.password=secure_prod_password
db.pool.min=10
db.pool.max=50
```

#### Build with Environment Selection

```xml
<!-- Add to build.xml -->
<target name="build-dev" depends="compile" description="Build for development">
    <property name="env" value="development"/>
    <antcall target="copy-env-config"/>
    <antcall target="war"/>
</target>

<target name="build-staging" depends="compile" description="Build for staging">
    <property name="env" value="staging"/>
    <antcall target="copy-env-config"/>
    <antcall target="war"/>
</target>

<target name="build-prod" depends="compile" description="Build for production">
    <property name="env" value="production"/>
    <antcall target="copy-env-config"/>
    <antcall target="war"/>
</target>

<target name="copy-env-config">
    <echo message="Copying ${env} configuration"/>

    <copy file="config/${env}/hibernate.cfg.xml"
          tofile="${build.classes.dir}/hibernate.cfg.xml"
          overwrite="true"/>

    <copy file="config/${env}/database.properties"
          tofile="${build.classes.dir}/database.properties"
          overwrite="true"/>

    <copy file="config/${env}/log4j.properties"
          tofile="${build.classes.dir}/log4j.properties"
          overwrite="true"/>
</target>
```

```bash
# Build for different environments
ant build-dev      # Development build
ant build-staging  # Staging build
ant build-prod     # Production build
```

### 8.5 Deployment Verification

#### Health Check Endpoint

```java
// File: src/main/java/com/example/action/HealthCheckAction.java
package com.example.action;

import com.example.util.HibernateUtil;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import org.hibernate.Session;

public class HealthCheckAction extends Action {

    public ActionForward execute(ActionMapping mapping, ActionForm form,
                               HttpServletRequest request, HttpServletResponse response)
                               throws Exception {

        StringBuilder status = new StringBuilder();
        boolean healthy = true;

        status.append("{\n");
        status.append("  \"status\": \"");

        // Check database connection
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.createQuery("SELECT 1").uniqueResult();
            session.close();
            status.append("Database: OK\n");
        } catch (Exception e) {
            status.append("Database: FAILED - " + e.getMessage() + "\n");
            healthy = false;
        }

        // Check application version
        String version = getServlet().getServletContext().getInitParameter("app.version");
        status.append("  \"version\": \"" + (version != null ? version : "unknown") + "\",\n");

        status.append("  \"healthy\": " + healthy + "\n");
        status.append("}\n");

        response.setContentType("application/json");
        response.setStatus(healthy ? 200 : 503);
        PrintWriter out = response.getWriter();
        out.print(status.toString());
        out.flush();

        return null;
    }
}
```

```xml
<!-- Add to struts-config.xml -->
<action path="/health"
        type="com.example.action.HealthCheckAction"
        validate="false"/>
```

```bash
# Test health endpoint
curl http://localhost:8080/legacy-app/health.do

# Expected response:
# {
#   "status": "Database: OK\n",
#   "version": "1.0.0",
#   "healthy": true
# }
```

#### Deployment Checklist

```bash
#!/bin/bash
# File: scripts/verify-deployment.sh

echo "========================================="
echo "Deployment Verification"
echo "========================================="

APP_URL="http://localhost:8080/legacy-app"

# 1. Check if application is accessible
echo -n "1. Checking application accessibility... "
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL/)
if [ $HTTP_CODE -eq 200 ]; then
    echo "✓ OK (HTTP $HTTP_CODE)"
else
    echo "✗ FAILED (HTTP $HTTP_CODE)"
    exit 1
fi

# 2. Check health endpoint
echo -n "2. Checking health endpoint... "
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL/health.do)
if [ $HTTP_CODE -eq 200 ]; then
    echo "✓ OK (HTTP $HTTP_CODE)"
else
    echo "✗ FAILED (HTTP $HTTP_CODE)"
    exit 1
fi

# 3. Check database connection
echo -n "3. Checking database connection... "
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL/test-db.jsp)
if [ $HTTP_CODE -eq 200 ]; then
    echo "✓ OK (HTTP $HTTP_CODE)"
else
    echo "✗ FAILED (HTTP $HTTP_CODE)"
    exit 1
fi

# 4. Check user list page
echo -n "4. Checking user list page... "
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL/user/list.do)
if [ $HTTP_CODE -eq 200 ]; then
    echo "✓ OK (HTTP $HTTP_CODE)"
else
    echo "✗ FAILED (HTTP $HTTP_CODE)"
    exit 1
fi

# 5. Check static resources
echo -n "5. Checking CSS resources... "
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL/css/style.css)
if [ $HTTP_CODE -eq 200 ]; then
    echo "✓ OK (HTTP $HTTP_CODE)"
else
    echo "✗ FAILED (HTTP $HTTP_CODE)"
    exit 1
fi

echo -n "6. Checking JavaScript resources... "
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL/js/jquery-1.12.4.min.js)
if [ $HTTP_CODE -eq 200 ]; then
    echo "✓ OK (HTTP $HTTP_CODE)"
else
    echo "✗ FAILED (HTTP $HTTP_CODE)"
    exit 1
fi

echo "========================================="
echo "✓ All checks passed!"
echo "========================================="
```

```bash
# Run verification
chmod +x scripts/verify-deployment.sh
./scripts/verify-deployment.sh
```

### 8.6 Rollback Strategy

#### Simple Rollback

```bash
# 1. Keep backup of previous WAR
cp dist/legacy-app.war dist/legacy-app-backup-$(date +%Y%m%d-%H%M%S).war

# 2. If deployment fails, restore backup
cp dist/legacy-app-backup-20250112-143000.war /path/to/tomcat/webapps/legacy-app.war

# 3. Tomcat auto-redeploys
# Wait for deployment to complete
```

#### Versioned Deployment

```bash
# 1. Create versioned WAR
ant war
mv dist/legacy-app.war dist/legacy-app-v1.0.0.war

# 2. Deploy versioned WAR
cp dist/legacy-app-v1.0.0.war /path/to/tomcat/webapps/legacy-app.war

# 3. Keep version history
ls -lh dist/
# legacy-app-v1.0.0.war
# legacy-app-v1.0.1.war
# legacy-app-v1.0.2.war

# 4. Rollback to previous version
cp dist/legacy-app-v1.0.1.war /path/to/tomcat/webapps/legacy-app.war
```

#### Database Migration Rollback

```sql
-- File: config/mysql/rollback/rollback_v1.0.1.sql

-- Rollback migration from v1.0.1 to v1.0.0
DROP TABLE IF EXISTS new_feature_table;

ALTER TABLE users DROP COLUMN IF EXISTS new_column;

-- Restore previous data if needed
UPDATE users SET status = 'ACTIVE' WHERE status = 'NEW_STATUS';
```

```bash
# Apply rollback script
mysql -h localhost -P 3306 -u legacy_user -p legacy_db < config/mysql/rollback/rollback_v1.0.1.sql
```

### 8.7 Continuous Integration Setup

#### Simple CI Script

```bash
#!/bin/bash
# File: scripts/ci-build.sh

set -e  # Exit on error

echo "========================================="
echo "CI Build Started"
echo "========================================="

# 1. Clean workspace
echo "Step 1: Cleaning workspace..."
ant clean

# 2. Compile
echo "Step 2: Compiling sources..."
ant compile

# 3. Run tests
echo "Step 3: Running tests..."
ant test || true  # Continue even if tests fail

# 4. Generate Javadoc
echo "Step 4: Generating Javadoc..."
ant javadoc

# 5. Create WAR
echo "Step 5: Creating WAR file..."
ant war

# 6. Run deployment verification
echo "Step 6: Verifying build..."
if [ -f "dist/legacy-app.war" ]; then
    echo "✓ WAR file created successfully"
    ls -lh dist/legacy-app.war
else
    echo "✗ WAR file not found"
    exit 1
fi

echo "========================================="
echo "CI Build Completed Successfully"
echo "========================================="
```

```bash
# Make executable and run
chmod +x scripts/ci-build.sh
./scripts/ci-build.sh
```

---

## 9. Testing Strategies

### 9.1 Testing Overview

**Testing Pyramid for Legacy Stack**

```
                    /\
                   /UI\
                  /Tests\
                 /--------\
                /Integration\
               /   Tests     \
              /--------------\
             /  Unit Tests     \
            /____________________\
```

**Testing Priorities:**
1. **Unit Tests**: DAO layer, utility classes, business logic
2. **Integration Tests**: Database operations, Hibernate mappings
3. **Struts Tests**: Actions, Forms, request/response handling
4. **UI Tests**: Manual testing with test scripts (limited automation)

**Testing Constraints in Java 1.5 Environment:**
- JUnit 4.12 (last version supporting Java 1.5)
- No annotations-based testing (Java 1.5 annotation support limited)
- Mock frameworks have limited support
- Focus on traditional JUnit 3.8.x style testing

---

### 9.2 Unit Testing Setup

**JUnit Configuration**

Add to `lib/test/`:
```xml
<!-- JUnit 4.12 (last Java 1.5 compatible version) -->
junit-4.12.jar
hamcrest-core-1.3.jar

<!-- Optional: DbUnit for database testing -->
dbunit-2.4.9.jar
slf4j-api-1.7.12.jar
slf4j-simple-1.7.12.jar
```

**Test Directory Structure**

```
test/
├── java/
│   └── com/
│       └── example/
│           ├── dao/
│           │   ├── impl/
│           │   │   ├── UserDAOImplTest.java
│           │   │   └── BaseDAOImplTest.java
│           │   └── UserDAOTest.java
│           ├── action/
│           │   ├── UserActionTest.java
│           │   └── SampleActionTest.java
│           ├── form/
│           │   └── UserFormTest.java
│           ├── util/
│           │   ├── HibernateUtilTest.java
│           │   └── ValidationUtilTest.java
│           └── TestSuite.java
├── resources/
│   ├── hibernate-test.cfg.xml
│   ├── test-data.sql
│   └── test.properties
└── webapp/
    └── WEB-INF/
        └── struts-config-test.xml
```

**Ant Build Configuration for Tests**

Add to `build.xml`:
```xml
<!-- Test properties -->
<property name="test.src.dir" value="test/java"/>
<property name="test.resources.dir" value="test/resources"/>
<property name="test.build.dir" value="build/test-classes"/>
<property name="test.reports.dir" value="build/test-reports"/>
<property name="test.lib.dir" value="lib/test"/>

<!-- Test classpath -->
<path id="test.classpath">
    <path refid="compile.classpath"/>
    <pathelement location="${build.dir}/classes"/>
    <pathelement location="${test.build.dir}"/>
    <fileset dir="${test.lib.dir}">
        <include name="**/*.jar"/>
    </fileset>
</path>

<!-- Compile tests target -->
<target name="compile-tests" depends="compile"
        description="Compile test classes">
    <mkdir dir="${test.build.dir}"/>

    <javac srcdir="${test.src.dir}"
           destdir="${test.build.dir}"
           classpathref="test.classpath"
           source="1.5"
           target="1.5"
           debug="true"
           deprecation="true"
           includeantruntime="false">
        <compilerarg value="-Xlint:unchecked"/>
    </javac>

    <!-- Copy test resources -->
    <copy todir="${test.build.dir}">
        <fileset dir="${test.resources.dir}">
            <include name="**/*.xml"/>
            <include name="**/*.properties"/>
            <include name="**/*.sql"/>
        </fileset>
    </copy>
</target>

<!-- Run all tests target -->
<target name="test" depends="compile-tests"
        description="Run all unit tests">
    <mkdir dir="${test.reports.dir}"/>

    <junit printsummary="yes"
           haltonfailure="no"
           haltonerror="no"
           fork="yes"
           forkmode="once"
           maxmemory="256m">

        <classpath refid="test.classpath"/>

        <formatter type="plain" usefile="false"/>
        <formatter type="xml"/>

        <batchtest todir="${test.reports.dir}">
            <fileset dir="${test.src.dir}">
                <include name="**/*Test.java"/>
                <exclude name="**/Abstract*.java"/>
            </fileset>
        </batchtest>
    </junit>
</target>

<!-- Run specific test target -->
<target name="test-single" depends="compile-tests"
        description="Run a single test class">
    <!-- Usage: ant test-single -Dtest.class=com.example.dao.impl.UserDAOImplTest -->
    <fail unless="test.class"
          message="Must specify test.class property"/>

    <junit printsummary="yes"
           haltonfailure="yes"
           fork="yes">
        <classpath refid="test.classpath"/>
        <formatter type="plain" usefile="false"/>
        <test name="${test.class}"/>
    </junit>
</target>

<!-- Test with coverage (optional with Cobertura) -->
<target name="test-coverage" depends="compile-tests"
        description="Run tests with code coverage">
    <!-- Requires cobertura.jar in lib/test -->
    <taskdef resource="tasks.properties"
             classpathref="test.classpath"/>

    <cobertura-instrument todir="${build.dir}/instrumented">
        <fileset dir="${build.dir}/classes">
            <include name="**/*.class"/>
            <exclude name="**/*Test*.class"/>
        </fileset>
    </cobertura-instrument>

    <junit fork="yes" forkmode="once">
        <sysproperty key="net.sourceforge.cobertura.datafile"
                     file="${basedir}/cobertura.ser"/>
        <classpath location="${build.dir}/instrumented"/>
        <classpath refid="test.classpath"/>

        <formatter type="xml"/>
        <batchtest todir="${test.reports.dir}">
            <fileset dir="${test.src.dir}">
                <include name="**/*Test.java"/>
            </fileset>
        </batchtest>
    </junit>

    <cobertura-report format="html"
                     destdir="${test.reports.dir}/coverage"
                     srcdir="${src.dir}"/>
</target>
```

---

### 9.3 DAO Layer Testing

**Base Test Class for Database Tests**

`test/java/com/example/dao/BaseDAOTest.java`:
```java
package com.example.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;

import java.io.File;
import java.io.FileReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * Base class for DAO tests with database setup/teardown
 */
public abstract class BaseDAOTest {

    protected static SessionFactory sessionFactory;
    protected Session session;

    @BeforeClass
    public static void setUpDatabase() throws Exception {
        // Build test SessionFactory
        Configuration config = new Configuration();
        config.configure("hibernate-test.cfg.xml");
        sessionFactory = config.buildSessionFactory();

        // Run database schema creation
        executeScript("test/resources/schema.sql");
    }

    @Before
    public void setUp() throws Exception {
        // Open session for each test
        session = sessionFactory.openSession();
        session.beginTransaction();

        // Load test data
        executeScript("test/resources/test-data.sql");
    }

    @After
    public void tearDown() throws Exception {
        if (session != null) {
            if (session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            session.close();
        }

        // Clean up test data
        executeScript("test/resources/cleanup.sql");
    }

    /**
     * Execute SQL script file
     */
    protected static void executeScript(String scriptPath) throws Exception {
        Connection conn = null;
        Statement stmt = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Get connection from test properties
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/testdb",
                "testuser",
                "testpass"
            );

            stmt = conn.createStatement();

            // Read and execute script
            File file = new File(scriptPath);
            if (!file.exists()) {
                return; // Skip if script doesn't exist
            }

            Reader reader = new FileReader(file);
            StringBuilder sql = new StringBuilder();
            char[] buffer = new char[1024];
            int len;

            while ((len = reader.read(buffer)) > 0) {
                sql.append(buffer, 0, len);
            }
            reader.close();

            // Split by semicolon and execute
            String[] statements = sql.toString().split(";");
            for (String s : statements) {
                s = s.trim();
                if (s.length() > 0) {
                    stmt.execute(s);
                }
            }

        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    /**
     * Get current Hibernate session
     */
    protected Session getSession() {
        return session;
    }
}
```

**UserDAO Test Example**

`test/java/com/example/dao/impl/UserDAOImplTest.java`:
```java
package com.example.dao.impl;

import com.example.dao.BaseDAOTest;
import com.example.dao.UserDAO;
import com.example.model.User;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

import java.util.Date;
import java.util.List;

/**
 * Test cases for UserDAOImpl
 */
public class UserDAOImplTest extends BaseDAOTest {

    private UserDAO userDAO;

    @Before
    public void setUp() throws Exception {
        super.setUp();
        userDAO = new UserDAOImpl();
        ((UserDAOImpl) userDAO).setSession(session);
    }

    @Test
    public void testSaveUser() {
        // Arrange
        User user = new User();
        user.setUsername("newuser");
        user.setEmail("newuser@example.com");
        user.setPassword("password123");
        user.setCreatedDate(new Date());

        // Act
        userDAO.save(user);
        session.flush();

        // Assert
        assertNotNull("User ID should be generated", user.getId());
        assertTrue("User ID should be positive", user.getId() > 0);
    }

    @Test
    public void testFindById() {
        // Arrange - test data loaded in setUp()
        Long userId = 1L;

        // Act
        User user = userDAO.findById(userId);

        // Assert
        assertNotNull("User should be found", user);
        assertEquals("Username should match", "testuser", user.getUsername());
        assertEquals("Email should match",
                    "testuser@example.com", user.getEmail());
    }

    @Test
    public void testFindByUsername() {
        // Arrange
        String username = "testuser";

        // Act
        User user = userDAO.findByUsername(username);

        // Assert
        assertNotNull("User should be found", user);
        assertEquals("Username should match", username, user.getUsername());
    }

    @Test
    public void testFindByUsername_NotFound() {
        // Act
        User user = userDAO.findByUsername("nonexistent");

        // Assert
        assertNull("User should not be found", user);
    }

    @Test
    public void testFindAll() {
        // Act
        List users = userDAO.findAll();

        // Assert
        assertNotNull("User list should not be null", users);
        assertTrue("Should have at least one user", users.size() > 0);
    }

    @Test
    public void testUpdate() {
        // Arrange
        User user = userDAO.findById(1L);
        String newEmail = "updated@example.com";

        // Act
        user.setEmail(newEmail);
        userDAO.update(user);
        session.flush();
        session.clear(); // Clear cache

        // Assert
        User updated = userDAO.findById(1L);
        assertEquals("Email should be updated", newEmail, updated.getEmail());
    }

    @Test
    public void testDelete() {
        // Arrange
        User user = userDAO.findById(1L);

        // Act
        userDAO.delete(user);
        session.flush();
        session.clear();

        // Assert
        User deleted = userDAO.findById(1L);
        assertNull("User should be deleted", deleted);
    }

    @Test
    public void testFindByEmail() {
        // Arrange
        String email = "testuser@example.com";

        // Act
        User user = userDAO.findByEmail(email);

        // Assert
        assertNotNull("User should be found", user);
        assertEquals("Email should match", email, user.getEmail());
    }

    @Test
    public void testCountAll() {
        // Act
        long count = userDAO.countAll();

        // Assert
        assertTrue("Should have at least one user", count > 0);
    }

    @Test(expected = org.hibernate.exception.ConstraintViolationException.class)
    public void testSaveUser_DuplicateUsername() {
        // Arrange
        User user1 = new User();
        user1.setUsername("duplicate");
        user1.setEmail("user1@example.com");
        user1.setPassword("pass");
        user1.setCreatedDate(new Date());

        User user2 = new User();
        user2.setUsername("duplicate");
        user2.setEmail("user2@example.com");
        user2.setPassword("pass");
        user2.setCreatedDate(new Date());

        // Act
        userDAO.save(user1);
        session.flush();

        userDAO.save(user2);
        session.flush(); // Should throw exception
    }
}
```

**Test Hibernate Configuration**

`test/resources/hibernate-test.cfg.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-configuration PUBLIC
    "-//Hibernate/Hibernate Configuration DTD 3.0//EN"
    "http://hibernate.sourceforge.net/hibernate-configuration-3.0.dtd">

<hibernate-configuration>
    <session-factory>
        <!-- Test Database Connection Settings -->
        <property name="connection.driver_class">com.mysql.jdbc.Driver</property>
        <property name="connection.url">jdbc:mysql://localhost:3306/testdb?useUnicode=true&amp;characterEncoding=UTF-8</property>
        <property name="connection.username">testuser</property>
        <property name="connection.password">testpass</property>

        <!-- JDBC Connection Pool Settings (use a small pool for tests) -->
        <property name="connection.pool_size">2</property>

        <!-- SQL Dialect -->
        <property name="dialect">org.hibernate.dialect.MySQL5InnoDBDialect</property>

        <!-- Echo all executed SQL to stdout -->
        <property name="show_sql">true</property>
        <property name="format_sql">true</property>

        <!-- Drop and re-create the database schema on startup -->
        <property name="hbm2ddl.auto">create-drop</property>

        <!-- Current Session Context -->
        <property name="current_session_context_class">thread</property>

        <!-- Disable second-level cache for testing -->
        <property name="cache.provider_class">org.hibernate.cache.NoCacheProvider</property>

        <!-- Mapping files -->
        <mapping resource="com/example/model/User.hbm.xml"/>

    </session-factory>
</hibernate-configuration>
```

**Test Data Script**

`test/resources/test-data.sql`:
```sql
-- Clean existing data
DELETE FROM users;

-- Reset auto-increment
ALTER TABLE users AUTO_INCREMENT = 1;

-- Insert test users
INSERT INTO users (username, email, password, created_date, active)
VALUES
    ('testuser', 'testuser@example.com', 'password123', NOW(), 1),
    ('admin', 'admin@example.com', 'admin123', NOW(), 1),
    ('inactive', 'inactive@example.com', 'pass', NOW(), 0);
```

`test/resources/cleanup.sql`:
```sql
DELETE FROM users;
```

---

### 9.4 Struts Action Testing

**MockObjects for Struts Testing**

Since we can't use modern mocking frameworks easily in Java 1.5, create mock objects manually:

`test/java/com/example/test/mock/MockHttpServletRequest.java`:
```java
package com.example.test.mock;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletInputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.security.Principal;
import java.util.*;

/**
 * Mock implementation of HttpServletRequest for testing
 */
public class MockHttpServletRequest implements HttpServletRequest {

    private Map attributes = new HashMap();
    private Map parameters = new HashMap();
    private HttpSession session;
    private String method = "GET";
    private String contextPath = "";
    private String servletPath = "";
    private String pathInfo = "";
    private String requestURI = "";

    public void setParameter(String name, String value) {
        parameters.put(name, new String[]{value});
    }

    public void setParameter(String name, String[] values) {
        parameters.put(name, values);
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public void setSession(HttpSession session) {
        this.session = session;
    }

    public Object getAttribute(String name) {
        return attributes.get(name);
    }

    public void setAttribute(String name, Object value) {
        attributes.put(name, value);
    }

    public void removeAttribute(String name) {
        attributes.remove(name);
    }

    public Enumeration getAttributeNames() {
        return Collections.enumeration(attributes.keySet());
    }

    public String getParameter(String name) {
        String[] values = (String[]) parameters.get(name);
        return values != null && values.length > 0 ? values[0] : null;
    }

    public Map getParameterMap() {
        return Collections.unmodifiableMap(parameters);
    }

    public Enumeration getParameterNames() {
        return Collections.enumeration(parameters.keySet());
    }

    public String[] getParameterValues(String name) {
        return (String[]) parameters.get(name);
    }

    public HttpSession getSession() {
        return session;
    }

    public HttpSession getSession(boolean create) {
        if (session == null && create) {
            session = new MockHttpSession();
        }
        return session;
    }

    public String getMethod() {
        return method;
    }

    public String getContextPath() {
        return contextPath;
    }

    public void setContextPath(String contextPath) {
        this.contextPath = contextPath;
    }

    public String getServletPath() {
        return servletPath;
    }

    public void setServletPath(String servletPath) {
        this.servletPath = servletPath;
    }

    public String getRequestURI() {
        return requestURI;
    }

    public void setRequestURI(String requestURI) {
        this.requestURI = requestURI;
    }

    // Implement other required methods with defaults
    public String getAuthType() { return null; }
    public Cookie[] getCookies() { return new Cookie[0]; }
    public long getDateHeader(String name) { return -1; }
    public String getHeader(String name) { return null; }
    public Enumeration getHeaders(String name) { return Collections.enumeration(Collections.EMPTY_LIST); }
    public Enumeration getHeaderNames() { return Collections.enumeration(Collections.EMPTY_LIST); }
    public int getIntHeader(String name) { return -1; }
    public String getPathInfo() { return pathInfo; }
    public String getPathTranslated() { return null; }
    public String getQueryString() { return null; }
    public String getRemoteUser() { return null; }
    public boolean isUserInRole(String role) { return false; }
    public Principal getUserPrincipal() { return null; }
    public String getRequestedSessionId() { return null; }
    public StringBuffer getRequestURL() { return new StringBuffer(); }
    public boolean isRequestedSessionIdValid() { return false; }
    public boolean isRequestedSessionIdFromCookie() { return false; }
    public boolean isRequestedSessionIdFromURL() { return false; }
    public boolean isRequestedSessionIdFromUrl() { return false; }
    public String getCharacterEncoding() { return "UTF-8"; }
    public void setCharacterEncoding(String env) {}
    public int getContentLength() { return -1; }
    public String getContentType() { return null; }
    public ServletInputStream getInputStream() { return null; }
    public String getProtocol() { return "HTTP/1.1"; }
    public String getScheme() { return "http"; }
    public String getServerName() { return "localhost"; }
    public int getServerPort() { return 8080; }
    public BufferedReader getReader() { return null; }
    public String getRemoteAddr() { return "127.0.0.1"; }
    public String getRemoteHost() { return "localhost"; }
    public Locale getLocale() { return Locale.getDefault(); }
    public Enumeration getLocales() { return Collections.enumeration(Collections.singletonList(Locale.getDefault())); }
    public boolean isSecure() { return false; }
    public RequestDispatcher getRequestDispatcher(String path) { return null; }
    public String getRealPath(String path) { return null; }
    public int getRemotePort() { return 0; }
    public String getLocalName() { return "localhost"; }
    public String getLocalAddr() { return "127.0.0.1"; }
    public int getLocalPort() { return 8080; }
}
```

`test/java/com/example/test/mock/MockHttpServletResponse.java`:
```java
package com.example.test.mock;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * Mock implementation of HttpServletResponse for testing
 */
public class MockHttpServletResponse implements HttpServletResponse {

    private int status = SC_OK;
    private String contentType;
    private String characterEncoding = "UTF-8";
    private StringWriter writer = new StringWriter();
    private PrintWriter printWriter = new PrintWriter(writer);
    private ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
    private Map headers = new HashMap();
    private List cookies = new ArrayList();
    private String redirectLocation;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setStatus(int status, String message) {
        this.status = status;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public String getCharacterEncoding() {
        return characterEncoding;
    }

    public void setCharacterEncoding(String charset) {
        this.characterEncoding = charset;
    }

    public PrintWriter getWriter() {
        return printWriter;
    }

    public String getOutputAsString() {
        printWriter.flush();
        return writer.toString();
    }

    public ServletOutputStream getOutputStream() {
        return new ServletOutputStream() {
            public void write(int b) {
                outputStream.write(b);
            }
        };
    }

    public byte[] getOutputAsByteArray() {
        return outputStream.toByteArray();
    }

    public void sendRedirect(String location) {
        this.redirectLocation = location;
        this.status = SC_MOVED_TEMPORARILY;
    }

    public String getRedirectLocation() {
        return redirectLocation;
    }

    public void addCookie(Cookie cookie) {
        cookies.add(cookie);
    }

    public List getCookies() {
        return cookies;
    }

    public void setHeader(String name, String value) {
        headers.put(name, value);
    }

    public void addHeader(String name, String value) {
        headers.put(name, value);
    }

    public String getHeader(String name) {
        return (String) headers.get(name);
    }

    // Implement other required methods with defaults
    public boolean containsHeader(String name) { return headers.containsKey(name); }
    public String encodeURL(String url) { return url; }
    public String encodeRedirectURL(String url) { return url; }
    public String encodeUrl(String url) { return url; }
    public String encodeRedirectUrl(String url) { return url; }
    public void sendError(int sc, String msg) { this.status = sc; }
    public void sendError(int sc) { this.status = sc; }
    public void setDateHeader(String name, long date) {}
    public void addDateHeader(String name, long date) {}
    public void setIntHeader(String name, int value) {}
    public void addIntHeader(String name, int value) {}
    public void setContentLength(int len) {}
    public void setLocale(Locale loc) {}
    public Locale getLocale() { return Locale.getDefault(); }
    public void setBufferSize(int size) {}
    public int getBufferSize() { return 0; }
    public void flushBuffer() {}
    public void resetBuffer() {}
    public boolean isCommitted() { return false; }
    public void reset() {}
}
```

`test/java/com/example/test/mock/MockHttpSession.java`:
```java
package com.example.test.mock;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * Mock implementation of HttpSession for testing
 */
public class MockHttpSession implements HttpSession {

    private Map attributes = new HashMap();
    private String id = "MOCK_SESSION_ID";
    private long creationTime = System.currentTimeMillis();
    private long lastAccessedTime = creationTime;
    private int maxInactiveInterval = 1800;
    private boolean isNew = true;
    private boolean invalid = false;

    public Object getAttribute(String name) {
        return attributes.get(name);
    }

    public void setAttribute(String name, Object value) {
        attributes.put(name, value);
    }

    public void removeAttribute(String name) {
        attributes.remove(name);
    }

    public Enumeration getAttributeNames() {
        return Collections.enumeration(attributes.keySet());
    }

    public String getId() {
        return id;
    }

    public long getCreationTime() {
        return creationTime;
    }

    public long getLastAccessedTime() {
        return lastAccessedTime;
    }

    public void setMaxInactiveInterval(int interval) {
        this.maxInactiveInterval = interval;
    }

    public int getMaxInactiveInterval() {
        return maxInactiveInterval;
    }

    public boolean isNew() {
        return isNew;
    }

    public void invalidate() {
        invalid = true;
        attributes.clear();
    }

    public boolean isInvalid() {
        return invalid;
    }

    // Deprecated methods
    public HttpSessionContext getSessionContext() { return null; }
    public Object getValue(String name) { return getAttribute(name); }
    public String[] getValueNames() {
        return (String[]) attributes.keySet().toArray(new String[0]);
    }
    public void putValue(String name, Object value) { setAttribute(name, value); }
    public void removeValue(String name) { removeAttribute(name); }
    public ServletContext getServletContext() { return null; }
}
```

**UserAction Test Example**

`test/java/com/example/action/UserActionTest.java`:
```java
package com.example.action;

import com.example.dao.UserDAO;
import com.example.form.UserForm;
import com.example.model.User;
import com.example.test.mock.*;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Test cases for UserAction
 */
public class UserActionTest {

    private UserAction action;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;
    private MockActionMapping mapping;
    private UserForm form;
    private MockUserDAO mockDAO;

    @Before
    public void setUp() {
        action = new UserAction();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
        mapping = new MockActionMapping();
        form = new UserForm();

        // Inject mock DAO
        mockDAO = new MockUserDAO();
        action.setUserDAO(mockDAO);

        // Set up session
        request.setSession(new MockHttpSession());
    }

    @Test
    public void testList() throws Exception {
        // Arrange
        List mockUsers = new ArrayList();
        User user1 = new User();
        user1.setId(new Long(1));
        user1.setUsername("user1");
        mockUsers.add(user1);

        mockDAO.setFindAllResult(mockUsers);

        mapping.addForward("success", "/users.jsp");

        // Act
        ActionForward forward = action.list(mapping, form, request, response);

        // Assert
        assertEquals("Should forward to success", "success", forward.getName());
        List users = (List) request.getAttribute("users");
        assertNotNull("Users should be in request", users);
        assertEquals("Should have one user", 1, users.size());
    }

    @Test
    public void testView() throws Exception {
        // Arrange
        User mockUser = new User();
        mockUser.setId(new Long(1));
        mockUser.setUsername("testuser");
        mockUser.setEmail("test@example.com");

        mockDAO.setFindByIdResult(mockUser);

        request.setParameter("id", "1");
        mapping.addForward("success", "/user-detail.jsp");

        // Act
        ActionForward forward = action.view(mapping, form, request, response);

        // Assert
        assertEquals("Should forward to success", "success", forward.getName());
        User user = (User) request.getAttribute("user");
        assertNotNull("User should be in request", user);
        assertEquals("Username should match", "testuser", user.getUsername());
    }

    @Test
    public void testSave() throws Exception {
        // Arrange
        form.setUsername("newuser");
        form.setEmail("newuser@example.com");
        form.setPassword("password123");

        mapping.addForward("success", "/users.do");

        // Act
        ActionForward forward = action.save(mapping, form, request, response);

        // Assert
        assertEquals("Should forward to success", "success", forward.getName());
        assertTrue("DAO save should be called", mockDAO.isSaveCalled());

        User savedUser = mockDAO.getSavedUser();
        assertNotNull("User should be saved", savedUser);
        assertEquals("Username should match", "newuser", savedUser.getUsername());
    }

    /**
     * Mock UserDAO for testing
     */
    private static class MockUserDAO implements UserDAO {
        private List findAllResult;
        private User findByIdResult;
        private boolean saveCalled = false;
        private User savedUser;

        public void setFindAllResult(List users) {
            this.findAllResult = users;
        }

        public void setFindByIdResult(User user) {
            this.findByIdResult = user;
        }

        public boolean isSaveCalled() {
            return saveCalled;
        }

        public User getSavedUser() {
            return savedUser;
        }

        public List findAll() {
            return findAllResult;
        }

        public User findById(Long id) {
            return findByIdResult;
        }

        public void save(User user) {
            saveCalled = true;
            savedUser = user;
            if (user.getId() == null) {
                user.setId(new Long(999));
            }
        }

        public void update(User user) {}
        public void delete(User user) {}
        public User findByUsername(String username) { return null; }
        public User findByEmail(String email) { return null; }
        public long countAll() { return 0; }
    }

    /**
     * Mock ActionMapping for testing
     */
    private static class MockActionMapping extends ActionMapping {
        private Map forwards = new HashMap();

        public void addForward(String name, String path) {
            ActionForward forward = new ActionForward();
            forward.setName(name);
            forward.setPath(path);
            forwards.put(name, forward);
        }

        public ActionForward findForward(String name) {
            return (ActionForward) forwards.get(name);
        }
    }
}
```

---

### 9.5 Integration Testing

**Database Integration Test**

`test/java/com/example/integration/DatabaseIntegrationTest.java`:
```java
package com.example.integration;

import com.example.dao.UserDAO;
import com.example.dao.impl.UserDAOImpl;
import com.example.model.User;
import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

import java.util.Date;
import java.util.List;

/**
 * Integration tests for database operations
 */
public class DatabaseIntegrationTest {

    private UserDAO userDAO;
    private Session session;

    @Before
    public void setUp() {
        session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();

        userDAO = new UserDAOImpl();
        ((UserDAOImpl) userDAO).setSession(session);
    }

    @After
    public void tearDown() {
        if (session != null) {
            if (session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            session.close();
        }
    }

    @Test
    public void testCompleteUserLifecycle() {
        // Create
        User user = new User();
        user.setUsername("integration_test_user");
        user.setEmail("integration@test.com");
        user.setPassword("password");
        user.setCreatedDate(new Date());
        user.setActive(true);

        userDAO.save(user);
        session.flush();

        Long userId = user.getId();
        assertNotNull("User ID should be assigned", userId);

        // Read
        session.clear(); // Clear first-level cache
        User foundUser = userDAO.findById(userId);
        assertNotNull("User should be found", foundUser);
        assertEquals("Username should match", "integration_test_user",
                    foundUser.getUsername());

        // Update
        foundUser.setEmail("updated@test.com");
        userDAO.update(foundUser);
        session.flush();
        session.clear();

        User updatedUser = userDAO.findById(userId);
        assertEquals("Email should be updated", "updated@test.com",
                    updatedUser.getEmail());

        // Delete
        userDAO.delete(updatedUser);
        session.flush();
        session.clear();

        User deletedUser = userDAO.findById(userId);
        assertNull("User should be deleted", deletedUser);
    }

    @Test
    public void testTransactionRollback() {
        // Save user
        User user = new User();
        user.setUsername("rollback_test");
        user.setEmail("rollback@test.com");
        user.setPassword("password");
        user.setCreatedDate(new Date());

        userDAO.save(user);
        Long userId = user.getId();

        // Rollback transaction
        session.getTransaction().rollback();
        session.beginTransaction();

        // Verify user was not persisted
        User notFound = userDAO.findById(userId);
        assertNull("User should not exist after rollback", notFound);
    }
}
```

---

### 9.6 Form Validation Testing

**UserForm Test**

`test/java/com/example/form/UserFormTest.java`:
```java
package com.example.form;

import com.example.test.mock.MockHttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Test cases for UserForm validation
 */
public class UserFormTest {

    private UserForm form;
    private MockHttpServletRequest request;
    private ActionMapping mapping;

    @Before
    public void setUp() {
        form = new UserForm();
        request = new MockHttpServletRequest();
        mapping = new ActionMapping();
    }

    @Test
    public void testValidateSuccess() {
        // Arrange
        form.setUsername("validuser");
        form.setEmail("valid@example.com");
        form.setPassword("password123");
        form.setConfirmPassword("password123");

        // Act
        ActionErrors errors = form.validate(mapping, request);

        // Assert
        assertTrue("Should have no validation errors",
                  errors == null || errors.isEmpty());
    }

    @Test
    public void testValidateUsernameRequired() {
        // Arrange
        form.setUsername("");
        form.setEmail("valid@example.com");
        form.setPassword("password");

        // Act
        ActionErrors errors = form.validate(mapping, request);

        // Assert
        assertNotNull("Should have errors", errors);
        assertFalse("Should have username error", errors.isEmpty());
        assertNotNull("Should have username field error",
                     errors.get("username"));
    }

    @Test
    public void testValidateEmailFormat() {
        // Arrange
        form.setUsername("user");
        form.setEmail("invalid-email");
        form.setPassword("password");

        // Act
        ActionErrors errors = form.validate(mapping, request);

        // Assert
        assertNotNull("Should have errors", errors);
        assertNotNull("Should have email error", errors.get("email"));
    }

    @Test
    public void testValidatePasswordMismatch() {
        // Arrange
        form.setUsername("user");
        form.setEmail("user@example.com");
        form.setPassword("password123");
        form.setConfirmPassword("different");

        // Act
        ActionErrors errors = form.validate(mapping, request);

        // Assert
        assertNotNull("Should have errors", errors);
        assertNotNull("Should have password error",
                     errors.get("confirmPassword"));
    }

    @Test
    public void testValidatePasswordMinLength() {
        // Arrange
        form.setUsername("user");
        form.setEmail("user@example.com");
        form.setPassword("123");
        form.setConfirmPassword("123");

        // Act
        ActionErrors errors = form.validate(mapping, request);

        // Assert
        assertNotNull("Should have errors", errors);
        assertNotNull("Should have password length error",
                     errors.get("password"));
    }
}
```

---

### 9.7 Test Data Management

**DbUnit for Test Data**

`test/resources/dataset.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<dataset>
    <users id="1"
           username="testuser1"
           email="test1@example.com"
           password="password123"
           created_date="2024-01-01 10:00:00"
           active="1"/>

    <users id="2"
           username="testuser2"
           email="test2@example.com"
           password="password456"
           created_date="2024-01-02 10:00:00"
           active="1"/>

    <users id="3"
           username="inactive"
           email="inactive@example.com"
           password="password789"
           created_date="2024-01-03 10:00:00"
           active="0"/>
</dataset>
```

**DbUnit Test Base Class**

`test/java/com/example/test/DbUnitTest.java`:
```java
package com.example.test;

import org.dbunit.DatabaseTestCase;
import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.dbunit.operation.DatabaseOperation;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Base class for DbUnit tests
 */
public abstract class DbUnitTest extends DatabaseTestCase {

    protected Connection getConnection() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/testdb",
            "testuser",
            "testpass"
        );
    }

    protected IDatabaseConnection getConnection() throws Exception {
        return new DatabaseConnection(getConnection());
    }

    protected IDataSet getDataSet() throws Exception {
        return new FlatXmlDataSetBuilder()
            .build(new FileInputStream("test/resources/dataset.xml"));
    }

    protected DatabaseOperation getSetUpOperation() {
        return DatabaseOperation.CLEAN_INSERT;
    }

    protected DatabaseOperation getTearDownOperation() {
        return DatabaseOperation.DELETE_ALL;
    }
}
```

---

### 9.8 Running Tests

**Run All Tests**

```bash
ant test
```

**Run Specific Test Class**

```bash
ant test-single -Dtest.class=com.example.dao.impl.UserDAOImplTest
```

**Run Tests with Coverage**

```bash
ant test-coverage
```

**View Test Results**

```bash
# View test reports
ls -la build/test-reports/

# View coverage reports
open build/test-reports/coverage/index.html
```

**Continuous Testing During Development**

Create a watch script for continuous testing:

`scripts/test-watch.sh`:
```bash
#!/bin/bash

# Watch for changes and run tests
while true; do
    # Wait for file changes
    inotifywait -r -e modify,create,delete src/ test/

    # Clear screen
    clear
    echo "Running tests..."

    # Run tests
    ant test

    echo "Waiting for changes..."
done
```

---

### 9.9 Test Best Practices

**General Testing Principles**

1. **Test Isolation**
   - Each test should be independent
   - Use `@Before` and `@After` for setup/cleanup
   - Never rely on test execution order

2. **Test Naming**
   - Use descriptive names: `testMethodName_Scenario_ExpectedBehavior`
   - Example: `testSaveUser_WithValidData_SavesSuccessfully`

3. **AAA Pattern**
   - **Arrange**: Set up test data and conditions
   - **Act**: Execute the code being tested
   - **Assert**: Verify the results

4. **One Assertion Per Test** (when possible)
   - Focus each test on a single behavior
   - Makes failures easier to diagnose

**DAO Testing Checklist**

- [ ] Test all CRUD operations
- [ ] Test finder methods with valid/invalid input
- [ ] Test constraint violations (unique, foreign key)
- [ ] Test transaction rollback
- [ ] Test lazy loading behavior
- [ ] Test cascade operations

**Action Testing Checklist**

- [ ] Test all action methods
- [ ] Test request parameter handling
- [ ] Test session attribute management
- [ ] Test forwarding logic
- [ ] Test error handling
- [ ] Test authorization checks

**Form Validation Checklist**

- [ ] Test required fields
- [ ] Test format validation (email, phone, etc.)
- [ ] Test length constraints
- [ ] Test numeric ranges
- [ ] Test password confirmation
- [ ] Test custom business rules

**Common Testing Pitfalls**

1. **Database State Issues**
   - Problem: Tests fail due to leftover data
   - Solution: Always clean database in `@After`

2. **Transaction Management**
   - Problem: Changes not visible in assertions
   - Solution: Call `session.flush()` and `session.clear()`

3. **Mock Object Complexity**
   - Problem: Mocks become too complex
   - Solution: Use real objects for integration tests

4. **Test Data Coupling**
   - Problem: Tests depend on specific IDs
   - Solution: Use test data builders or fixtures

---

## 10. Debugging and Troubleshooting

### 10.1 Debugging Setup in VS Code

**Java Debugging Configuration**

Create `.vscode/launch.json`:
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "java",
            "name": "Debug (Attach) - Tomcat",
            "request": "attach",
            "hostName": "localhost",
            "port": 8000,
            "timeout": 30000,
            "sourcePaths": [
                "${workspaceFolder}/src/main/java"
            ]
        },
        {
            "type": "java",
            "name": "Debug Current Test",
            "request": "launch",
            "mainClass": "org.junit.runner.JUnitCore",
            "args": "${file}",
            "classPaths": [
                "${workspaceFolder}/build/classes",
                "${workspaceFolder}/build/test-classes",
                "${workspaceFolder}/lib/**/*.jar"
            ],
            "console": "integratedTerminal"
        }
    ]
}
```

**Enable Remote Debugging in Tomcat**

Add to `tomcat/bin/setenv.sh`:
```bash
#!/bin/bash

# Enable remote debugging on port 8000
export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n"

# Optional: Increase memory for debugging
export CATALINA_OPTS="$CATALINA_OPTS -Xms256m -Xmx512m"

# Enable JMX monitoring (optional)
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.port=9999"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.ssl=false"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
```

Make executable:
```bash
chmod +x tomcat/bin/setenv.sh
```

**Start Tomcat in Debug Mode**

```bash
# Restart Tomcat to apply debug settings
tomcat/bin/shutdown.sh
tomcat/bin/startup.sh

# Verify debug port is listening
netstat -an | grep 8000
```

**Attach Debugger**

1. Set breakpoints in VS Code (click left margin of code)
2. Open Run and Debug panel (Ctrl+Shift+D)
3. Select "Debug (Attach) - Tomcat"
4. Click Start Debugging (F5)
5. Navigate to your application in browser
6. Debugger will pause at breakpoints

---

### 10.2 Logging Configuration

**Log4j Setup**

Add to `lib/`:
```
log4j-1.2.17.jar
```

**log4j.properties Configuration**

`src/main/resources/log4j.properties`:
```properties
# Root logger option
log4j.rootLogger=INFO, stdout, file

# Direct log messages to console
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.Target=System.out
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n

# Direct log messages to file
log4j.appender.file=org.apache.log4j.RollingFileAppender
log4j.appender.file.File=${catalina.base}/logs/application.log
log4j.appender.file.MaxFileSize=10MB
log4j.appender.file.MaxBackupIndex=10
log4j.appender.file.layout=org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n

# Application package logging levels
log4j.logger.com.example=DEBUG
log4j.logger.com.example.dao=DEBUG
log4j.logger.com.example.action=DEBUG

# Hibernate logging
log4j.logger.org.hibernate=WARN
log4j.logger.org.hibernate.SQL=DEBUG
log4j.logger.org.hibernate.type=TRACE
log4j.logger.org.hibernate.engine.QueryParameters=DEBUG
log4j.logger.org.hibernate.engine.query.HQLQueryPlan=DEBUG

# Struts logging
log4j.logger.org.apache.struts=WARN
log4j.logger.org.apache.struts.action=INFO

# Connection pool logging
log4j.logger.com.mchange.v2.c3p0=WARN

# Spring logging (if using Spring)
log4j.logger.org.springframework=WARN

# SQL statement logging (alternative to Hibernate's)
log4j.logger.java.sql=DEBUG
log4j.logger.java.sql.Connection=DEBUG
log4j.logger.java.sql.Statement=DEBUG
log4j.logger.java.sql.PreparedStatement=DEBUG
log4j.logger.java.sql.ResultSet=DEBUG
```

**Logger Usage in Code**

Add to classes that need logging:
```java
package com.example.dao.impl;

import org.apache.log4j.Logger;

public class UserDAOImpl implements UserDAO {

    private static final Logger logger = Logger.getLogger(UserDAOImpl.class);

    public User findById(Long id) {
        logger.debug("Finding user by id: " + id);

        try {
            User user = (User) session.get(User.class, id);

            if (user != null) {
                logger.info("Found user: " + user.getUsername());
            } else {
                logger.warn("User not found with id: " + id);
            }

            return user;
        } catch (Exception e) {
            logger.error("Error finding user by id: " + id, e);
            throw new RuntimeException("Failed to find user", e);
        }
    }

    public void save(User user) {
        logger.debug("Saving user: " + user.getUsername());

        try {
            session.save(user);
            logger.info("Successfully saved user: " + user.getUsername() +
                       " with id: " + user.getId());
        } catch (Exception e) {
            logger.error("Error saving user: " + user.getUsername(), e);
            throw new RuntimeException("Failed to save user", e);
        }
    }
}
```

**Logging Levels Guide**

```java
// TRACE - Very detailed information (rarely used)
logger.trace("Entering method with params: " + params);

// DEBUG - Detailed information for debugging
logger.debug("Query returned " + results.size() + " results");

// INFO - Important business process information
logger.info("User logged in: " + username);

// WARN - Warning messages for potential issues
logger.warn("Connection pool near capacity: " + poolSize);

// ERROR - Error events but application can continue
logger.error("Failed to send email notification", exception);

// FATAL - Severe errors causing application to abort
logger.fatal("Database connection pool exhausted", exception);
```

---

### 10.3 Common Errors and Solutions

#### **Error 1: ClassNotFoundException**

**Symptom:**
```
java.lang.ClassNotFoundException: com.mysql.jdbc.Driver
```

**Causes:**
- JDBC driver not in `WEB-INF/lib/`
- Build process not copying JARs to WAR

**Solutions:**
```bash
# 1. Verify JAR exists
ls -la lib/mysql-connector-java-5.1.49.jar

# 2. Check WAR contains JAR
jar tf build/war/MyApp.war | grep mysql-connector

# 3. Rebuild with clean
ant clean build-war

# 4. Manually copy if needed
cp lib/mysql-connector-java-5.1.49.jar build/war/WEB-INF/lib/
```

---

#### **Error 2: Hibernate SessionFactory Initialization Failed**

**Symptom:**
```
org.hibernate.HibernateException: Could not parse configuration
```

**Common Causes:**

1. **Invalid hibernate.cfg.xml syntax**
   ```bash
   # Validate XML
   xmllint --noout src/main/resources/hibernate.cfg.xml
   ```

2. **Mapping file not found**
   ```xml
   <!-- Check mapping path in hibernate.cfg.xml -->
   <mapping resource="com/example/model/User.hbm.xml"/>
   ```

   ```bash
   # Verify mapping file exists
   ls -la src/main/resources/com/example/model/User.hbm.xml
   ```

3. **Database connection failure**
   ```bash
   # Test MySQL connection
   mysql -h localhost -u myapp_user -p myapp_db

   # Check MySQL is running
   systemctl status mysql
   ```

**Debug Steps:**
```java
// Add detailed logging in HibernateUtil
public class HibernateUtil {
    private static SessionFactory sessionFactory;
    private static final Logger logger = Logger.getLogger(HibernateUtil.class);

    static {
        try {
            logger.info("Initializing Hibernate SessionFactory...");

            Configuration config = new Configuration();
            logger.debug("Loading hibernate.cfg.xml");
            config.configure();

            logger.debug("Building SessionFactory");
            sessionFactory = config.buildSessionFactory();

            logger.info("SessionFactory initialized successfully");
        } catch (Exception e) {
            logger.fatal("Failed to create SessionFactory", e);
            throw new ExceptionInInitializerError(e);
        }
    }
}
```

---

#### **Error 3: LazyInitializationException**

**Symptom:**
```
org.hibernate.LazyInitializationException: could not initialize proxy - no Session
```

**Explanation:**
Attempting to access lazy-loaded collection after session is closed.

**Example of Problem:**
```java
// In Action
public ActionForward execute(...) {
    User user = userDAO.findById(1L);
    // Session closed here

    List orders = user.getOrders(); // LazyInitializationException!
}
```

**Solution 1: Eager Fetch**
```xml
<!-- In User.hbm.xml -->
<set name="orders" lazy="false" fetch="join">
    <key column="user_id"/>
    <one-to-many class="com.example.model.Order"/>
</set>
```

**Solution 2: Initialize in DAO**
```java
public User findByIdWithOrders(Long id) {
    User user = (User) session.get(User.class, id);
    if (user != null) {
        Hibernate.initialize(user.getOrders()); // Force load
    }
    return user;
}
```

**Solution 3: Open Session in View Filter**
```java
public class OpenSessionInViewFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            chain.doFilter(request, response);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }
}
```

Register in `web.xml`:
```xml
<filter>
    <filter-name>OpenSessionInViewFilter</filter-name>
    <filter-class>com.example.filter.OpenSessionInViewFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>OpenSessionInViewFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

---

#### **Error 4: Struts ActionForm Not Populated**

**Symptom:**
Form fields are null in Action, even though request contains parameters.

**Common Causes:**

1. **Form property names don't match HTML input names**
   ```jsp
   <!-- HTML input name must match form property -->
   <html:text property="username"/>  <!-- Correct -->
   <input name="user_name"/>         <!-- Won't work -->
   ```

2. **Missing getter/setter methods**
   ```java
   public class UserForm extends ActionForm {
       private String username;

       // Must have BOTH
       public String getUsername() { return username; }
       public void setUsername(String username) { this.username = username; }
   }
   ```

3. **Form not in struts-config.xml**
   ```xml
   <form-beans>
       <form-bean name="userForm" type="com.example.form.UserForm"/>
   </form-beans>
   ```

**Debug Steps:**
```java
public ActionForward execute(ActionMapping mapping, ActionForm form,
                           HttpServletRequest request,
                           HttpServletResponse response) {

    // Log request parameters
    logger.debug("Request parameters:");
    Enumeration paramNames = request.getParameterNames();
    while (paramNames.hasMoreElements()) {
        String paramName = (String) paramNames.nextElement();
        String paramValue = request.getParameter(paramName);
        logger.debug("  " + paramName + " = " + paramValue);
    }

    // Log form values
    UserForm userForm = (UserForm) form;
    logger.debug("Form username: " + userForm.getUsername());
    logger.debug("Form email: " + userForm.getEmail());

    // Continue processing...
}
```

---

#### **Error 5: Database Connection Pool Exhausted**

**Symptom:**
```
java.sql.SQLException: Timeout: Pool empty. Unable to fetch a connection
```

**Causes:**
- Connections not being closed
- Pool size too small for load
- Long-running transactions

**Debug: Find Connection Leaks**
```java
// Add to HibernateUtil
private static final Map activeConnections = new HashMap();

public static Session openSession() {
    Session session = sessionFactory.openSession();

    // Track where session was opened
    Exception stackTrace = new Exception("Session opened here");
    activeConnections.put(session, stackTrace);

    logger.debug("Opened session. Active count: " + activeConnections.size());

    return session;
}

public static void closeSession(Session session) {
    if (session != null && session.isOpen()) {
        activeConnections.remove(session);
        session.close();
        logger.debug("Closed session. Active count: " + activeConnections.size());
    }
}

// Scheduled task to report leaks
public static void reportOpenSessions() {
    if (activeConnections.size() > 0) {
        logger.warn("Found " + activeConnections.size() + " unclosed sessions:");
        for (Map.Entry entry : activeConnections.entrySet()) {
            Exception trace = (Exception) entry.getValue();
            logger.warn("Session opened at:", trace);
        }
    }
}
```

**Solutions:**

1. **Always use try-finally**
   ```java
   Session session = null;
   try {
       session = HibernateUtil.openSession();
       // ... work ...
   } finally {
       if (session != null) {
           session.close();
       }
   }
   ```

2. **Increase pool size**
   ```xml
   <!-- In hibernate.cfg.xml -->
   <property name="connection.pool_size">20</property>

   <!-- Or with C3P0 -->
   <property name="c3p0.min_size">5</property>
   <property name="c3p0.max_size">50</property>
   <property name="c3p0.timeout">300</property>
   ```

3. **Add connection validation**
   ```xml
   <property name="c3p0.testConnectionOnCheckout">true</property>
   <property name="c3p0.preferredTestQuery">SELECT 1</property>
   ```

---

#### **Error 6: Character Encoding Issues**

**Symptom:**
Japanese/Chinese/special characters display as "???" or garbled text.

**Solution: Comprehensive UTF-8 Setup**

1. **Database Level**
   ```sql
   ALTER DATABASE myapp_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ALTER TABLE users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

2. **JDBC Connection**
   ```xml
   <!-- In hibernate.cfg.xml -->
   <property name="connection.url">
       jdbc:mysql://localhost:3306/myapp_db?useUnicode=true&amp;characterEncoding=UTF-8
   </property>
   ```

3. **JSP Pages**
   ```jsp
   <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   ```

4. **Encoding Filter**
   ```java
   public class CharacterEncodingFilter implements Filter {

       public void doFilter(ServletRequest request, ServletResponse response,
                          FilterChain chain) throws IOException, ServletException {

           request.setCharacterEncoding("UTF-8");
           response.setCharacterEncoding("UTF-8");
           response.setContentType("text/html; charset=UTF-8");

           chain.doFilter(request, response);
       }
   }
   ```

   ```xml
   <!-- In web.xml - MUST be first filter -->
   <filter>
       <filter-name>encodingFilter</filter-name>
       <filter-class>com.example.filter.CharacterEncodingFilter</filter-class>
   </filter>
   <filter-mapping>
       <filter-name>encodingFilter</filter-name>
       <url-pattern>/*</url-pattern>
   </filter-mapping>
   ```

5. **Tomcat Connector**
   ```xml
   <!-- In tomcat/conf/server.xml -->
   <Connector port="8080"
              URIEncoding="UTF-8"
              useBodyEncodingForURI="true"/>
   ```

---

#### **Error 7: Transaction Not Active**

**Symptom:**
```
org.hibernate.TransactionException: Transaction not successfully started
```

**Causes:**
- Trying to commit/rollback without beginning transaction
- Session management issues

**Correct Transaction Pattern:**
```java
Session session = null;
Transaction tx = null;

try {
    session = HibernateUtil.openSession();
    tx = session.beginTransaction();

    // Do work
    userDAO.save(user);

    tx.commit();
    logger.info("Transaction committed successfully");

} catch (Exception e) {
    if (tx != null && tx.isActive()) {
        logger.error("Rolling back transaction", e);
        tx.rollback();
    }
    throw e;

} finally {
    if (session != null && session.isOpen()) {
        session.close();
    }
}
```

**Service Layer Transaction Management:**
```java
public class UserService {
    private UserDAO userDAO = new UserDAOImpl();

    public void registerUser(User user) {
        Session session = null;
        Transaction tx = null;

        try {
            session = HibernateUtil.openSession();
            tx = session.beginTransaction();

            ((UserDAOImpl) userDAO).setSession(session);

            // Business logic
            userDAO.save(user);
            // Send email, etc.

            tx.commit();

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new ServiceException("User registration failed", e);
        } finally {
            if (session != null) session.close();
        }
    }
}
```

---

### 10.4 Debugging Tools

#### **SQL Logging and Analysis**

**Enable P6Spy for SQL Logging**

Add to `lib/`:
```
p6spy-1.3.jar
```

`spy.properties`:
```properties
# P6Spy configuration
module.log=com.p6spy.engine.logging.P6LogFactory
module.outage=com.p6spy.engine.outage.P6OutageFactory

# Log file location
logfile=logs/spy.log

# Append to log
append=true

# Log categories (error, info, batch, debug, statement, commit, rollback, result)
includecategories=statement,error,batch

# Exclude categories
excludecategories=info,debug,result,commit,rollback

# Date format
dateformat=yyyy-MM-dd HH:mm:ss

# Log format
# Options: single line, multi line, custom
logMessageFormat=com.p6spy.engine.spy.appender.SingleLineFormat

# Actual driver
realdriver=com.mysql.jdbc.Driver
```

Update JDBC driver in `hibernate.cfg.xml`:
```xml
<property name="connection.driver_class">com.p6spy.engine.spy.P6SpyDriver</property>
<property name="connection.url">jdbc:mysql://localhost:3306/myapp_db</property>
```

**View SQL with Execution Time:**
```
1638360145123|12|statement|select user0_.id as id0_0_ from users user0_ where user0_.id=1
1638360145156|33|statement|update users set username='newname' where id=1
```

---

#### **Hibernate Statistics**

**Enable Statistics:**
```xml
<!-- In hibernate.cfg.xml -->
<property name="hibernate.generate_statistics">true</property>
```

**Log Statistics:**
```java
public class HibernateStatsLogger {
    private static final Logger logger = Logger.getLogger(HibernateStatsLogger.class);

    public static void logStatistics() {
        Statistics stats = HibernateUtil.getSessionFactory().getStatistics();

        logger.info("Hibernate Statistics:");
        logger.info("  Sessions opened: " + stats.getSessionOpenCount());
        logger.info("  Sessions closed: " + stats.getSessionCloseCount());
        logger.info("  Transactions: " + stats.getTransactionCount());
        logger.info("  Successful transactions: " + stats.getSuccessfulTransactionCount());
        logger.info("  Entities loaded: " + stats.getEntityLoadCount());
        logger.info("  Entities updated: " + stats.getEntityUpdateCount());
        logger.info("  Entities inserted: " + stats.getEntityInsertCount());
        logger.info("  Entities deleted: " + stats.getEntityDeleteCount());
        logger.info("  Collections loaded: " + stats.getCollectionLoadCount());
        logger.info("  Queries executed: " + stats.getQueryExecutionCount());
        logger.info("  Query cache hits: " + stats.getQueryCacheHitCount());
        logger.info("  Query cache misses: " + stats.getQueryCacheMissCount());
        logger.info("  Second level cache hits: " + stats.getSecondLevelCacheHitCount());
        logger.info("  Second level cache misses: " + stats.getSecondLevelCacheMissCount());
    }

    public static void logQueryStatistics(String query) {
        Statistics stats = HibernateUtil.getSessionFactory().getStatistics();
        QueryStatistics queryStats = stats.getQueryStatistics(query);

        if (queryStats != null) {
            logger.info("Query Statistics for: " + query);
            logger.info("  Execution count: " + queryStats.getExecutionCount());
            logger.info("  Rows fetched: " + queryStats.getExecutionRowCount());
            logger.info("  Avg time (ms): " + queryStats.getExecutionAvgTime());
            logger.info("  Max time (ms): " + queryStats.getExecutionMaxTime());
            logger.info("  Min time (ms): " + queryStats.getExecutionMinTime());
        }
    }
}
```

**Add Statistics Servlet:**
```java
public class StatsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Statistics stats = HibernateUtil.getSessionFactory().getStatistics();

        out.println("<html><head><title>Hibernate Statistics</title></head><body>");
        out.println("<h1>Hibernate Statistics</h1>");
        out.println("<table border='1'>");
        out.println("<tr><th>Metric</th><th>Value</th></tr>");

        out.println("<tr><td>Sessions Opened</td><td>" + stats.getSessionOpenCount() + "</td></tr>");
        out.println("<tr><td>Sessions Closed</td><td>" + stats.getSessionCloseCount() + "</td></tr>");
        out.println("<tr><td>Transactions</td><td>" + stats.getTransactionCount() + "</td></tr>");
        out.println("<tr><td>Entities Loaded</td><td>" + stats.getEntityLoadCount() + "</td></tr>");
        out.println("<tr><td>Queries Executed</td><td>" + stats.getQueryExecutionCount() + "</td></tr>");

        // Query details
        String[] queries = stats.getQueries();
        out.println("<tr><td colspan='2'><h2>Query Statistics</h2></td></tr>");
        for (String query : queries) {
            QueryStatistics qs = stats.getQueryStatistics(query);
            out.println("<tr><td>" + query + "</td><td>");
            out.println("Count: " + qs.getExecutionCount() + "<br/>");
            out.println("Avg Time: " + qs.getExecutionAvgTime() + "ms");
            out.println("</td></tr>");
        }

        out.println("</table>");
        out.println("<p><a href='?clear=true'>Clear Statistics</a></p>");
        out.println("</body></html>");

        if ("true".equals(request.getParameter("clear"))) {
            stats.clear();
        }
    }
}
```

---

#### **JConsole/VisualVM Monitoring**

**Connect to Tomcat JVM:**

1. **Start with JMX enabled** (already in setenv.sh)
2. **Launch JConsole:**
   ```bash
   jconsole localhost:9999
   ```

3. **Monitor:**
   - Memory usage (heap/non-heap)
   - Thread count and states
   - CPU usage
   - Loaded classes

**Create MBeans for Custom Monitoring:**
```java
public interface ApplicationStatsMBean {
    int getActiveUsers();
    long getTotalRequests();
    long getAverageResponseTime();
}

public class ApplicationStats implements ApplicationStatsMBean {
    private AtomicInteger activeUsers = new AtomicInteger(0);
    private AtomicLong totalRequests = new AtomicLong(0);

    public int getActiveUsers() {
        return activeUsers.get();
    }

    public long getTotalRequests() {
        return totalRequests.get();
    }

    public long getAverageResponseTime() {
        // Calculate from stored metrics
        return 0;
    }

    // Register MBean
    public static void registerMBean() {
        try {
            MBeanServer mbs = ManagementFactory.getPlatformMBeanServer();
            ObjectName name = new ObjectName("com.example:type=ApplicationStats");
            ApplicationStats mbean = new ApplicationStats();
            mbs.registerMBean(mbean, name);
        } catch (Exception e) {
            logger.error("Failed to register MBean", e);
        }
    }
}
```

---

### 10.5 Troubleshooting Checklist

**Application Won't Start**

- [ ] Check Tomcat logs: `tail -f tomcat/logs/catalina.out`
- [ ] Verify MySQL is running: `systemctl status mysql`
- [ ] Check port 8080 is available: `netstat -an | grep 8080`
- [ ] Verify all JARs are in `WEB-INF/lib/`
- [ ] Check `hibernate.cfg.xml` is in classpath
- [ ] Validate XML configuration files

**Database Issues**

- [ ] Test database connection: `mysql -u user -p database`
- [ ] Check Hibernate SQL output in logs
- [ ] Verify mapping files are correct
- [ ] Check database user permissions
- [ ] Review connection pool configuration
- [ ] Look for constraint violations in logs

**Struts Issues**

- [ ] Verify `struts-config.xml` is valid
- [ ] Check action path mapping
- [ ] Verify form bean configuration
- [ ] Check JSP tag library declarations
- [ ] Review request parameter names
- [ ] Check ActionForm getter/setter methods

**Performance Issues**

- [ ] Enable Hibernate SQL logging
- [ ] Check for N+1 query problems
- [ ] Review connection pool size
- [ ] Monitor memory usage in JConsole
- [ ] Check for lazy loading exceptions
- [ ] Review query execution plans

**Memory Leaks**

- [ ] Monitor heap usage over time
- [ ] Check for unclosed connections
- [ ] Review static collections
- [ ] Check for circular references
- [ ] Use heap dump analysis
- [ ] Monitor thread count

---

### 10.6 Emergency Debugging Commands

**Quick Log Checks**

```bash
# Real-time Tomcat logs
tail -f tomcat/logs/catalina.out

# Application logs
tail -f tomcat/logs/application.log

# Search for errors
grep -i "error\|exception" tomcat/logs/catalina.out | tail -20

# Find stack traces
grep -A 20 "Exception" tomcat/logs/catalina.out

# Monitor access log
tail -f tomcat/logs/localhost_access_log.2024-10-12.txt
```

**Database Quick Checks**

```bash
# Active connections
mysql -u root -p -e "SHOW PROCESSLIST;"

# Table status
mysql -u root -p myapp_db -e "SHOW TABLE STATUS;"

# Check slow queries
mysql -u root -p -e "SHOW VARIABLES LIKE 'slow_query%';"

# Current queries
mysql -u root -p -e "SELECT * FROM information_schema.PROCESSLIST WHERE COMMAND != 'Sleep';"
```

**System Resource Checks**

```bash
# Memory usage
free -h

# Disk space
df -h

# Process CPU/Memory
top -p $(pgrep -f tomcat)

# Open files by Tomcat
lsof -p $(pgrep -f tomcat) | wc -l

# Network connections
netstat -an | grep ESTABLISHED | grep 8080
```

**Heap Dump on OutOfMemoryError**

Add to Tomcat's `setenv.sh`:
```bash
export CATALINA_OPTS="$CATALINA_OPTS -XX:+HeapDumpOnOutOfMemoryError"
export CATALINA_OPTS="$CATALINA_OPTS -XX:HeapDumpPath=/tmp/heapdump.hprof"
```

**Analyze Heap Dump:**
```bash
# Use jhat (built into JDK)
jhat /tmp/heapdump.hprof

# Access via browser
open http://localhost:7000
```

---

## 11. Performance Optimization

### 11.1 Database Performance Optimization

#### **Query Optimization**

**Problem: N+1 Query**

Bad approach (generates N+1 queries):
```java
// Action method - generates 1 query for users + N queries for orders
List users = userDAO.findAll(); // 1 query

for (Iterator it = users.iterator(); it.hasNext(); ) {
    User user = (User) it.next();
    List orders = user.getOrders(); // N queries (lazy load)
    // Process orders...
}
```

**Solution 1: Fetch Join in HQL**
```java
public List findAllWithOrders() {
    String hql = "FROM User u LEFT JOIN FETCH u.orders";
    Query query = session.createQuery(hql);
    return query.list(); // Single query with JOIN
}
```

**Solution 2: Criteria API with Fetch**
```java
public List findAllWithOrders() {
    Criteria criteria = session.createCriteria(User.class);
    criteria.setFetchMode("orders", FetchMode.JOIN);
    criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
    return criteria.list();
}
```

**Solution 3: Batch Fetching**
```xml
<!-- In User.hbm.xml -->
<class name="com.example.model.User" table="users" batch-size="10">
    <set name="orders" batch-size="10">
        <key column="user_id"/>
        <one-to-many class="com.example.model.Order"/>
    </set>
</class>
```

---

#### **Connection Pool Optimization**

**C3P0 Production Configuration**

Replace basic pool with C3P0 in `hibernate.cfg.xml`:
```xml
<!-- Remove default pool_size -->
<!-- <property name="connection.pool_size">10</property> -->

<!-- C3P0 Connection Pool -->
<property name="hibernate.connection.provider_class">
    org.hibernate.connection.C3P0ConnectionProvider
</property>

<!-- Pool Size Settings -->
<property name="c3p0.min_size">5</property>
<property name="c3p0.max_size">50</property>
<property name="c3p0.timeout">1800</property>
<property name="c3p0.max_statements">100</property>

<!-- Connection Testing -->
<property name="c3p0.idle_test_period">3000</property>
<property name="c3p0.testConnectionOnCheckout">true</property>
<property name="c3p0.preferredTestQuery">SELECT 1</property>

<!-- Connection Aging -->
<property name="c3p0.maxIdleTime">1800</property>
<property name="c3p0.maxConnectionAge">3600</property>

<!-- Statement Caching -->
<property name="c3p0.maxStatementsPerConnection">20</property>

<!-- Acquire Settings -->
<property name="c3p0.acquireIncrement">3</property>
<property name="c3p0.acquireRetryAttempts">30</property>
<property name="c3p0.acquireRetryDelay">1000</property>

<!-- Debug -->
<property name="c3p0.debugUnreturnedConnectionStackTraces">true</property>
<property name="c3p0.unreturnedConnectionTimeout">300</property>
```

Add C3P0 library:
```bash
# Download C3P0
wget https://repo1.maven.org/maven2/c3p0/c3p0/0.9.1.2/c3p0-0.9.1.2.jar -P lib/
```

---

#### **Query Caching**

**Enable Second-Level Cache**

Add EHCache dependency to `lib/`:
```
ehcache-core-2.4.3.jar
hibernate-ehcache-3.6.10.Final.jar
```

Configure in `hibernate.cfg.xml`:
```xml
<!-- Enable second-level cache -->
<property name="hibernate.cache.use_second_level_cache">true</property>
<property name="hibernate.cache.use_query_cache">true</property>
<property name="hibernate.cache.region.factory_class">
    org.hibernate.cache.ehcache.EhCacheRegionFactory
</property>
<property name="hibernate.cache.provider_class">
    org.hibernate.cache.EhCacheProvider
</property>
```

**EHCache Configuration**

`src/main/resources/ehcache.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="ehcache.xsd"
         updateCheck="false">

    <!-- Default cache settings -->
    <defaultCache
        maxElementsInMemory="10000"
        eternal="false"
        timeToIdleSeconds="120"
        timeToLiveSeconds="120"
        overflowToDisk="true"
        maxElementsOnDisk="10000000"
        diskPersistent="false"
        diskExpiryThreadIntervalSeconds="120"
        memoryStoreEvictionPolicy="LRU"/>

    <!-- User entity cache -->
    <cache name="com.example.model.User"
           maxElementsInMemory="1000"
           eternal="false"
           timeToIdleSeconds="300"
           timeToLiveSeconds="600"
           overflowToDisk="false"
           memoryStoreEvictionPolicy="LRU"/>

    <!-- User collections cache -->
    <cache name="com.example.model.User.orders"
           maxElementsInMemory="1000"
           eternal="false"
           timeToIdleSeconds="300"
           timeToLiveSeconds="600"
           overflowToDisk="false"
           memoryStoreEvictionPolicy="LRU"/>

    <!-- Query cache -->
    <cache name="org.hibernate.cache.StandardQueryCache"
           maxElementsInMemory="500"
           eternal="false"
           timeToLiveSeconds="120"
           overflowToDisk="false"
           memoryStoreEvictionPolicy="LRU"/>

    <!-- Query timestamp cache -->
    <cache name="org.hibernate.cache.UpdateTimestampsCache"
           maxElementsInMemory="5000"
           eternal="true"
           overflowToDisk="false"/>
</ehcache>
```

**Enable Caching on Entities**

Update `User.hbm.xml`:
```xml
<class name="com.example.model.User"
       table="users"
       batch-size="10">

    <!-- Enable second-level cache for this entity -->
    <cache usage="read-write"/>

    <id name="id" column="id">
        <generator class="native"/>
    </id>

    <!-- Cache collection -->
    <set name="orders" lazy="true" batch-size="10">
        <cache usage="read-write"/>
        <key column="user_id"/>
        <one-to-many class="com.example.model.Order"/>
    </set>
</class>
```

**Use Query Cache**

```java
public List findActiveUsers() {
    String hql = "FROM User u WHERE u.active = true";
    Query query = session.createQuery(hql);

    // Enable query cache for this query
    query.setCacheable(true);
    query.setCacheRegion("activeUsersQuery");

    return query.list();
}
```

**Cache Statistics**

```java
public void logCacheStats() {
    Statistics stats = sessionFactory.getStatistics();

    logger.info("=== Cache Statistics ===");
    logger.info("Second Level Hit Count: " + stats.getSecondLevelCacheHitCount());
    logger.info("Second Level Miss Count: " + stats.getSecondLevelCacheMissCount());
    logger.info("Second Level Put Count: " + stats.getSecondLevelCachePutCount());
    logger.info("Query Cache Hit Count: " + stats.getQueryCacheHitCount());
    logger.info("Query Cache Miss Count: " + stats.getQueryCacheMissCount());
    logger.info("Query Cache Put Count: " + stats.getQueryCachePutCount());

    // Entity cache stats
    String[] entityNames = stats.getSecondLevelCacheRegionNames();
    for (String entityName : entityNames) {
        SecondLevelCacheStatistics entityStats =
            stats.getSecondLevelCacheStatistics(entityName);
        logger.info("Entity: " + entityName);
        logger.info("  Hit Count: " + entityStats.getHitCount());
        logger.info("  Miss Count: " + entityStats.getMissCount());
        logger.info("  Size In Memory: " + entityStats.getSizeInMemory());
    }
}
```

---

#### **Database Indexing**

**Identify Missing Indexes**

```sql
-- Check slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1; -- queries taking > 1 second

-- Analyze queries
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- Look for:
-- - type: ALL (full table scan - bad)
-- - type: index (index scan - better)
-- - type: ref or eq_ref (using index - best)
```

**Add Indexes**

```sql
-- Frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_active ON users(active);

-- Composite index for common queries
CREATE INDEX idx_users_active_created ON users(active, created_date);

-- Foreign keys
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);

-- Check index usage
SHOW INDEX FROM users;

-- Analyze table
ANALYZE TABLE users;
```

**Index Best Practices**

1. **Index Foreign Keys**
   ```sql
   CREATE INDEX idx_fk_user_id ON orders(user_id);
   ```

2. **Index WHERE Clause Columns**
   ```sql
   -- Query: SELECT * FROM users WHERE active = 1 AND created_date > '2024-01-01'
   CREATE INDEX idx_active_created ON users(active, created_date);
   ```

3. **Avoid Over-Indexing**
   - Each index slows down INSERT/UPDATE/DELETE
   - Monitor index usage:
   ```sql
   SELECT * FROM information_schema.STATISTICS
   WHERE table_name = 'users';
   ```

---

#### **Database Query Optimization**

**Use LIMIT for Pagination**

Bad:
```java
// Loads all records into memory
List users = session.createQuery("FROM User").list();
// Display first 10
```

Good:
```java
// Only loads 10 records
Query query = session.createQuery("FROM User");
query.setFirstResult(0);
query.setMaxResults(10);
List users = query.list();
```

**Pagination Helper**

```java
public class PaginationHelper {

    public static List getPaginatedResults(Session session,
                                           String hql,
                                           int pageNumber,
                                           int pageSize) {
        Query query = session.createQuery(hql);
        query.setFirstResult((pageNumber - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.list();
    }

    public static long getTotalCount(Session session, String entityName) {
        String hql = "SELECT COUNT(*) FROM " + entityName;
        Long count = (Long) session.createQuery(hql).uniqueResult();
        return count != null ? count.longValue() : 0;
    }
}

// Usage
int pageNumber = 1;
int pageSize = 20;
List users = PaginationHelper.getPaginatedResults(
    session, "FROM User ORDER BY createdDate DESC", pageNumber, pageSize
);
long total = PaginationHelper.getTotalCount(session, "User");
int totalPages = (int) Math.ceil((double) total / pageSize);
```

**Use Projections for Reporting**

Bad (loads entire entity):
```java
List users = session.createQuery("FROM User").list();
for (Iterator it = users.iterator(); it.hasNext(); ) {
    User user = (User) it.next();
    System.out.println(user.getUsername()); // Only need username
}
```

Good (only select needed columns):
```java
String hql = "SELECT u.id, u.username FROM User u";
List results = session.createQuery(hql).list();
for (Iterator it = results.iterator(); it.hasNext(); ) {
    Object[] row = (Object[]) it.next();
    Long id = (Long) row[0];
    String username = (String) row[1];
    System.out.println(username);
}
```

**Criteria API Projections**

```java
public List getUsernameList() {
    Criteria criteria = session.createCriteria(User.class);
    criteria.setProjection(Projections.property("username"));
    return criteria.list();
}

public List getUserSummary() {
    Criteria criteria = session.createCriteria(User.class);

    ProjectionList projList = Projections.projectionList();
    projList.add(Projections.property("id"), "id");
    projList.add(Projections.property("username"), "username");
    projList.add(Projections.property("email"), "email");

    criteria.setProjection(projList);
    criteria.setResultTransformer(Transformers.aliasToBean(UserSummaryDTO.class));

    return criteria.list();
}
```

---

### 11.2 Application Performance Optimization

#### **Session Management**

**ThreadLocal Session Pattern**

Update `HibernateUtil.java`:
```java
public class HibernateUtil {

    private static final SessionFactory sessionFactory;
    private static final ThreadLocal threadLocal = new ThreadLocal();

    static {
        try {
            Configuration config = new Configuration();
            config.configure();
            sessionFactory = config.buildSessionFactory();
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public static Session getSession() {
        Session session = (Session) threadLocal.get();

        if (session == null || !session.isOpen()) {
            session = sessionFactory.openSession();
            threadLocal.set(session);
        }

        return session;
    }

    public static void closeSession() {
        Session session = (Session) threadLocal.get();
        threadLocal.set(null);

        if (session != null && session.isOpen()) {
            session.close();
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        sessionFactory.close();
    }
}
```

**Request-Scoped Session with Filter**

```java
public class HibernateSessionFilter implements Filter {

    private static final Logger logger = Logger.getLogger(HibernateSessionFilter.class);

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        Session session = null;

        try {
            // Open session at start of request
            session = HibernateUtil.getSession();
            session.beginTransaction();

            logger.debug("Opened Hibernate session for request");

            // Process request
            chain.doFilter(request, response);

            // Commit transaction if still active
            if (session.getTransaction().isActive()) {
                session.getTransaction().commit();
                logger.debug("Committed transaction");
            }

        } catch (Exception e) {
            // Rollback on error
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
                logger.error("Rolled back transaction due to error", e);
            }
            throw new ServletException(e);

        } finally {
            // Always close session
            HibernateUtil.closeSession();
            logger.debug("Closed Hibernate session");
        }
    }

    public void init(FilterConfig config) throws ServletException {}
    public void destroy() {}
}
```

Register in `web.xml`:
```xml
<filter>
    <filter-name>hibernateFilter</filter-name>
    <filter-class>com.example.filter.HibernateSessionFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>hibernateFilter</filter-name>
    <url-pattern>*.do</url-pattern>
</filter-mapping>
```

---

#### **DTO Pattern for Performance**

**Problem: Passing Hibernate Entities to View**

```java
// Bad - entity with lazy collections passed to JSP
public ActionForward execute(...) {
    User user = userDAO.findById(1L);
    request.setAttribute("user", user);
    return mapping.findForward("success");
}
```

JSP might trigger lazy loading:
```jsp
<!-- Each access might hit database -->
<c:forEach items="${user.orders}" var="order">
    ${order.total}
</c:forEach>
```

**Solution: Use DTOs**

Create lightweight DTO:
```java
public class UserDTO implements Serializable {
    private Long id;
    private String username;
    private String email;
    private int orderCount;
    private Date lastLoginDate;

    // Constructors
    public UserDTO() {}

    public UserDTO(User user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.orderCount = user.getOrders() != null ? user.getOrders().size() : 0;
        this.lastLoginDate = user.getLastLoginDate();
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getOrderCount() { return orderCount; }
    public void setOrderCount(int orderCount) { this.orderCount = orderCount; }

    public Date getLastLoginDate() { return lastLoginDate; }
    public void setLastLoginDate(Date lastLoginDate) { this.lastLoginDate = lastLoginDate; }
}
```

Use in Action:
```java
public ActionForward execute(...) {
    User user = userDAO.findById(1L);

    // Convert to DTO
    UserDTO dto = new UserDTO(user);

    request.setAttribute("user", dto);
    return mapping.findForward("success");
}
```

**DTO Factory Pattern**

```java
public class DTOFactory {

    public static UserDTO toDTO(User user) {
        if (user == null) return null;

        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        dto.setOrderCount(user.getOrders() != null ? user.getOrders().size() : 0);
        dto.setLastLoginDate(user.getLastLoginDate());

        return dto;
    }

    public static List toUserDTOList(List users) {
        List dtos = new ArrayList();
        for (Iterator it = users.iterator(); it.hasNext(); ) {
            User user = (User) it.next();
            dtos.add(toDTO(user));
        }
        return dtos;
    }

    public static OrderDTO toDTO(Order order) {
        if (order == null) return null;

        OrderDTO dto = new OrderDTO();
        dto.setId(order.getId());
        dto.setOrderNumber(order.getOrderNumber());
        dto.setTotal(order.getTotal());
        dto.setStatus(order.getStatus());
        dto.setOrderDate(order.getOrderDate());

        // Include user summary (not full user object)
        if (order.getUser() != null) {
            dto.setUserId(order.getUser().getId());
            dto.setUsername(order.getUser().getUsername());
        }

        return dto;
    }
}
```

---

#### **Async Processing**

**Background Task Executor**

```java
public class BackgroundTaskExecutor {

    private static final Logger logger = Logger.getLogger(BackgroundTaskExecutor.class);
    private static ExecutorService executor;

    static {
        // Create thread pool
        executor = Executors.newFixedThreadPool(5);
    }

    public static void submit(Runnable task) {
        executor.submit(new Runnable() {
            public void run() {
                try {
                    task.run();
                } catch (Exception e) {
                    logger.error("Background task failed", e);
                }
            }
        });
    }

    public static void shutdown() {
        executor.shutdown();
        try {
            if (!executor.awaitTermination(60, TimeUnit.SECONDS)) {
                executor.shutdownNow();
            }
        } catch (InterruptedException e) {
            executor.shutdownNow();
        }
    }
}
```

**Example: Async Email Sending**

```java
public class UserAction extends Action {

    public ActionForward register(ActionMapping mapping, ActionForm form,
                                  HttpServletRequest request,
                                  HttpServletResponse response) {

        UserForm userForm = (UserForm) form;

        // Save user (synchronous)
        User user = new User();
        user.setUsername(userForm.getUsername());
        user.setEmail(userForm.getEmail());
        userDAO.save(user);

        // Send welcome email (asynchronous)
        final String email = user.getEmail();
        final String username = user.getUsername();

        BackgroundTaskExecutor.submit(new Runnable() {
            public void run() {
                try {
                    EmailService.sendWelcomeEmail(email, username);
                    logger.info("Welcome email sent to: " + email);
                } catch (Exception e) {
                    logger.error("Failed to send welcome email to: " + email, e);
                }
            }
        });

        // Return immediately without waiting for email
        request.setAttribute("message", "Registration successful!");
        return mapping.findForward("success");
    }
}
```

**Listener for Executor Shutdown**

```java
public class ExecutorShutdownListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent event) {
        // Nothing to do on startup
    }

    public void contextDestroyed(ServletContextEvent event) {
        // Shutdown executor when application stops
        BackgroundTaskExecutor.shutdown();
    }
}
```

Register in `web.xml`:
```xml
<listener>
    <listener-class>com.example.listener.ExecutorShutdownListener</listener-class>
</listener>
```

---

### 11.3 Frontend Performance Optimization

#### **jQuery Optimization**

**Event Delegation (Better Performance)**

Bad (attaches handler to each row):
```javascript
// Slow for large tables
$('table tr').click(function() {
    $(this).toggleClass('selected');
});
```

Good (single handler on parent):
```javascript
// Fast - single event handler
$('table').on('click', 'tr', function() {
    $(this).toggleClass('selected');
});
```

**Caching jQuery Selectors**

Bad (searches DOM multiple times):
```javascript
$('#userList').show();
$('#userList').addClass('active');
$('#userList').find('li').each(function() {
    // ...
});
```

Good (cache selector):
```javascript
var $userList = $('#userList');
$userList.show();
$userList.addClass('active');
$userList.find('li').each(function() {
    // ...
});
```

**Chaining**

```javascript
// Bad - multiple statements
$('#message').text('Loading...');
$('#message').addClass('info');
$('#message').fadeIn();

// Good - chain methods
$('#message')
    .text('Loading...')
    .addClass('info')
    .fadeIn();
```

**Minimize DOM Manipulation**

Bad (updates DOM multiple times):
```javascript
var list = $('#userList');
for (var i = 0; i < users.length; i++) {
    list.append('<li>' + users[i].name + '</li>');
}
```

Good (build HTML then update once):
```javascript
var html = '';
for (var i = 0; i < users.length; i++) {
    html += '<li>' + users[i].name + '</li>';
}
$('#userList').html(html);
```

Better (use document fragment):
```javascript
var $list = $('#userList');
var fragment = $(document.createDocumentFragment());

for (var i = 0; i < users.length; i++) {
    fragment.append($('<li>').text(users[i].name));
}

$list.append(fragment);
```

---

#### **AJAX Response Optimization**

**Return JSON Instead of HTML**

Bad (server renders HTML):
```java
// Action returns full HTML
String html = "<tr><td>" + user.getUsername() + "</td></tr>";
response.getWriter().write(html);
```

Good (return JSON, client renders):
```java
// Action returns JSON
JSONObject json = new JSONObject();
json.put("id", user.getId());
json.put("username", user.getUsername());
json.put("email", user.getEmail());

response.setContentType("application/json");
response.getWriter().write(json.toString());
```

Client-side rendering:
```javascript
$.getJSON('/users.do?action=getUser&id=1', function(user) {
    var row = $('<tr>')
        .append($('<td>').text(user.username))
        .append($('<td>').text(user.email));

    $('#userTable tbody').append(row);
});
```

**Compress JSON Response**

```java
public class CompressionFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String acceptEncoding = httpRequest.getHeader("Accept-Encoding");

        if (acceptEncoding != null && acceptEncoding.contains("gzip")) {
            // Wrap response with GZIP output stream
            GZIPResponseWrapper wrapper = new GZIPResponseWrapper(httpResponse);
            chain.doFilter(request, wrapper);
            wrapper.finish();
        } else {
            chain.doFilter(request, response);
        }
    }
}
```

---

#### **Static Resource Optimization**

**Enable Tomcat Compression**

Update `tomcat/conf/server.xml`:
```xml
<Connector port="8080"
           protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"
           compression="on"
           compressionMinSize="1024"
           compressableMimeType="text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json"/>
```

**Combine and Minify JavaScript**

Create combined file in Ant build:
```xml
<target name="combine-js" description="Combine JavaScript files">
    <concat destfile="${build.dir}/war/js/app.min.js" encoding="UTF-8">
        <filelist dir="${src.dir}/webapp/js">
            <file name="jquery-1.12.4.min.js"/>
            <file name="common.js"/>
            <file name="validation.js"/>
            <file name="ajax.js"/>
        </filelist>
    </concat>
</target>
```

**Add Cache Headers**

```java
public class CacheControlFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String uri = httpRequest.getRequestURI();

        // Cache static resources
        if (uri.endsWith(".css") || uri.endsWith(".js") ||
            uri.endsWith(".jpg") || uri.endsWith(".png") ||
            uri.endsWith(".gif")) {

            // Cache for 1 week
            httpResponse.setHeader("Cache-Control", "public, max-age=604800");
            httpResponse.setDateHeader("Expires",
                System.currentTimeMillis() + 604800000L);
        } else {
            // No cache for dynamic content
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            httpResponse.setHeader("Pragma", "no-cache");
            httpResponse.setDateHeader("Expires", 0);
        }

        chain.doFilter(request, response);
    }
}
```

---

### 11.4 JVM Performance Tuning

#### **Memory Settings**

Update `tomcat/bin/setenv.sh`:
```bash
#!/bin/bash

# Heap size settings
export CATALINA_OPTS="-Xms512m -Xmx1024m"

# PermGen size (Java 5/6/7 only)
export CATALINA_OPTS="$CATALINA_OPTS -XX:PermSize=128m -XX:MaxPermSize=256m"

# Garbage Collection logging
export CATALINA_OPTS="$CATALINA_OPTS -verbose:gc"
export CATALINA_OPTS="$CATALINA_OPTS -XX:+PrintGCDetails"
export CATALINA_OPTS="$CATALINA_OPTS -XX:+PrintGCDateStamps"
export CATALINA_OPTS="$CATALINA_OPTS -Xloggc:logs/gc.log"

# Use concurrent GC for better performance
export CATALINA_OPTS="$CATALINA_OPTS -XX:+UseConcMarkSweepGC"
export CATALINA_OPTS="$CATALINA_OPTS -XX:+CMSParallelRemarkEnabled"

# GC tuning
export CATALINA_OPTS="$CATALINA_OPTS -XX:NewSize=256m"
export CATALINA_OPTS="$CATALINA_OPTS -XX:MaxNewSize=256m"
export CATALINA_OPTS="$CATALINA_OPTS -XX:SurvivorRatio=8"

# Performance monitoring
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.port=9999"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.ssl=false"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
```

**Analyze GC Logs**

```bash
# View GC log
tail -f tomcat/logs/gc.log

# Look for:
# - Full GC frequency (should be infrequent)
# - GC pause times (should be < 1 second)
# - Memory trends (heap usage over time)

# Example good GC log entry:
# 2024.10.12 10:30:45 GC [ParNew: 78643K->8704K(78656K), 0.0234810 secs]

# Example bad GC log entry (Full GC):
# 2024.10.12 10:30:50 Full GC [PSYoungGen: 0K->0K(78656K)] [PSOldGen: 512000K->512000K(524288K)] 512000K->512000K(602944K) [PSPermGen: 131071K->131071K(131072K)], 5.2341234 secs]
```

---

### 11.5 Performance Monitoring

#### **Application Performance Monitoring**

Create performance filter:
```java
public class PerformanceMonitorFilter implements Filter {

    private static final Logger logger = Logger.getLogger(PerformanceMonitorFilter.class);
    private static final long SLOW_REQUEST_THRESHOLD = 1000; // 1 second

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;

        long startTime = System.currentTimeMillis();

        try {
            chain.doFilter(request, response);
        } finally {
            long endTime = System.currentTimeMillis();
            long duration = endTime - startTime;

            String uri = httpRequest.getRequestURI();
            String queryString = httpRequest.getQueryString();
            String fullUrl = queryString != null ? uri + "?" + queryString : uri;

            if (duration > SLOW_REQUEST_THRESHOLD) {
                logger.warn("SLOW REQUEST [" + duration + "ms]: " + fullUrl);
            } else {
                logger.debug("Request [" + duration + "ms]: " + fullUrl);
            }
        }
    }

    public void init(FilterConfig config) {}
    public void destroy() {}
}
```

**Performance Metrics Servlet**

```java
public class PerformanceServlet extends HttpServlet {

    private static Map requestCounts = new ConcurrentHashMap();
    private static Map requestTimes = new ConcurrentHashMap();

    public static void recordRequest(String uri, long duration) {
        // Increment count
        Integer count = (Integer) requestCounts.get(uri);
        requestCounts.put(uri, count == null ? 1 : count + 1);

        // Record time
        Long total = (Long) requestTimes.get(uri);
        requestTimes.put(uri, total == null ? duration : total + duration);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Performance Metrics</title></head><body>");
        out.println("<h1>Performance Metrics</h1>");
        out.println("<table border='1'>");
        out.println("<tr><th>URI</th><th>Count</th><th>Avg Time (ms)</th></tr>");

        for (Iterator it = requestCounts.keySet().iterator(); it.hasNext(); ) {
            String uri = (String) it.next();
            Integer count = (Integer) requestCounts.get(uri);
            Long totalTime = (Long) requestTimes.get(uri);
            long avgTime = totalTime / count;

            out.println("<tr>");
            out.println("<td>" + uri + "</td>");
            out.println("<td>" + count + "</td>");
            out.println("<td>" + avgTime + "</td>");
            out.println("</tr>");
        }

        out.println("</table>");
        out.println("</body></html>");
    }
}
```

---

### 11.6 Performance Testing

**Apache JMeter Test Plan**

Install JMeter:
```bash
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-2.13.tgz
tar -xzf apache-jmeter-2.13.tgz
cd apache-jmeter-2.13/bin
./jmeter.sh
```

Create test plan `test/performance/load-test.jmx`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<jmeterTestPlan version="1.2">
  <hashTree>
    <TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="User Load Test">
      <stringProp name="TestPlan.comments">Load test for user operations</stringProp>
      <boolProp name="TestPlan.functional_mode">false</boolProp>
    </TestPlan>
    <hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Users">
        <intProp name="ThreadGroup.num_threads">50</intProp>
        <intProp name="ThreadGroup.ramp_time">10</intProp>
        <longProp name="ThreadGroup.duration">60</longProp>
        <boolProp name="ThreadGroup.scheduler">true</boolProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="List Users">
          <stringProp name="HTTPSampler.domain">localhost</stringProp>
          <stringProp name="HTTPSampler.port">8080</stringProp>
          <stringProp name="HTTPSampler.path">/MyApp/users.do</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
        </HTTPSamplerProxy>
      </hashTree>
    </hashTree>
  </hashTree>
</jmeterTestPlan>
```

Run test:
```bash
jmeter -n -t test/performance/load-test.jmx -l results.jtl
```

---

### 11.7 Performance Optimization Checklist

**Database**
- [ ] Enable query caching
- [ ] Add indexes on frequently queried columns
- [ ] Use connection pooling (C3P0)
- [ ] Avoid N+1 queries (use fetch joins)
- [ ] Use pagination for large result sets
- [ ] Enable second-level cache for read-heavy entities
- [ ] Use projections instead of loading full entities

**Application**
- [ ] Use DTOs instead of Hibernate entities in views
- [ ] Implement request-scoped sessions
- [ ] Enable batch fetching
- [ ] Use async processing for long-running tasks
- [ ] Monitor and close database connections
- [ ] Profile slow requests

**Frontend**
- [ ] Use event delegation
- [ ] Cache jQuery selectors
- [ ] Minimize DOM manipulation
- [ ] Return JSON instead of HTML
- [ ] Enable GZIP compression
- [ ] Add cache headers for static resources
- [ ] Combine and minify JavaScript/CSS

**JVM**
- [ ] Set appropriate heap size (-Xms, -Xmx)
- [ ] Configure garbage collection
- [ ] Enable GC logging
- [ ] Monitor with JConsole/VisualVM
- [ ] Set PermGen size appropriately

**Monitoring**
- [ ] Enable Hibernate statistics
- [ ] Log slow queries
- [ ] Monitor request times
- [ ] Track cache hit rates
- [ ] Run load tests
- [ ] Monitor memory usage

---

## 12. Security Best Practices

### 12.1 Input Validation and Sanitization

#### **SQL Injection Prevention**

**Always Use Parameterized Queries**

Bad (vulnerable to SQL injection):
```java
// NEVER DO THIS!
public User findByUsername(String username) {
    String sql = "SELECT * FROM users WHERE username = '" + username + "'";
    Query query = session.createSQLQuery(sql);
    return (User) query.uniqueResult();
}

// Attack: username = "admin' OR '1'='1"
// Resulting SQL: SELECT * FROM users WHERE username = 'admin' OR '1'='1'
```

Good (safe from SQL injection):
```java
// Use named parameters
public User findByUsername(String username) {
    String hql = "FROM User u WHERE u.username = :username";
    Query query = session.createQuery(hql);
    query.setString("username", username);
    return (User) query.uniqueResult();
}

// Or use Criteria API
public User findByUsername(String username) {
    Criteria criteria = session.createCriteria(User.class);
    criteria.add(Restrictions.eq("username", username));
    return (User) criteria.uniqueResult();
}
```

**Native SQL with Parameters**

```java
public List getUsersByStatus(String status) {
    String sql = "SELECT * FROM users WHERE status = :status";
    SQLQuery query = session.createSQLQuery(sql);
    query.setString("status", status);
    query.addEntity(User.class);
    return query.list();
}
```

---

#### **Cross-Site Scripting (XSS) Prevention**

**JSTL c:out Tag**

Bad (vulnerable to XSS):
```jsp
<!-- NEVER output user input directly -->
<p>Welcome ${user.username}</p>
<p>${user.bio}</p>

<!-- Attack: username = "<script>alert('XSS')</script>"
     Result: Script executes in browser -->
```

Good (escapes HTML):
```jsp
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Always use c:out for user-generated content -->
<p>Welcome <c:out value="${user.username}"/></p>
<p><c:out value="${user.bio}"/></p>

<!-- With default value -->
<c:out value="${user.bio}" default="No bio available"/>
```

**Server-Side HTML Sanitization**

Create sanitization utility:
```java
package com.example.util;

import java.util.HashMap;
import java.util.Map;

/**
 * HTML sanitization utility
 */
public class SecurityUtil {

    private static final Map HTML_ENTITIES = new HashMap();

    static {
        HTML_ENTITIES.put("<", "&lt;");
        HTML_ENTITIES.put(">", "&gt;");
        HTML_ENTITIES.put("&", "&amp;");
        HTML_ENTITIES.put("\"", "&quot;");
        HTML_ENTITIES.put("'", "&#x27;");
        HTML_ENTITIES.put("/", "&#x2F;");
    }

    /**
     * Escape HTML special characters
     */
    public static String escapeHtml(String input) {
        if (input == null) {
            return null;
        }

        StringBuffer output = new StringBuffer();
        for (int i = 0; i < input.length(); i++) {
            char ch = input.charAt(i);
            String entity = (String) HTML_ENTITIES.get(String.valueOf(ch));
            if (entity != null) {
                output.append(entity);
            } else {
                output.append(ch);
            }
        }
        return output.toString();
    }

    /**
     * Remove all HTML tags
     */
    public static String stripHtml(String input) {
        if (input == null) {
            return null;
        }
        return input.replaceAll("<[^>]*>", "");
    }

    /**
     * Remove JavaScript event handlers
     */
    public static String removeJavaScript(String input) {
        if (input == null) {
            return null;
        }

        // Remove javascript: protocol
        String cleaned = input.replaceAll("(?i)javascript:", "");

        // Remove event handlers (onclick, onerror, etc.)
        cleaned = cleaned.replaceAll("(?i)on\\w+\\s*=", "");

        return cleaned;
    }

    /**
     * Validate input against allowed pattern
     */
    public static boolean isValidUsername(String username) {
        if (username == null) return false;
        // Only alphanumeric and underscore, 3-20 chars
        return username.matches("^[a-zA-Z0-9_]{3,20}$");
    }

    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        // Basic email validation
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }
}
```

**Use in Action**

```java
public ActionForward save(ActionMapping mapping, ActionForm form,
                         HttpServletRequest request,
                         HttpServletResponse response) {

    UserForm userForm = (UserForm) form;

    // Sanitize inputs
    String username = SecurityUtil.escapeHtml(userForm.getUsername());
    String bio = SecurityUtil.escapeHtml(userForm.getBio());

    // Validate format
    if (!SecurityUtil.isValidUsername(username)) {
        errors.add("username", new ActionMessage("error.username.invalid"));
        return mapping.findForward("input");
    }

    User user = new User();
    user.setUsername(username);
    user.setBio(bio);
    userDAO.save(user);

    return mapping.findForward("success");
}
```

---

#### **Cross-Site Request Forgery (CSRF) Protection**

**CSRF Token Implementation**

Create token generator:
```java
package com.example.util;

import java.security.SecureRandom;
import java.math.BigInteger;

public class CSRFTokenUtil {

    private static final SecureRandom random = new SecureRandom();

    /**
     * Generate cryptographically secure random token
     */
    public static String generateToken() {
        return new BigInteger(130, random).toString(32);
    }

    /**
     * Store token in session
     */
    public static void setToken(HttpSession session) {
        String token = generateToken();
        session.setAttribute("csrfToken", token);
    }

    /**
     * Get token from session
     */
    public static String getToken(HttpSession session) {
        String token = (String) session.getAttribute("csrfToken");
        if (token == null) {
            setToken(session);
            token = (String) session.getAttribute("csrfToken");
        }
        return token;
    }

    /**
     * Validate token from request
     */
    public static boolean validateToken(HttpServletRequest request) {
        String sessionToken = (String) request.getSession().getAttribute("csrfToken");
        String requestToken = request.getParameter("csrfToken");

        if (sessionToken == null || requestToken == null) {
            return false;
        }

        return sessionToken.equals(requestToken);
    }
}
```

**CSRF Filter**

```java
public class CSRFFilter implements Filter {

    private static final Logger logger = Logger.getLogger(CSRFFilter.class);

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String method = httpRequest.getMethod();

        // Check CSRF token for state-changing operations
        if ("POST".equalsIgnoreCase(method) ||
            "PUT".equalsIgnoreCase(method) ||
            "DELETE".equalsIgnoreCase(method)) {

            if (!CSRFTokenUtil.validateToken(httpRequest)) {
                logger.warn("CSRF token validation failed for: " +
                           httpRequest.getRequestURI());
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN,
                                     "Invalid CSRF token");
                return;
            }
        }

        // Ensure token exists in session for next request
        CSRFTokenUtil.getToken(httpRequest.getSession());

        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) {}
    public void destroy() {}
}
```

Register in `web.xml`:
```xml
<filter>
    <filter-name>csrfFilter</filter-name>
    <filter-class>com.example.filter.CSRFFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>csrfFilter</filter-name>
    <url-pattern>*.do</url-pattern>
</filter-mapping>
```

**Include Token in Forms**

```jsp
<%@ page import="com.example.util.CSRFTokenUtil" %>

<html:form action="/users">
    <input type="hidden" name="csrfToken"
           value="<%= CSRFTokenUtil.getToken(session) %>"/>

    <html:text property="username"/>
    <html:password property="password"/>
    <html:submit value="Submit"/>
</html:form>
```

**Include Token in AJAX**

```javascript
// Store token in page
var csrfToken = '<%= CSRFTokenUtil.getToken(session) %>';

// Include in AJAX requests
$.ajax({
    url: '/users.do',
    type: 'POST',
    data: {
        username: 'john',
        email: 'john@example.com',
        csrfToken: csrfToken
    },
    success: function(response) {
        console.log('Success');
    }
});
```

---

### 12.2 Authentication and Authorization

#### **Password Security**

**Password Hashing with Salt**

Create password utility:
```java
package com.example.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class PasswordUtil {

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
     * Hash password with salt using SHA-256
     */
    public static String hashPassword(String password, byte[] salt)
            throws NoSuchAlgorithmException {

        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);

        byte[] hashedPassword = md.digest(password.getBytes());

        // Combine salt and hash
        byte[] combined = new byte[salt.length + hashedPassword.length];
        System.arraycopy(salt, 0, combined, 0, salt.length);
        System.arraycopy(hashedPassword, 0, combined, salt.length, hashedPassword.length);

        return bytesToHex(combined);
    }

    /**
     * Verify password against stored hash
     */
    public static boolean verifyPassword(String password, String storedHash)
            throws NoSuchAlgorithmException {

        byte[] combined = hexToBytes(storedHash);

        // Extract salt
        byte[] salt = new byte[SALT_LENGTH];
        System.arraycopy(combined, 0, salt, 0, SALT_LENGTH);

        // Hash provided password with extracted salt
        String hashedInput = hashPassword(password, salt);

        // Compare hashes
        return hashedInput.equals(storedHash);
    }

    /**
     * Convert byte array to hex string
     */
    private static String bytesToHex(byte[] bytes) {
        StringBuffer result = new StringBuffer();
        for (byte b : bytes) {
            result.append(String.format("%02x", b));
        }
        return result.toString();
    }

    /**
     * Convert hex string to byte array
     */
    private static byte[] hexToBytes(String hex) {
        int len = hex.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                                 + Character.digit(hex.charAt(i+1), 16));
        }
        return data;
    }

    /**
     * Validate password strength
     */
    public static boolean isStrongPassword(String password) {
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

**User Registration with Password Hashing**

```java
public ActionForward register(ActionMapping mapping, ActionForm form,
                             HttpServletRequest request,
                             HttpServletResponse response) {

    UserForm userForm = (UserForm) form;

    try {
        // Validate password strength
        if (!PasswordUtil.isStrongPassword(userForm.getPassword())) {
            errors.add("password",
                new ActionMessage("error.password.weak"));
            return mapping.findForward("input");
        }

        // Hash password
        byte[] salt = PasswordUtil.generateSalt();
        String hashedPassword = PasswordUtil.hashPassword(
            userForm.getPassword(), salt
        );

        // Save user
        User user = new User();
        user.setUsername(userForm.getUsername());
        user.setEmail(userForm.getEmail());
        user.setPassword(hashedPassword);
        user.setCreatedDate(new Date());

        userDAO.save(user);

        request.setAttribute("message", "Registration successful!");
        return mapping.findForward("success");

    } catch (Exception e) {
        logger.error("Registration failed", e);
        errors.add("general", new ActionMessage("error.registration.failed"));
        return mapping.findForward("error");
    }
}
```

**Login with Password Verification**

```java
public ActionForward login(ActionMapping mapping, ActionForm form,
                          HttpServletRequest request,
                          HttpServletResponse response) {

    UserForm userForm = (UserForm) form;

    try {
        User user = userDAO.findByUsername(userForm.getUsername());

        if (user == null) {
            errors.add("login", new ActionMessage("error.login.invalid"));
            return mapping.findForward("input");
        }

        // Verify password
        boolean valid = PasswordUtil.verifyPassword(
            userForm.getPassword(),
            user.getPassword()
        );

        if (!valid) {
            errors.add("login", new ActionMessage("error.login.invalid"));
            return mapping.findForward("input");
        }

        // Store user in session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);
        session.setAttribute("userId", user.getId());

        logger.info("User logged in: " + user.getUsername());

        return mapping.findForward("success");

    } catch (Exception e) {
        logger.error("Login failed", e);
        errors.add("general", new ActionMessage("error.login.failed"));
        return mapping.findForward("error");
    }
}
```

---

#### **Session Security**

**Session Configuration in web.xml**

```xml
<!-- Session timeout (30 minutes) -->
<session-config>
    <session-timeout>30</session-timeout>
</session-config>

<!-- HttpOnly and Secure flags for cookies -->
<!-- Note: HttpOnly requires Servlet 3.0+, limited in Servlet 2.5 -->
<!-- Configure in Tomcat's context.xml instead -->
```

**Tomcat Context Configuration**

`tomcat/conf/context.xml`:
```xml
<Context useHttpOnly="true" sessionCookiePath="/" sessionCookieName="JSESSIONID">
    <!-- Additional security settings -->
</Context>
```

**Session Fixation Prevention**

```java
public ActionForward login(ActionMapping mapping, ActionForm form,
                          HttpServletRequest request,
                          HttpServletResponse response) {

    // ... password verification ...

    if (valid) {
        // Prevent session fixation - invalidate old session
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }

        // Create new session
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("currentUser", user);
        newSession.setAttribute("userId", user.getId());

        return mapping.findForward("success");
    }

    return mapping.findForward("input");
}
```

**Session Timeout Warning**

JavaScript to warn user:
```javascript
// Session timeout: 30 minutes = 1800000 ms
var sessionTimeout = 1800000;
var warningTime = 300000; // Warn 5 minutes before

setTimeout(function() {
    if (confirm('Your session will expire in 5 minutes. Continue working?')) {
        // Refresh session with AJAX call
        $.get('/keepalive.do');
    }
}, sessionTimeout - warningTime);
```

---

#### **Authorization Filter**

**Role-Based Access Control**

```java
public class AuthorizationFilter implements Filter {

    private static final Logger logger = Logger.getLogger(AuthorizationFilter.class);

    // Define protected resources and required roles
    private static final Map PROTECTED_RESOURCES = new HashMap();

    static {
        PROTECTED_RESOURCES.put("/admin", "ROLE_ADMIN");
        PROTECTED_RESOURCES.put("/users/delete.do", "ROLE_ADMIN");
        PROTECTED_RESOURCES.put("/users/edit.do", "ROLE_USER");
    }

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String uri = httpRequest.getRequestURI();
        HttpSession session = httpRequest.getSession(false);

        // Check if resource requires authentication
        if (requiresAuthentication(uri)) {

            if (session == null || session.getAttribute("currentUser") == null) {
                logger.warn("Unauthenticated access attempt to: " + uri);
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
                return;
            }

            // Check if resource requires specific role
            String requiredRole = getRequiredRole(uri);
            if (requiredRole != null) {
                User user = (User) session.getAttribute("currentUser");

                if (!hasRole(user, requiredRole)) {
                    logger.warn("Unauthorized access attempt by " +
                               user.getUsername() + " to: " + uri);
                    httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
            }
        }

        chain.doFilter(request, response);
    }

    private boolean requiresAuthentication(String uri) {
        // All .do actions except login require authentication
        return uri.endsWith(".do") && !uri.contains("/login.do");
    }

    private String getRequiredRole(String uri) {
        for (Iterator it = PROTECTED_RESOURCES.keySet().iterator(); it.hasNext(); ) {
            String pattern = (String) it.next();
            if (uri.contains(pattern)) {
                return (String) PROTECTED_RESOURCES.get(pattern);
            }
        }
        return null;
    }

    private boolean hasRole(User user, String role) {
        // Check user's roles
        Set roles = user.getRoles();
        if (roles == null) return false;

        for (Iterator it = roles.iterator(); it.hasNext(); ) {
            Role r = (Role) it.next();
            if (role.equals(r.getName())) {
                return true;
            }
        }
        return false;
    }

    public void init(FilterConfig config) {}
    public void destroy() {}
}
```

---

### 12.3 Secure Configuration

#### **Database Security**

**Use Least Privilege Database User**

```sql
-- Create dedicated application user
CREATE USER 'myapp_user'@'localhost' IDENTIFIED BY 'strong_password_here';

-- Grant only necessary permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON myapp_db.* TO 'myapp_user'@'localhost';

-- DO NOT grant:
-- - CREATE, DROP, ALTER (structure changes)
-- - SUPER, PROCESS (admin privileges)
-- - FILE (read/write files)
-- - GRANT OPTION (give permissions to others)

FLUSH PRIVILEGES;
```

**Encrypt Database Passwords**

Create configuration encryption utility:
```java
public class ConfigEncryption {

    private static final String ALGORITHM = "AES";
    private static final String KEY = "MySecretKey12345"; // Store securely!

    public static String encrypt(String value) throws Exception {
        SecretKeySpec secretKey = new SecretKeySpec(KEY.getBytes(), ALGORITHM);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encrypted = cipher.doFinal(value.getBytes());
        return Base64.getEncoder().encodeToString(encrypted);
    }

    public static String decrypt(String encrypted) throws Exception {
        SecretKeySpec secretKey = new SecretKeySpec(KEY.getBytes(), ALGORITHM);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(encrypted));
        return new String(decrypted);
    }
}
```

**Externalize Database Credentials**

Store in environment variables or external properties:
```bash
# Set in environment
export DB_USERNAME=myapp_user
export DB_PASSWORD=encrypted_password_here
```

Load in application:
```java
public class HibernateUtil {

    static {
        try {
            Configuration config = new Configuration();
            config.configure();

            // Override with environment variables
            String dbUser = System.getenv("DB_USERNAME");
            String dbPass = System.getenv("DB_PASSWORD");

            if (dbUser != null) {
                config.setProperty("connection.username", dbUser);
            }
            if (dbPass != null) {
                // Decrypt if encrypted
                String decrypted = ConfigEncryption.decrypt(dbPass);
                config.setProperty("connection.password", decrypted);
            }

            sessionFactory = config.buildSessionFactory();
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }
}
```

---

#### **HTTPS Configuration**

**Generate SSL Certificate**

```bash
# Generate self-signed certificate (development only)
keytool -genkey -alias tomcat \
        -keyalg RSA \
        -keystore /path/to/keystore.jks \
        -keysize 2048 \
        -validity 365

# For production, use a certificate from trusted CA
```

**Configure Tomcat SSL Connector**

`tomcat/conf/server.xml`:
```xml
<!-- HTTP Connector (redirect to HTTPS) -->
<Connector port="8080"
           protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"/>

<!-- HTTPS Connector -->
<Connector port="8443"
           protocol="HTTP/1.1"
           SSLEnabled="true"
           maxThreads="150"
           scheme="https"
           secure="true"
           keystoreFile="/path/to/keystore.jks"
           keystorePass="changeit"
           clientAuth="false"
           sslProtocol="TLS"/>
```

**Force HTTPS in web.xml**

```xml
<!-- Security constraint to force HTTPS -->
<security-constraint>
    <web-resource-collection>
        <web-resource-name>Entire Application</web-resource-name>
        <url-pattern>/*</url-pattern>
    </web-resource-collection>
    <user-data-constraint>
        <transport-guarantee>CONFIDENTIAL</transport-guarantee>
    </user-data-constraint>
</security-constraint>
```

---

#### **Secure Headers Filter**

```java
public class SecurityHeadersFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws IOException, ServletException {

        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Prevent clickjacking
        httpResponse.setHeader("X-Frame-Options", "DENY");

        // Prevent MIME sniffing
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");

        // Enable XSS protection
        httpResponse.setHeader("X-XSS-Protection", "1; mode=block");

        // Content Security Policy
        httpResponse.setHeader("Content-Security-Policy",
            "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'");

        // Strict transport security (HTTPS only)
        httpResponse.setHeader("Strict-Transport-Security",
            "max-age=31536000; includeSubDomains");

        // Referrer policy
        httpResponse.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");

        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) {}
    public void destroy() {}
}
```

Register in `web.xml`:
```xml
<filter>
    <filter-name>securityHeadersFilter</filter-name>
    <filter-class>com.example.filter.SecurityHeadersFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>securityHeadersFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

---

### 12.4 Error Handling and Information Disclosure

#### **Custom Error Pages**

**Configure in web.xml**

```xml
<!-- Custom error pages -->
<error-page>
    <error-code>404</error-code>
    <location>/error/404.jsp</location>
</error-page>

<error-page>
    <error-code>500</error-code>
    <location>/error/500.jsp</location>
</error-page>

<error-page>
    <error-code>403</error-code>
    <location>/error/403.jsp</location>
</error-page>

<!-- Handle all exceptions -->
<error-page>
    <exception-type>java.lang.Exception</exception-type>
    <location>/error/general.jsp</location>
</error-page>
```

**Error Page Example**

`error/500.jsp`:
```jsp
<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Server Error</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>
    <div class="error-container">
        <h1>500 - Internal Server Error</h1>
        <p>We're sorry, but something went wrong.</p>
        <p>Our team has been notified and is working to resolve the issue.</p>

        <!-- DO NOT expose stack traces in production -->
        <c:if test="${pageContext.request.serverName == 'localhost'}">
            <h2>Debug Information (Development Only)</h2>
            <pre><c:out value="${pageContext.exception}"/></pre>
        </c:if>

        <p><a href="<c:url value='/index.jsp'/>">Return to Home</a></p>
    </div>
</body>
</html>
```

---

#### **Disable Directory Listing**

**Tomcat Configuration**

`tomcat/conf/web.xml` (global):
```xml
<servlet>
    <servlet-name>default</servlet-name>
    <servlet-class>org.apache.catalina.servlets.DefaultServlet</servlet-class>
    <init-param>
        <param-name>listings</param-name>
        <param-value>false</param-value>
    </init-param>
</servlet>
```

---

#### **Sanitize Log Output**

**Prevent Log Injection**

```java
public class LogUtil {

    /**
     * Sanitize string for logging to prevent log injection
     */
    public static String sanitizeForLog(String input) {
        if (input == null) {
            return null;
        }

        // Remove newlines and carriage returns
        return input.replaceAll("[\n\r\t]", "_");
    }

    /**
     * Log user action safely
     */
    public static void logUserAction(Logger logger, String username, String action) {
        logger.info("User: " + sanitizeForLog(username) +
                   " Action: " + sanitizeForLog(action));
    }
}
```

Usage:
```java
// Bad - vulnerable to log injection
logger.info("User login: " + username);
// Attack: username = "admin\nINFO User login: attacker\nINFO Fake log entry"

// Good - sanitized
LogUtil.logUserAction(logger, username, "login");
```

---

### 12.5 File Upload Security

#### **Secure File Upload**

```java
public class FileUploadAction extends Action {

    private static final Logger logger = Logger.getLogger(FileUploadAction.class);

    // Allowed file types
    private static final Set ALLOWED_TYPES = new HashSet();
    static {
        ALLOWED_TYPES.add("image/jpeg");
        ALLOWED_TYPES.add("image/png");
        ALLOWED_TYPES.add("image/gif");
        ALLOWED_TYPES.add("application/pdf");
    }

    // Max file size: 5MB
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;

    // Upload directory (outside webroot)
    private static final String UPLOAD_DIR = "/var/uploads/myapp/";

    public ActionForward upload(ActionMapping mapping, ActionForm form,
                               HttpServletRequest request,
                               HttpServletResponse response) {

        FileUploadForm uploadForm = (FileUploadForm) form;
        FormFile file = uploadForm.getFile();

        try {
            // Validate file exists
            if (file == null || file.getFileSize() == 0) {
                errors.add("file", new ActionMessage("error.file.required"));
                return mapping.findForward("input");
            }

            // Check file size
            if (file.getFileSize() > MAX_FILE_SIZE) {
                errors.add("file", new ActionMessage("error.file.too.large"));
                return mapping.findForward("input");
            }

            // Check content type
            String contentType = file.getContentType();
            if (!ALLOWED_TYPES.contains(contentType)) {
                errors.add("file", new ActionMessage("error.file.invalid.type"));
                return mapping.findForward("input");
            }

            // Validate file extension
            String fileName = file.getFileName();
            if (!isValidExtension(fileName)) {
                errors.add("file", new ActionMessage("error.file.invalid.extension"));
                return mapping.findForward("input");
            }

            // Generate safe filename
            String safeFileName = generateSafeFileName(fileName);

            // Scan for malicious content (if using antivirus)
            // scanFile(file.getInputStream());

            // Save file outside webroot
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File savedFile = new File(uploadDir, safeFileName);
            FileOutputStream fos = new FileOutputStream(savedFile);
            fos.write(file.getFileData());
            fos.close();

            logger.info("File uploaded: " + safeFileName +
                       " by user: " + request.getSession().getAttribute("username"));

            request.setAttribute("uploadedFile", safeFileName);
            return mapping.findForward("success");

        } catch (Exception e) {
            logger.error("File upload failed", e);
            errors.add("general", new ActionMessage("error.upload.failed"));
            return mapping.findForward("error");
        }
    }

    private boolean isValidExtension(String fileName) {
        String[] allowed = {".jpg", ".jpeg", ".png", ".gif", ".pdf"};
        String lower = fileName.toLowerCase();

        for (String ext : allowed) {
            if (lower.endsWith(ext)) {
                return true;
            }
        }
        return false;
    }

    private String generateSafeFileName(String originalName) {
        // Remove path components
        String baseName = new File(originalName).getName();

        // Generate UUID prefix to avoid conflicts and path traversal
        String uuid = UUID.randomUUID().toString();

        // Get extension
        int dotIndex = baseName.lastIndexOf('.');
        String extension = dotIndex > 0 ? baseName.substring(dotIndex) : "";

        // Sanitize extension
        extension = extension.replaceAll("[^a-zA-Z0-9.]", "");

        return uuid + extension;
    }
}
```

---

### 12.6 Security Audit and Logging

#### **Security Event Logging**

```java
public class SecurityAuditLogger {

    private static final Logger logger = Logger.getLogger(SecurityAuditLogger.class);

    public static void logLoginSuccess(String username, String ipAddress) {
        logger.info("LOGIN_SUCCESS | User: " + username + " | IP: " + ipAddress);
    }

    public static void logLoginFailure(String username, String ipAddress) {
        logger.warn("LOGIN_FAILURE | User: " + username + " | IP: " + ipAddress);
    }

    public static void logLogout(String username) {
        logger.info("LOGOUT | User: " + username);
    }

    public static void logPasswordChange(String username) {
        logger.info("PASSWORD_CHANGE | User: " + username);
    }

    public static void logAccessDenied(String username, String resource) {
        logger.warn("ACCESS_DENIED | User: " + username + " | Resource: " + resource);
    }

    public static void logSuspiciousActivity(String username, String activity) {
        logger.error("SUSPICIOUS_ACTIVITY | User: " + username + " | Activity: " + activity);
    }

    public static void logDataAccess(String username, String entity, String action) {
        logger.info("DATA_ACCESS | User: " + username +
                   " | Entity: " + entity + " | Action: " + action);
    }
}
```

**Use in Actions**

```java
public ActionForward login(ActionMapping mapping, ActionForm form,
                          HttpServletRequest request,
                          HttpServletResponse response) {

    UserForm userForm = (UserForm) form;
    String ipAddress = request.getRemoteAddr();

    try {
        User user = userDAO.findByUsername(userForm.getUsername());

        if (user == null || !PasswordUtil.verifyPassword(
                userForm.getPassword(), user.getPassword())) {

            // Log failed login
            SecurityAuditLogger.logLoginFailure(
                userForm.getUsername(), ipAddress
            );

            errors.add("login", new ActionMessage("error.login.invalid"));
            return mapping.findForward("input");
        }

        // Log successful login
        SecurityAuditLogger.logLoginSuccess(user.getUsername(), ipAddress);

        // ... rest of login logic ...

    } catch (Exception e) {
        logger.error("Login error", e);
        return mapping.findForward("error");
    }
}
```

---

### 12.7 Security Checklist

**Input Validation**
- [ ] Use parameterized queries (no string concatenation in SQL)
- [ ] Validate all user inputs server-side
- [ ] Sanitize HTML output with `<c:out>` or escapeHtml()
- [ ] Implement CSRF token protection
- [ ] Validate file uploads (type, size, content)
- [ ] Use whitelist validation for allowed values

**Authentication & Authorization**
- [ ] Hash passwords with salt (SHA-256 minimum)
- [ ] Enforce strong password policy
- [ ] Implement session timeout
- [ ] Prevent session fixation (regenerate session ID on login)
- [ ] Implement role-based access control
- [ ] Log authentication events

**Configuration**
- [ ] Use HTTPS in production
- [ ] Set secure cookie flags (HttpOnly, Secure)
- [ ] Disable directory listing
- [ ] Use custom error pages (hide stack traces)
- [ ] Externalize database credentials
- [ ] Use least privilege database user
- [ ] Add security headers (X-Frame-Options, CSP, etc.)

**Data Protection**
- [ ] Encrypt sensitive data at rest
- [ ] Use HTTPS for data in transit
- [ ] Sanitize log output
- [ ] Secure file upload directory (outside webroot)
- [ ] Implement audit logging
- [ ] Regular security updates

**Error Handling**
- [ ] Never expose stack traces to users
- [ ] Log errors securely
- [ ] Use custom error pages
- [ ] Sanitize error messages

**Testing**
- [ ] Perform security testing (OWASP Top 10)
- [ ] Test for SQL injection
- [ ] Test for XSS vulnerabilities
- [ ] Test for CSRF vulnerabilities
- [ ] Test authentication and authorization
- [ ] Perform penetration testing

---

## Conclusion

This Legacy Stack Knowledge Base provides comprehensive guidance for developing applications using Tomcat 6, MySQL 5.7, Hibernate 3.6, Struts 1.3, and jQuery 1.12 in a Java 1.5 environment.

The 12 sections cover:
1. Development Environment Overview
2. Technology Stack Integration
3. Project Structure and Organization
4. Development Workflow
5. Database Development with MySQL and Hibernate
6. Frontend Development with jQuery
7. Struts Integration Patterns
8. Build and Deployment
9. Testing Strategies
10. Debugging and Troubleshooting
11. Performance Optimization
12. Security Best Practices

This knowledge base serves as a complete reference for maintaining and enhancing legacy Java applications while following modern best practices adapted to the constraints of this technology stack.

---
