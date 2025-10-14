#!/bin/bash

echo "=== Alternative Web Server for Development ==="

# Jetty server for testing WAR files when external Tomcat is not available
JETTY_VERSION="6.1.26"
JETTY_HOME="/tmp/jetty-$JETTY_VERSION"

# Check if Tomcat is available externally
if curl -s -f http://localhost:8081 > /dev/null 2>&1; then
    echo "✅ External Tomcat is running on port 8081"
    echo "🌐 Application should be available at: http://localhost:8081/legacy-app"
    exit 0
fi

echo "⚠️  External Tomcat not detected, starting development server..."

# Download and setup Jetty if not exists
if [ ! -d "$JETTY_HOME" ]; then
    echo "📥 Downloading Jetty $JETTY_VERSION..."
    cd /tmp
    wget -q "https://repo1.maven.org/maven2/org/mortbay/jetty/jetty-distribution/$JETTY_VERSION/jetty-distribution-$JETTY_VERSION.tar.gz"

    if [ $? -eq 0 ]; then
        tar -xzf "jetty-distribution-$JETTY_VERSION.tar.gz"
        rm -f "jetty-distribution-$JETTY_VERSION.tar.gz"
        echo "✅ Jetty extracted to $JETTY_HOME"
    else
        echo "❌ Failed to download Jetty"
        exit 1
    fi
fi

# Copy WAR file to Jetty webapps
if [ -f "/app/dist/legacy-app.war" ]; then
    echo "📦 Deploying WAR file to Jetty..."
    cp "/app/dist/legacy-app.war" "$JETTY_HOME/webapps/"

    # Start Jetty server
    echo "🚀 Starting Jetty server on port 8080..."
    cd "$JETTY_HOME"

    # Set Java system properties for legacy compatibility
    export JAVA_OPTIONS="-Xmx256m -Xms128m -Dfile.encoding=UTF-8 -Djava.awt.headless=true"

    # Start Jetty in background
    nohup java $JAVA_OPTIONS -jar start.jar > /tmp/jetty.log 2>&1 &
    JETTY_PID=$!

    echo "⏳ Waiting for Jetty to start..."
    sleep 10

    # Check if Jetty started successfully
    if curl -s -f http://localhost:8080 > /dev/null 2>&1; then
        echo "✅ Jetty server started successfully!"
        echo "🌐 Server: http://localhost:8080"
        echo "📱 Application: http://localhost:8080/legacy-app"
        echo "📋 Jetty PID: $JETTY_PID"
        echo "📜 Logs: /tmp/jetty.log"

        # Keep the script running to maintain the server
        echo "💡 Press Ctrl+C to stop the server"
        wait $JETTY_PID
    else
        echo "❌ Jetty failed to start"
        cat /tmp/jetty.log
        exit 1
    fi
else
    echo "❌ WAR file not found at /app/dist/legacy-app.war"
    echo "🔧 Please run 'ant clean build' first"
    exit 1
fi
