# Architecture Overview: jQuery + Hibernate + Struts Integration

## 🏗️ Application Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        BROWSER / CLIENT                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────┐  ┌──────────────┐  ┌──────────────────────┐   │
│  │   JSP Pages │  │ jQuery 1.12.4│  │  Struts Tag Library  │   │
│  │             │  │              │  │                      │   │
│  │ - index.jsp │  │ - AJAX calls │  │ - html:form         │   │
│  │ - sample.jsp│  │ - Validation │  │ - bean:write        │   │
│  │ - users.jsp │  │ - Animation  │  │ - logic:iterate     │   │
│  └─────────────┘  └──────────────┘  └──────────────────────┘   │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
                                 │
                                 │ HTTP Request (*.do)
                                 ↓
┌─────────────────────────────────────────────────────────────────┐
│                    TOMCAT 5.5 (Web Container)                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              Servlet Filters & Listeners                 │   │
│  │                                                          │   │
│  │  - HibernateSessionFilter (session management)          │   │
│  │  - HibernateListener (lifecycle management)             │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                 │                                │
│                                 ↓                                │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │           Struts 1.3.10 ActionServlet                   │   │
│  │                                                          │   │
│  │  - Request Processing                                   │   │
│  │  - Form Validation                                      │   │
│  │  - Action Routing (struts-config.xml)                  │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                 │                                │
│                                 ↓                                │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                  Action Layer                            │   │
│  │                                                          │   │
│  │  ┌───────────────┐          ┌────────────────────┐      │   │
│  │  │ SampleAction  │          │   UserAction       │      │   │
│  │  │               │          │                    │      │   │
│  │  │ - execute()   │          │ - saveUser()       │      │   │
│  │  │               │          │ - listUsers()      │      │   │
│  │  │               │          │ - JSON responses   │      │   │
│  │  └───────────────┘          └────────────────────┘      │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                 │                                │
│                                 ↓                                │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                   DAO Layer (Data Access)                │   │
│  │                                                          │   │
│  │  ┌─────────────────────────────────────────────────┐    │   │
│  │  │  UserDAO Interface                              │    │   │
│  │  │  ┌────────────────────────────────────────┐     │    │   │
│  │  │  │  UserDAOImpl (Hibernate)               │     │    │   │
│  │  │  │                                        │     │    │   │
│  │  │  │  - save(User)                         │     │    │   │
│  │  │  │  - update(User)                       │     │    │   │
│  │  │  │  - delete(User)                       │     │    │   │
│  │  │  │  - findById(Long)                     │     │    │   │
│  │  │  │  - findAll()                          │     │    │   │
│  │  │  │  - findByUsername(String)             │     │    │   │
│  │  │  └────────────────────────────────────────┘     │    │   │
│  │  └─────────────────────────────────────────────────┘    │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                 │                                │
│                                 ↓                                │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              Hibernate 3.6.10 (ORM Layer)                │   │
│  │                                                          │   │
│  │  ┌────────────────────────────────────────────────┐      │   │
│  │  │  HibernateUtil                                │      │   │
│  │  │  - SessionFactory management                  │      │   │
│  │  │  - Session lifecycle                          │      │   │
│  │  └────────────────────────────────────────────────┘      │   │
│  │                                                          │   │
│  │  ┌────────────────────────────────────────────────┐      │   │
│  │  │  Entity Model                                 │      │   │
│  │  │                                               │      │   │
│  │  │  User.java ←→ User.hbm.xml                   │      │   │
│  │  │  (POJO)        (XML Mapping)                 │      │   │
│  │  └────────────────────────────────────────────────┘      │   │
│  │                                                          │   │
│  │  Configuration: hibernate.cfg.xml                       │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
                                 │
                                 │ JDBC
                                 ↓
┌─────────────────────────────────────────────────────────────────┐
│                       MySQL 5.7 Database                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  Database: legacy_db                                    │    │
│  │                                                         │    │
│  │  Tables:                                               │    │
│  │  - users (id, username, email, password, timestamps)   │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

## 🔄 Request Flow Example

### AJAX Request Flow (users.jsp → UserAction → Hibernate → MySQL)

```
1. USER ACTION (Browser)
   │
   └─→ jQuery AJAX POST to /user/save.do
       {username: "john", email: "john@example.com", password: "pass123"}

2. SERVLET CONTAINER (Tomcat)
   │
   ├─→ HibernateSessionFilter (before)
   │   └─→ Prepare Hibernate session
   │
   ├─→ Struts ActionServlet
   │   └─→ Parse request, route to UserAction
   │
   └─→ UserAction.saveUser()
       │
       ├─→ Create User entity object
       │
       └─→ UserDAOImpl.save(user)
           │
           ├─→ HibernateUtil.getSessionFactory()
           │
           ├─→ session.beginTransaction()
           │
           ├─→ session.save(user)  [ORM Magic happens here]
           │   │
           │   └─→ Hibernate generates SQL:
           │       INSERT INTO users (username, email, password, created_at, updated_at)
           │       VALUES ('john', 'john@example.com', 'pass123', NOW(), NOW())
           │
           ├─→ transaction.commit()
           │   │
           │   └─→ MySQL executes INSERT statement
           │
           └─→ session.close()

3. RESPONSE
   │
   ├─→ UserAction returns JSON response:
   │   {"success": true, "message": "User saved successfully"}
   │
   ├─→ HibernateSessionFilter (after)
   │   └─→ Cleanup any open sessions
   │
   └─→ jQuery AJAX success callback
       └─→ Update UI with new user data
```

## 📊 Data Flow Patterns

### Pattern 1: Traditional Struts Form Submission
```
JSP Form → Struts ActionForm → Struts Action → Forward to JSP
(sample.jsp uses this pattern)
```

### Pattern 2: AJAX + JSON (Modern Approach)
```
jQuery AJAX → Struts Action → DAO → Hibernate → MySQL
             ← JSON Response ←
(users.jsp uses this pattern)
```

## 🔑 Key Components Integration

### Component Communication

```
┌─────────────┐     uses      ┌──────────────┐
│   jQuery    │ ────────────→ │    Struts    │
│   (Client)  │               │   Actions    │
└─────────────┘               └──────────────┘
                                      │
                                      │ calls
                                      ↓
                              ┌──────────────┐
                              │     DAO      │
                              │ (UserDAOImpl)│
                              └──────────────┘
                                      │
                                      │ uses
                                      ↓
                              ┌──────────────┐
                              │  Hibernate   │
                              │ SessionFactory│
                              └──────────────┘
                                      │
                                      │ JDBC
                                      ↓
                              ┌──────────────┐
                              │    MySQL     │
                              └──────────────┘
```

## 🛠️ Configuration Files

```
hibernate.cfg.xml
├── Database Connection
│   ├── Driver: com.mysql.jdbc.Driver
│   ├── URL: jdbc:mysql://mysql:3306/legacy_db
│   └── Credentials: legacy_user/legacy_pass
│
├── Hibernate Settings
│   ├── Dialect: MySQL5Dialect
│   ├── DDL: auto (update)
│   └── Show SQL: true
│
└── Mappings
    └── User.hbm.xml

struts-config.xml
├── Form Beans
│   └── sampleForm
│
└── Action Mappings
    ├── /sample → SampleAction
    ├── /user/save → UserAction (parameter=action=save)
    └── /user/list → UserAction (parameter=action=list)

web.xml
├── Listeners
│   └── HibernateListener (init/destroy SessionFactory)
│
├── Filters
│   └── HibernateSessionFilter (session management)
│
└── Servlets
    └── Struts ActionServlet
```

## 📦 Build & Deploy Process

```
Source Code (Java 1.5)
        │
        ↓
   [ant compile]
        │
        ↓
   Class Files
        │
        ↓
    [ant war]
        │
        ↓
  legacy-app.war
        │
        ↓
[Deploy to Tomcat]
        │
        ↓
Running Application
(http://localhost:8081/legacy-app)
```

## 🎯 Technology Versions (All Java 5 Compatible)

- **Java**: 1.5.0_22 (J2SE 5.0)
- **Struts**: 1.3.10
- **Hibernate**: 3.6.10.Final
- **jQuery**: 1.12.4
- **MySQL**: 5.7
- **Tomcat**: 5.5
- **Ant**: 1.6.5

---

This architecture represents a **legacy-modern hybrid** approach:
- **Legacy**: Java 5, Struts 1.x, Ant build, XML configs
- **Modern**: AJAX, JSON, ORM, responsive UI

Perfect for maintaining and enhancing legacy Java applications! 🎉
