# Java 5 Legacy Struts Application

> **� Just Cloned This Repo?** Start with [📋 Post-Clone Setup Guide](./README-SETUP-GUIDE.md) for complete instructions!

> **�📖 Complete Documentation**: See [docs/INDEX.md](./docs/INDEX.md) for comprehensive guides on setup, architecture, and development.

## ⚠️ First-Time Setup Required

**Before starting the Dev Container**, you must complete post-clone setup:

1. **📥 Download JDK Binary** (Required):
   - File: `jdk-1_5_0_22-linux-amd64-rpm.bin`
   - Source: [Oracle Java Archive](https://www.oracle.com/java/technologies/java-archive-javase5-downloads.html)
   - Location: Place in `.devcontainer/` directory

2. **📚 Download Libraries** (Optional for Hibernate):
   - Run: `./download-hibernate-libs.sh`
   - Or download manually (see `lib/HIBERNATE_LIBRARIES.md`)

**👉 See [📋 Post-Clone Setup Guide](./README-SETUP-GUIDE.md) for detailed step-by-step instructions.**

---

## 🚀 Quick Start

### Prerequisites

- **Docker** and **Docker Compose** installed
- **VS Code** with "Dev Containers" extension
- **JDK 1.5.0_22 binary** downloaded (see setup guide above)

### Starting the Dev Container

```bash
# 1. Verify JDK binary is in place
./.devcontainer/check-setup.sh

# 2. Open in VS Code
code .

# 3. Reopen in Container
# Press Ctrl+Shift+P → "Dev Containers: Reopen in Container"

# 4. Wait for container to build (2-5 minutes first time)
```

## 📋 Project Overview

This is a comprehensive development environment for **legacy Java applications** using:
- **Java 1.5.0_22 (J2SE 5.0)** - Legacy Java runtime
- **Apache Struts 1.x** - MVC web framework
- **Hibernate 3.6.x** - ORM for database operations (optional)
- **jQuery 1.12.4** - Frontend JavaScript library (optional)
- **Apache Ant 1.6.5** - Build automation
- **MySQL 5.7** - Relational database
- **Docker Dev Container** - Isolated development environment

**Perfect for:**
- Maintaining legacy enterprise applications
- Learning classic Java web development
- Modernizing old Struts applications incrementally

## 🛠️ Technology Stack

### Core Technologies

| Component | Version | Purpose |
|-----------|---------|---------|
| **Java** | 1.5.0_22 (J2SE 5.0) | Legacy Java runtime |
| **Struts** | 1.3.10 | MVC web framework |
| **Ant** | 1.6.5 | Build automation |
| **MySQL** | 5.7 | Relational database |
| **Tomcat** | 8.5-jre8 | Servlet container |

### Optional Enhancements

| Library | Version | Purpose |
|---------|---------|---------|
| **Hibernate** | 3.6.10.Final | ORM framework |
| **jQuery** | 1.12.4 | Frontend JavaScript |
| **phpMyAdmin** | 5.1 | Database admin UI |

### Key Downloads

- **Struts 1.3.10**: [Apache Struts Archive](https://archive.apache.org/dist/struts/1.3.10/)
- **Hibernate**: Via `./download-hibernate-libs.sh` script
- **JDK**: [Oracle Java Archive](https://www.oracle.com/java/technologies/java-archive-javase5-downloads.html)

<details>
<summary><b>📦 Struts Dependencies (12 JARs included)</b></summary>

| Library | Version | Purpose |
|---------|---------|----------|
| struts-core | 1.3.10 | Struts framework core |
| struts-taglib | 1.3.10 | Struts JSP tag libraries |
| servlet-api | 2.5 | Java Servlet API |
| jsp-api | 2.1 | JavaServer Pages API |
| commons-beanutils | 1.8.0 | Bean property utilities |
| commons-chain | 1.2 | Chain of Responsibility pattern |
| commons-digester | 1.8 | XML to Java object mapping |
| commons-fileupload | 1.1.1 | File upload functionality |
| commons-io | 1.1 | I/O utility classes |
| commons-logging | 1.0.4 | Logging abstraction |
| commons-validator | 1.3.1 | Form validation framework |
| oro | 2.0.8 | Regular expression engine |

</details>

---

## 🚀 Development Workflow

### 1️⃣ First Time Setup (After Cloning)

```bash
# Complete the post-clone setup
# See: README-SETUP-GUIDE.md for detailed instructions

# Quick summary:
# 1. Download JDK binary → place in .devcontainer/
# 2. Run: ./.devcontainer/check-setup.sh
# 3. (Optional) Run: ./download-hibernate-libs.sh
```

### 2️⃣ Start Dev Container

```bash
# Open in VS Code
code .

# Reopen in Container
# Ctrl+Shift+P → "Dev Containers: Reopen in Container"
```

### 3️⃣ Build and Deploy

```bash
# Inside Dev Container:

# Build the application
ant clean build

# Access application
curl http://localhost:8080/legacy-app/
# Or open: http://localhost:8080/legacy-app/
```

### 4️⃣ Development Cycle

```bash
# Edit → Build → Test → Repeat
# 1. Edit files in src/
# 2. Run: ant clean build
# 3. Test at: http://localhost:8080/legacy-app/
# 4. Repeat!
```

---

## 📁 Project Structure

<details>
<summary><b>Click to expand directory structure</b></summary>

```
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/
│   │   │       ├── action/     # Struts Actions
│   │   │       ├── form/       # Form Beans
│   │   │       ├── dao/        # Data Access Objects
│   │   │       ├── service/    # Business Logic
│   │   │       └── util/       # Utility Classes
│   │   ├── resources/          # Configuration Files
│   │   └── webapp/             # Web Application Files
│   │       ├── WEB-INF/
│   │       ├── css/
│   │       ├── js/
│   │       └── images/
│   └── test/
│       └── java/               # Test Classes
├── lib/                        # External Libraries
├── build/                      # Build Output (generated)
├── dist/                       # Distribution Files (generated)
├── docs/                       # Documentation
└── config/                     # Configuration Files
```

</details>

---

## 🏗️ Build Commands

### Essential Commands

```bash
# Full clean build
ant clean build

# Individual steps
ant clean          # Clean build artifacts
ant compile        # Compile Java sources
ant war            # Create WAR file
ant javadoc        # Generate API documentation
```

### Build Artifacts

After successful build:
- `dist/legacy-app.war` - Deployable WAR file
- `build/classes/` - Compiled Java classes
- `build/docs/javadoc/` - API documentation

---

## 🌐 Access Points

| Service | URL | Credentials |
|---------|-----|-------------|
| **Application** | http://localhost:8080/legacy-app/ | - |
| **Sample Form** | http://localhost:8080/legacy-app/sample.jsp | - |
| **phpMyAdmin** | http://localhost:8082/ | root / root |
| **API Docs** | http://localhost:8080/legacy-app/docs/javadoc/ | - |

### Database Connection

```properties
Host: localhost
Port: 3306
Database: legacy_db
User: legacy_user
Password: legacy_pass
Root Password: root
```

---

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose
- VS Code with Dev Containers extension
- **JDK 1.5.0_22 binary** (see [Setup Guide](./README-SETUP-GUIDE.md))

### Quick Verification

```bash
# After Dev Container starts:

# 1. Check Java and Ant
java -version    # → java version "1.5.0_22"
ant -version     # → Apache Ant 1.6.5

# 2. Check services
docker ps | grep -E "tomcat|mysql|phpmyadmin"

# 3. Build and test
ant clean build
curl http://localhost:8080/legacy-app/
```

---

---

## 📱 Sample Application

The project includes a working Struts demo:

| Page | URL | Description |
|------|-----|-------------|
| Homepage | `/` | Welcome page with tech overview |
| Sample Form | `/sample.jsp` | Struts form demonstration |
| Success Page | `/success.jsp` | Form processing results |

### Key Components
### Key Components

- `SampleAction.java` - Handles form submission
- `SampleForm.java` - Form bean for data binding
- `struts-config.xml` - Struts configuration
- `ApplicationResources.properties` - i18n resources

---

## 🔧 Troubleshooting

<details>
<summary><b>Common Issues & Solutions</b></summary>

### Build Errors

**"package does not exist" errors:**
```bash
# Verify all JARs in lib/
ls -la lib/*.jar | wc -l  # Should show 12+

# Re-download if missing
./download-hibernate-libs.sh
```

**Ant compatibility issues:**
```bash
# This project uses Ant 1.6.5 compatible syntax
# Avoid modern Ant features
ant -version  # Verify: Apache Ant 1.6.5
```

### Deployment Issues

**Application not accessible:**
```bash
# Check WAR file
ls -la dist/legacy-app.war

# Verify Tomcat
curl -I http://localhost:8080/

# Check logs
docker logs legacy-tomcat | tail -50
```

**Port conflicts:**
```bash
# Check port usage
sudo lsof -i :8080
sudo lsof -i :3306

# Kill conflicting processes
sudo fuser -k 8080/tcp
```

### Dev Container Issues

**Services not starting:**
```bash
# Check Docker
docker ps

# Restart services
docker compose -f .devcontainer/compose.services.yaml restart

# Rebuild container
# VS Code: Ctrl+Shift+P → "Dev Containers: Rebuild Container"
```

**JDK binary not found:**
```bash
# Verify JDK location
ls -la .devcontainer/jdk-*.bin

# Run setup check
./.devcontainer/check-setup.sh
```

### Verification Steps

```bash
# 1. Environment
java -version    # → 1.5.0_22
ant -version     # → 1.6.5

# 2. Services
docker ps | grep -E "tomcat|mysql|phpmyadmin"

# 3. Build & Deploy
ant clean build
curl http://localhost:8080/legacy-app/

# 4. Database
curl http://localhost:8082/  # phpMyAdmin
```

**� For more help, see:**
- [📋 Setup Guide](./README-SETUP-GUIDE.md) - Post-clone setup
- [🔧 Troubleshooting](./docs/TROUBLESHOOTING.md) - Detailed solutions
- [📖 Documentation Index](./docs/INDEX.md) - Complete docs

</details>

---

---

## 📚 Documentation

### 📖 Primary Documentation

| Document | Description |
|----------|-------------|
| [� Post-Clone Setup](./README-SETUP-GUIDE.md) | **Start here after cloning** |
| [📖 Documentation Index](./docs/INDEX.md) | Complete documentation guide |
| [🏗️ Architecture](./docs/ARCHITECTURE.md) | System design and architecture |
| [⚡ Quick Reference](./docs/QUICK_REFERENCE.md) | Daily development commands |
| [🔧 Troubleshooting](./docs/TROUBLESHOOTING.md) | Common issues and solutions |
| [� jQuery & Hibernate](./docs/JQUERY_HIBERNATE_SETUP.md) | Integration guides |

### 🌐 External Resources

- [Struts 1.x Documentation](https://struts.apache.org/archive.html)
- [Java 1.5 Documentation](https://docs.oracle.com/javase/1.5.0/docs/)
- [Apache Ant Manual](https://ant.apache.org/manual/)
- [Hibernate 3.6 Reference](https://docs.jboss.org/hibernate/orm/3.6/reference/en-US/html_single/)
- [jQuery 1.12.4 API](https://api.jquery.com/)

---

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes (ensure Java 5 compatibility)
4. Test thoroughly (`ant clean build`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

**Development Guidelines:**
- Maintain Java 5 compatibility
- Follow existing code style
- Test with Ant 1.6.5
- Update documentation as needed

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author & Contact

**Created by:** [@shinyay](https://github.com/shinyay)

**Connect:**
- 🐦 Twitter: [@yanashin18618](https://twitter.com/yanashin18618)
- 🐘 Mastodon: [@yanashin@mastodon.social](https://mastodon.social/@yanashin)
- 💼 GitHub: [github.com/shinyay](https://github.com/shinyay)

---

## ⭐ Support

If this project helps you maintain your legacy Java applications, please consider:
- ⭐ Starring this repository
- 🐛 Reporting issues
- 📝 Contributing improvements
- 📢 Sharing with others working on legacy systems

---

<div align="center">

**🚀 Ready to start developing?**

[📋 Setup Guide](./README-SETUP-GUIDE.md) • [📖 Documentation](./docs/INDEX.md) • [🔧 Troubleshooting](./docs/TROUBLESHOOTING.md)

---

**Built with ❤️ for Legacy Java Development**

</div>
