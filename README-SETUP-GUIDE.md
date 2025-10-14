# 📋 Post-Clone Setup Guide

> **Complete step-by-step instructions for setting up this Java 5 Legacy Development Environment after cloning from GitHub**

## 🎯 Overview

Due to file size, licensing restrictions, and best practices, certain files are excluded from the Git repository via [`.gitignore`](.gitignore). This guide walks you through setting up these required files after cloning.

## ⏱️ Expected Setup Time

| Task | Time Required |
|------|---------------|
| Download JDK binary | 2-5 minutes |
| Download Hibernate JARs (optional) | 1-2 minutes |
| Dev Container first build | 2-5 minutes |
| Verification & first app build | 1 minute |
| **Total** | **~10-15 minutes** |

---

## 🚨 Critical Setup Steps

### Step 1: Download JDK 1.5.0_22 Binary ⚠️ **REQUIRED**

This is the **most critical step** - nothing will work without it!

#### Why is it excluded from Git?
- File size: ~51MB (too large for Git repositories)
- Oracle licensing restrictions (cannot redistribute)
- Binary distribution file (security best practice)

#### How to download:

1. **Visit Oracle Java Archive**:
   - Go to: https://www.oracle.com/java/technologies/java-archive-javase5-downloads.html
   - You may need to accept Oracle's license agreement

2. **Download the correct file**:
   ```
   File: jdk-1_5_0_22-linux-amd64-rpm.bin
   Platform: Linux x64 - RPM based
   Size: ~51 MB
   ```

3. **Place the file in the correct location**:
   ```bash
   # From your downloads folder
   cp ~/Downloads/jdk-1_5_0_22-linux-amd64-rpm.bin .devcontainer/

   # Verify it's in the right place
   ls -lh .devcontainer/jdk-1_5_0_22-linux-amd64-rpm.bin
   ```

4. **Verify the setup**:
   ```bash
   # Run the validation script
   chmod +x .devcontainer/check-setup.sh
   ./.devcontainer/check-setup.sh

   # Expected output:
   # ✅ JDK binary file found
   # ✅ File is readable
   # ✅ Setup validation PASSED
   ```

#### Troubleshooting:

**Can't find the file on Oracle's website?**
- Try searching for "jdk 1.5.0_22 download"
- Look for "Java SE 5.0" or "J2SE 5.0" sections
- Alternative: Search for archived versions on archive.org (not recommended for production)

**File permission issues?**
```bash
chmod 644 .devcontainer/jdk-1_5_0_22-linux-amd64-rpm.bin
```

---

### Step 2: Download Hibernate Libraries (Optional)

If you plan to use Hibernate ORM with this application, download the required JAR files.

#### Why are JARs excluded from Git?
- Binary files (increases repository size)
- Dependency management best practice
- License distribution considerations
- Easy to download from official sources

#### Option A: Automated Download (Recommended)

Use the provided download script:

```bash
# Make the script executable
chmod +x download-hibernate-libs.sh

# Run the download script
./download-hibernate-libs.sh
```

**What it downloads**:
- Hibernate Core 3.6.10.Final
- Hibernate JPA 2.0 API
- Required dependencies (antlr, dom4j, javassist, jta, slf4j)
- MySQL Connector/J 5.1.49
- Commons Collections 3.2.1

**Files are saved to**: `lib/` directory

#### Option B: Manual Download

If the script doesn't work, download manually following the guide in:
- [`lib/HIBERNATE_LIBRARIES.md`](lib/HIBERNATE_LIBRARIES.md)

**Manual steps summary**:
1. Download each JAR from Maven Central or official sources
2. Place all JARs in the `lib/` directory
3. Verify: `ls lib/*.jar | wc -l` should show expected count

#### Verification:

```bash
# Check if Hibernate libraries are present
find lib/ -name "*hibernate*" -type f

# Expected output (if using Hibernate):
# lib/hibernate-core-3.6.10.Final.jar
# lib/hibernate-jpa-2.0-api-1.0.0.Final.jar
# ... (and other dependencies)
```

---

### Step 3: Verify Complete Setup

Run comprehensive verification:

```bash
# 1. Check JDK binary (CRITICAL)
./.devcontainer/check-setup.sh

# 2. Check project structure
ls -la .devcontainer/jdk-1_5_0_22-linux-amd64-rpm.bin
ls -la lib/  # Should show JAR files if downloaded

# 3. Verify Git status (should be clean)
git status
# Expected: nothing to commit (JDK and JARs are ignored)
```

**✅ Setup Complete Checklist**:
- [ ] JDK binary in `.devcontainer/jdk-1_5_0_22-linux-amd64-rpm.bin`
- [ ] Validation script passes (`check-setup.sh` shows success)
- [ ] Hibernate JARs in `lib/` (if using ORM)
- [ ] Git status is clean (no untracked binary files)

---

## 🚀 Starting the Dev Container

Now that setup is complete, start the development environment:

### Using VS Code (Recommended)

```bash
# 1. Open the project in VS Code
code .

# 2. When prompted, click "Reopen in Container"
# OR press: Ctrl+Shift+P (Cmd+Shift+P on Mac)
# Then select: "Dev Containers: Reopen in Container"

# 3. Wait for the container to build (first time: 2-5 minutes)
# The container will:
#   - Install Java 5 from the binary you downloaded
#   - Configure Ant 1.6.5
#   - Start external services (Tomcat, MySQL, phpMyAdmin)
#   - Set up the development environment

# 4. Once complete, you'll see the Dev Container terminal
```

### Using Docker Compose (Alternative)

```bash
# Build and start the dev container manually
docker compose -f .devcontainer/compose.dev.yaml build
docker compose -f .devcontainer/compose.dev.yaml up -d

# Enter the container
docker exec -it java5-legacy-dev bash
```

### First Build Verification

Once inside the Dev Container:

```bash
# 1. Verify Java environment
java -version
# Expected: java version "1.5.0_22"

ant -version
# Expected: Apache Ant 1.6.5

# 2. Build the application
ant clean build

# 3. Verify build artifacts
ls -la dist/legacy-app.war
# Expected: WAR file created (~7-10KB)

# 4. Access the application
curl http://localhost:8080/legacy-app/
# OR open browser: http://localhost:8080/legacy-app/
```

---

## 📁 Understanding Excluded Files

Files excluded from Git (defined in [`.gitignore`](.gitignore)):

### 🔴 Required Files (Must Download/Setup)

| File Pattern | Location | Required? | Setup Method |
|--------------|----------|-----------|--------------|
| `*.bin`, `jdk-*.bin` | `.devcontainer/` | **YES** | Download from Oracle |
| `*.jar` | `lib/` | Optional | Run `download-hibernate-libs.sh` |

### 🟡 Generated Files (Auto-created by Build)

| Directory | Purpose | Created By |
|-----------|---------|------------|
| `build/` | Compiled classes | `ant compile` |
| `dist/` | WAR files | `ant war` |
| `build/docs/javadoc/` | API documentation | `ant javadoc` |

### 🟢 Runtime Files (Auto-created by Container)

| File/Directory | Purpose |
|----------------|---------|
| `.vscode-server*/` | VS Code server files |
| `.bash_history` | Shell history |
| `.m2/`, `.gradle/` | Build tool caches |
| `.devcontainer/*.Marker` | Dev Container lifecycle markers |

### 🔵 IDE & OS Files (Not Needed in Repo)

| File Pattern | Purpose |
|--------------|---------|
| `.vscode/`, `.idea/` | IDE configurations |
| `.DS_Store`, `Thumbs.db` | OS metadata |
| `*.swp`, `*.swo` | Vim swap files |
| `*.log` | Log files |

---

## 🎯 Quick Start Summary

After cloning, follow these commands:

```bash
# 1. Navigate to project
cd docker-java5-for-legacy-app

# 2. Download JDK binary from Oracle (manual step - see above)
# Place in: .devcontainer/jdk-1_5_0_22-linux-amd64-rpm.bin

# 3. Verify JDK setup
./.devcontainer/check-setup.sh

# 4. Download Hibernate libraries (optional)
./download-hibernate-libs.sh

# 5. Open in VS Code and start Dev Container
code .
# Then: Ctrl+Shift+P → "Dev Containers: Reopen in Container"

# 6. Inside Dev Container - Build and test
java -version
ant clean build
curl http://localhost:8080/legacy-app/
```

---

## 🌐 Access Points After Setup

Once the Dev Container is running:

| Service | URL | Purpose |
|---------|-----|---------|
| **Application** | http://localhost:8080/legacy-app/ | Main Struts application |
| **Sample Form** | http://localhost:8080/legacy-app/sample.jsp | Demo form |
| **phpMyAdmin** | http://localhost:8082/ | Database management |
| **API Docs** | http://localhost:8080/legacy-app/docs/javadoc/ | Generated JavaDoc |

**MySQL Connection**:
- Host: `localhost`
- Port: `3306`
- Database: `legacy_db`
- User: `legacy_user`
- Password: `legacy_pass`
- Root Password: `root`

---

## 🔧 Troubleshooting Setup Issues

### Issue: "JDK binary not found"

**Symptoms**:
```
❌ JDK binary file not found
ERROR: Please place jdk-1_5_0_22-linux-amd64-rpm.bin in .devcontainer/
```

**Solution**:
1. Verify you downloaded the correct file: `jdk-1_5_0_22-linux-amd64-rpm.bin`
2. Check the file location: `ls -la .devcontainer/jdk-*.bin`
3. Ensure exact filename (no extra extensions like `.bin.1`)
4. Re-download if necessary from Oracle Java Archive

### Issue: "Dev Container fails to build"

**Symptoms**:
- Container build errors during initialization
- "Cannot install JDK" messages

**Solution**:
```bash
# 1. Verify JDK binary exists and is readable
ls -lh .devcontainer/jdk-1_5_0_22-linux-amd64-rpm.bin
chmod 644 .devcontainer/jdk-1_5_0_22-linux-amd64-rpm.bin

# 2. Rebuild container from scratch
# In VS Code: Ctrl+Shift+P → "Dev Containers: Rebuild Container"

# 3. Check Docker has enough resources (at least 2GB RAM, 10GB disk)
docker system df
docker system prune  # if needed
```

### Issue: "Hibernate libraries not found"

**Symptoms**:
- Compilation errors about missing Hibernate classes
- `lib/` directory is empty or has only some JARs

**Solution**:
```bash
# Re-run the download script
./download-hibernate-libs.sh

# Or download manually - see lib/HIBERNATE_LIBRARIES.md
cat lib/HIBERNATE_LIBRARIES.md

# Verify download
find lib/ -name "*.jar" | sort
```

### Issue: "Services not accessible"

**Symptoms**:
- Cannot access http://localhost:8080/legacy-app/
- Connection refused errors

**Solution**:
```bash
# Check if services are running
docker ps | grep -E "tomcat|mysql|phpmyadmin"

# Restart services if needed
docker compose -f .devcontainer/compose.services.yaml restart

# Check service logs
docker logs legacy-tomcat
docker logs legacy-mysql
```

### Issue: "Port already in use"

**Symptoms**:
```
Error: Port 8080 is already allocated
Error: Port 3306 is already allocated
```

**Solution**:
```bash
# Check what's using the ports
sudo lsof -i :8080
sudo lsof -i :3306

# Option 1: Stop conflicting services
sudo systemctl stop tomcat    # if system Tomcat running
sudo systemctl stop mysql     # if system MySQL running

# Option 2: Change ports in .devcontainer/compose.services.yaml
# Edit ports to use different values (e.g., 8081:8080)
```

---

## 📚 Additional Resources

### Documentation
- [Main README](README.md) - Project overview
- [Documentation Index](docs/INDEX.md) - Complete documentation guide
- [JDK Setup Guide](.devcontainer/SETUP_REQUIRED.md) - Detailed JDK installation
- [Troubleshooting Guide](docs/TROUBLESHOOTING.md) - Common issues and solutions
- [Architecture Guide](docs/ARCHITECTURE.md) - System design and structure

### External Resources
- [Oracle Java Archive](https://www.oracle.com/java/technologies/java-archive-javase5-downloads.html) - Download JDK
- [Apache Struts Archive](https://archive.apache.org/dist/struts/) - Struts documentation
- [Hibernate 3.6 Reference](https://docs.jboss.org/hibernate/orm/3.6/reference/en-US/html_single/) - ORM guide
- [Maven Central](https://search.maven.org/) - Download JAR dependencies

### Getting Help

1. **Check existing documentation**: See [docs/INDEX.md](docs/INDEX.md)
2. **Review troubleshooting**: See [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)
3. **Verify setup**: Run `.devcontainer/check-setup.sh`
4. **Check Git history**: `git log --oneline` for recent changes
5. **Open an issue**: If problems persist, create a GitHub issue with:
   - Error messages
   - Output of `check-setup.sh`
   - Docker version: `docker --version`
   - OS information: `uname -a`

---

## ✅ Setup Completion Checklist

Use this checklist to verify your setup is complete:

- [ ] Repository cloned successfully
- [ ] JDK binary downloaded and placed in `.devcontainer/`
- [ ] JDK setup validation passes (`.devcontainer/check-setup.sh`)
- [ ] Hibernate libraries downloaded (if using ORM)
- [ ] Dev Container opens in VS Code
- [ ] Java 1.5.0_22 verified (`java -version`)
- [ ] Ant 1.6.5 verified (`ant -version`)
- [ ] External services running (Tomcat, MySQL, phpMyAdmin)
- [ ] Application builds successfully (`ant clean build`)
- [ ] WAR file created (`ls dist/legacy-app.war`)
- [ ] Application accessible at http://localhost:8080/legacy-app/
- [ ] Database admin accessible at http://localhost:8082/
- [ ] Sample Struts form works

**🎉 If all items are checked, your setup is complete and ready for development!**

---

## 🚀 Next Steps

Now that your environment is set up:

1. **Explore the sample application**:
   - Visit http://localhost:8080/legacy-app/
   - Try the sample form: http://localhost:8080/legacy-app/sample.jsp

2. **Read the documentation**:
   - Start with [docs/INDEX.md](docs/INDEX.md)
   - Check [docs/QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md) for daily development tasks

3. **Start developing**:
   - Edit Java files in `src/main/java/`
   - Modify JSPs in `src/main/webapp/`
   - Run `ant clean build` to rebuild
   - Test your changes immediately

4. **Learn the workflow**:
   - Review [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for system design
   - Check [docs/JQUERY_HIBERNATE_SETUP.md](docs/JQUERY_HIBERNATE_SETUP.md) for integrations

**Happy coding with Java 5 and Struts! 🎯**
