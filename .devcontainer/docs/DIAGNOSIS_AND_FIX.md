# Dev Container phpMyAdmin Issue - Root Cause Analysis and Fix

## Problem Summary

Two phpMyAdmin containers were running simultaneously:
1. **`java5-phpmyadmin`** (old, running for 2 weeks) - blocking port 8082
2. **`legacy-phpmyadmin`** (current, from compose.services.yaml) - couldn't start due to port conflict

## Root Cause Analysis

After investigating your dev container configuration, **your current configuration is CORRECT**. The issue was caused by:

### The Real Problem: Docker Compose Auto-Naming

When you run `docker compose up` without specifying a project name, Docker Compose automatically generates container names using this pattern:
```
<project-directory-name>-<service-name>-<instance-number>
```

However, when you explicitly set `container_name:` in your compose file, it uses that exact name.

### What Likely Happened:

1. **Scenario A: Old Configuration**
   - You may have had an older version of the compose file that used `container_name: java5-phpmyadmin`
   - This container was started 2 weeks ago
   - You later updated the config to `container_name: legacy-phpmyadmin`
   - The old container kept running because it wasn't explicitly stopped

2. **Scenario B: Different Compose File**
   - There may have been another compose file (now deleted or in a different branch) that created `java5-phpmyadmin`
   - Or someone ran a manual docker command to create it

3. **Scenario C: Compose Project Name**
   - If compose was run from a directory named `java5`, it might have created containers with that prefix
   - But your explicit `container_name:` should override this

## Current Configuration Status: ✅ CORRECT

Your current files are properly configured:

### ✅ `.devcontainer/compose.services.yaml`
- Container name: `legacy-phpmyadmin` ✓
- Network: `legacy-network` ✓
- Properly depends on MySQL ✓

### ✅ `.devcontainer/devcontainer.json`
- Correctly starts services via `initializeCommand` ✓
- Uses proper compose file path ✓

### ✅ `.devcontainer/compose.dev.yaml`
- Dev container name: `java5-legacy-dev` ✓
- Uses host networking to access services ✓
- No phpMyAdmin defined here (correct - it's in compose.services.yaml) ✓

## How to Prevent This Issue

### Option 1: Add Cleanup Script (Recommended)

Create a script to clean up old containers before starting:

```bash
#!/bin/bash
# .devcontainer/scripts/cleanup-old-containers.sh

echo "Cleaning up old/orphaned containers..."

# Remove any old phpMyAdmin containers that don't match current config
docker ps -a --filter "name=phpmyadmin" --format "{{.Names}}" | while read container; do
    if [ "$container" != "legacy-phpmyadmin" ]; then
        echo "Removing old container: $container"
        docker rm -f "$container" || true
    fi
done

# Remove orphaned containers from old compose files
docker compose -f .devcontainer/compose.services.yaml down --remove-orphans

echo "Cleanup complete!"
```

### Option 2: Update devcontainer.json initializeCommand

Replace the current `initializeCommand` with one that includes cleanup:

```json
"initializeCommand": "bash -c 'echo \"Starting host services for Dev Container...\" && docker ps -a --filter \"name=phpmyadmin\" --format \"{{.Names}}\" | grep -v \"legacy-phpmyadmin\" | xargs -r docker rm -f && docker compose -f ${localWorkspaceFolder}/.devcontainer/compose.services.yaml up -d --remove-orphans tomcat mysql phpmyadmin && echo \"Host services started\"'"
```

### Option 3: Use Docker Compose Down on Rebuild

Add this to your workflow when rebuilding containers:

```bash
# Before rebuilding dev container
docker compose -f .devcontainer/compose.services.yaml down
docker compose -f .devcontainer/compose.dev.yaml down

# Then rebuild in VS Code
```

## Recommended Fix to Apply Now

Add a pre-flight check script that runs before starting services:

### Step 1: Create cleanup script
```bash
# Create the cleanup script (already provided above)
chmod +x .devcontainer/scripts/cleanup-old-containers.sh
```

### Step 2: Update devcontainer.json

Modify the `initializeCommand` to run cleanup first:

```json
"initializeCommand": "bash -c '.devcontainer/scripts/cleanup-old-containers.sh && docker compose -f ${localWorkspaceFolder}/.devcontainer/compose.services.yaml up -d tomcat mysql phpmyadmin'"
```

## Quick Reference: Container Management Commands

```bash
# List all containers (including stopped ones)
docker ps -a

# Remove specific old container
docker rm -f java5-phpmyadmin

# Stop and remove all containers from a compose file
docker compose -f .devcontainer/compose.services.yaml down

# Start services with orphan removal
docker compose -f .devcontainer/compose.services.yaml up -d --remove-orphans

# Check which containers are using specific ports
sudo lsof -i :8082
docker ps --filter "publish=8082"
```

## Summary

✅ **Your current configuration is correct**
⚠️ **The issue was an old orphaned container**
🔧 **Prevention: Add cleanup scripts to your initialization process**

The `java5-phpmyadmin` container was a leftover from a previous setup or configuration. By adding proper cleanup to your initialization process, this won't happen again.
