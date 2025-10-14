# Troubleshooting Guide

## Dev Container Issues

### Docker Image Not Found (Manifest Error)

**Symptom:**
Dev Container initialization fails with:
```
✘ tomcat Error     manifest for tomcat:5.5.36-jdk8 not found
Error response from daemon: manifest for tomcat:5.5.36-jdk8 not found: manifest unknown
```

**Root Cause:**
1. The specified Docker image tag doesn't exist in Docker Hub registry
2. Tomcat 5.5 is very old (discontinued in 2012) and doesn't have official Docker images with JDK 8
3. JDK 8 was released in 2014, after Tomcat 5.5 was already end-of-life

**Solution:**
Updated `compose.services.yaml` to use `tomcat:8.5-jre8` instead:
- Tomcat 8.5 is maintained and has official Docker images
- JRE 8 is compatible with Java 5 compiled applications
- Provides better security and stability than ancient Tomcat 5.5

**Prevention:**
- Always verify Docker image availability at https://hub.docker.com before using in compose files
- Use maintained, official images when possible
- Remove obsolete `version` attribute from Docker Compose files (it's deprecated)

### Ant Build Attribute Not Supported

**Symptom:**
Build fails with:
```
BUILD FAILED
/app/build.xml:20: The <fileset> type doesn't support the "erroronmissingdir" attribute.
```

**Root Cause:**
The `erroronmissingdir` attribute was added in Ant 1.8.0, but the Java 5 environment uses Ant 1.7.x which doesn't support this attribute.

**Solution:**
Removed `erroronmissingdir="false"` from all `<fileset>` elements in `build.xml`. The build now relies on:
- `failonerror="false"` on `<copy>` tasks to handle missing directories gracefully
- Proper directory creation in `init` target
- `.gitkeep` files to ensure required directories exist

**Prevention:**
- Use only Ant 1.7-compatible features in build.xml
- Test build scripts with the actual Ant version used in the dev environment
- Document Ant version requirements

### Container Exits with Code 137

**Symptom:**
Dev Container builds successfully but exits with code 137 (killed by signal) shortly after starting.

**Root Cause:**
1. The `initializeCommand` was using the deprecated `docker-compose` command instead of `docker compose`
2. Non-existent VS Code extensions in devcontainer.json were causing initialization issues

**Solution:**
1. Updated `initializeCommand` to use `docker compose` (space instead of hyphen)
2. Removed non-existent extensions:
   - `gabrielgrinberg.ant-gradle-xml-formatter`
   - `ithildir.java-properties`
   - `ms-vscode.vscode-json`

**Prevention:**
- Always use `docker compose` command in Dev Container configurations
- Verify VS Code extension IDs exist before adding them to devcontainer.json

### Build Failure: "WEB-INF/lib not found"

**Symptom:**
Dev Container builds successfully but fails during `postCreateCommand` with:
```
BUILD FAILED
/app/build.xml:60: /app/src/main/webapp/WEB-INF/lib not found
```

**Root Cause:**
The Ant build script references the `src/main/webapp/WEB-INF/lib` directory in its classpath configuration, but this directory may not exist if no JAR dependencies have been added yet.

**Solution:**
The directory structure has been fixed with:
1. Created `src/main/webapp/WEB-INF/lib/` with `.gitkeep` file
2. Updated `build.xml` with `erroronmissingdir="false"` on fileset definitions
3. Build now handles missing library directories gracefully

**Prevention:**
When adding new JAR dependencies, place them in:
- `lib/` - Project-level libraries (shared across builds)
- `src/main/webapp/WEB-INF/lib/` - Web application libraries (included in WAR)

### Missing JDK Binary

**Symptom:**
Docker build fails with error about missing `jdk-1_5_0_22-linux-amd64-rpm.bin`

**Solution:**
See [`.devcontainer/SETUP_REQUIRED.md`](../.devcontainer/SETUP_REQUIRED.md) for detailed instructions on downloading and placing the JDK binary.

Quick steps:
1. Download JDK from Oracle Java Archive
2. Place in `.devcontainer/` directory
3. Run `.devcontainer/check-setup.sh` to validate
4. Rebuild Dev Container

## Build Issues

### Project Documentation Deleted

**Symptom:**
After running `ant clean build`, the `docs/` folder is empty or deleted.

**Root Cause:**
Earlier versions of `build.xml` incorrectly used `docs/` for JavaDoc output and deleted it during clean.

**Solution:**
Updated `build.xml` to:
- Use `build/docs/javadoc` for JavaDoc output
- Remove `docs/` from clean target
- Project documentation in `docs/` folder is now preserved

### Missing Dependencies

**Symptom:**
Compilation errors about missing classes or packages.

**Root Cause:**
JAR dependencies not downloaded or not in correct location.

**Solution:**
1. Check if Hibernate libraries are in `lib/` folder
2. Run `./download-hibernate-libs.sh` to download Hibernate JARs
3. Ensure `lib/` folder has all required dependencies
4. Run `ant clean build` to rebuild

## Runtime Issues

### Tomcat Port Already in Use

**Symptom:**
Tomcat fails to start with "Port 8081 already in use"

**Solution:**
1. Check if another instance is running: `docker ps`
2. Stop conflicting container: `docker stop <container-id>`
3. Or change port in `.devcontainer/compose.services.yaml`

### Database Connection Errors

**Symptom:**
Application can't connect to MySQL database.

**Solution:**
1. Verify MySQL service is running: `docker ps | grep mysql`
2. Check connection details in `src/main/resources/hibernate.cfg.xml`
3. Ensure database is created: Access phpMyAdmin at http://localhost:8082
4. Default credentials: root/password

## Getting Help

If you encounter other issues:

1. Check error logs in Dev Container terminal
2. Review `.devcontainer/README.md` for setup requirements
3. Consult documentation in `docs/INDEX.md`
4. Check `build.xml` for build configuration
5. Review Git history for recent changes that might have caused issues

## Useful Commands

### Inside Dev Container:
```bash
# Check Java version
java -version

# Clean and rebuild
ant clean build

# View build output
ls -la build/
ls -la dist/

# Check running services
docker ps
```

### On Host Machine:
```bash
# Validate JDK setup
./.devcontainer/check-setup.sh

# Rebuild Dev Container
# In VS Code: Ctrl+Shift+P -> "Dev Containers: Rebuild Container"

# View Docker logs
docker logs java5-legacy-dev
```
