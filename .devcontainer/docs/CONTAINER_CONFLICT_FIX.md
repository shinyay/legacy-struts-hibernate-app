# Dev Container Conflict Resolution

## Problem
When attempting to start the Dev Container, the following error occurred:

```
Error response from daemon: Conflict. The container name "/java5-legacy-dev"
is already in use by container "851dda56ed4fd49c7f9df2237c1acb13df5289811adeda59b2871b6b7e93d7df".
You have to remove (or rename) that container to be able to reuse that name.
```

## Root Cause
An old Dev Container with the name `java5-legacy-dev` was still present in Docker (in "Exited" state), preventing VS Code from creating a new container with the same name. This happened because:

1. A previous Dev Container session was not properly cleaned up
2. The container existed from an older build (2 weeks ago)
3. The `--remove-existing-container` flag couldn't remove it because it was from a different image

## Solution Applied

### 1. Immediate Fix
Removed the conflicting container:
```bash
docker rm -f java5-legacy-dev
```

### 2. Preventive Fix
Updated the cleanup script (`.devcontainer/scripts/cleanup-old-containers.sh`) to automatically remove old Dev Containers before starting a new one.

The script now includes:
```bash
# Remove old java5-legacy-dev container if it exists
if docker ps -a --filter "name=java5-legacy-dev" --format "{{.Names}}" 2>/dev/null | grep -q "java5-legacy-dev"; then
    docker rm -f java5-legacy-dev 2>/dev/null || true
fi
```

## How to Start Dev Container Now

1. **Reopen in Container**: Use VS Code's "Dev Containers: Reopen in Container" command
2. The `initializeCommand` in `devcontainer.json` will automatically run the cleanup script
3. The Dev Container should start successfully

## Prevention for Future

The cleanup script now runs automatically as part of the `initializeCommand` in `devcontainer.json`:

```json
"initializeCommand": "bash -c 'echo \"Starting host services for Dev Container...\" && bash ${localWorkspaceFolder}/.devcontainer/scripts/cleanup-old-containers.sh && docker compose -f ${localWorkspaceFolder}/.devcontainer/compose.services.yaml up -d --remove-orphans tomcat mysql phpmyadmin && echo \"Host services started\"'"
```

This ensures old containers are cleaned up before each Dev Container startup.

## Verification

After the fix, you should see:
- No container name conflicts
- Dev Container starts successfully
- All services accessible:
  - Application Dev Container (internal)
  - Tomcat: http://localhost:8080 (host services)
  - MySQL: localhost:3306
  - phpMyAdmin: http://localhost:8082

## Date Fixed
October 26, 2025
