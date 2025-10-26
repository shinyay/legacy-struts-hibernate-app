#!/bin/bash
# Cleanup script to remove old/orphaned containers before starting dev environment
# This prevents port conflicts and ensures clean startup

set -e

echo "🧹 Cleaning up old/orphaned containers..."

# Remove old java5-legacy-dev container if it exists
echo "Checking for old Dev Container..."
if docker ps -a --filter "name=java5-legacy-dev" --format "{{.Names}}" 2>/dev/null | grep -q "java5-legacy-dev"; then
    echo "  ⚠️  Removing old Dev Container: java5-legacy-dev"
    docker rm -f java5-legacy-dev 2>/dev/null || true
fi

# Remove any old phpMyAdmin containers that don't match current config
echo "Checking for old phpMyAdmin containers..."
docker ps -a --filter "name=phpmyadmin" --format "{{.Names}}" 2>/dev/null | while read container; do
    if [ "$container" != "legacy-phpmyadmin" ]; then
        echo "  ⚠️  Removing old container: $container"
        docker rm -f "$container" 2>/dev/null || true
    else
        echo "  ✅ Current container found: $container"
    fi
done

# Remove orphaned containers from old compose files
echo "Removing orphaned containers..."
cd "$(dirname "$0")/.." || exit 1
docker compose -f compose.services.yaml down --remove-orphans 2>/dev/null || true

echo "✅ Cleanup complete!"
