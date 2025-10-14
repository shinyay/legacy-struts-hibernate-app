#!/bin/bash
# Download Hibernate 3.6.x and dependencies for Java 5 legacy application

echo "📦 Downloading Hibernate 3.6.10.Final and dependencies..."
echo ""

# Navigate to lib directory
cd "$(dirname "$0")/lib" || exit 1

# Maven Central base URL
MAVEN_CENTRAL="https://repo1.maven.org/maven2"

# Function to download with progress
download_jar() {
    local url=$1
    local filename=$2

    if [ -f "$filename" ]; then
        echo "✓ $filename already exists, skipping..."
    else
        echo "⬇️  Downloading $filename..."
        wget -q --show-progress "$url" -O "$filename"
        if [ $? -eq 0 ]; then
            echo "✓ $filename downloaded successfully"
        else
            echo "✗ Failed to download $filename"
        fi
    fi
}

# Core Hibernate
download_jar "$MAVEN_CENTRAL/org/hibernate/hibernate-core/3.6.10.Final/hibernate-core-3.6.10.Final.jar" \
    "hibernate-core-3.6.10.Final.jar"

download_jar "$MAVEN_CENTRAL/org/hibernate/javax/persistence/hibernate-jpa-2.0-api/1.0.1.Final/hibernate-jpa-2.0-api-1.0.1.Final.jar" \
    "hibernate-jpa-2.0-api-1.0.1.Final.jar"

# Dependencies
download_jar "$MAVEN_CENTRAL/antlr/antlr/2.7.6/antlr-2.7.6.jar" \
    "antlr-2.7.6.jar"

download_jar "$MAVEN_CENTRAL/dom4j/dom4j/1.6.1/dom4j-1.6.1.jar" \
    "dom4j-1.6.1.jar"

download_jar "$MAVEN_CENTRAL/javassist/javassist/3.12.0.GA/javassist-3.12.0.GA.jar" \
    "javassist-3.12.0.GA.jar"

download_jar "$MAVEN_CENTRAL/javax/transaction/jta/1.1/jta-1.1.jar" \
    "jta-1.1.jar"

download_jar "$MAVEN_CENTRAL/org/slf4j/slf4j-api/1.6.1/slf4j-api-1.6.1.jar" \
    "slf4j-api-1.6.1.jar"

download_jar "$MAVEN_CENTRAL/org/slf4j/slf4j-simple/1.6.1/slf4j-simple-1.6.1.jar" \
    "slf4j-simple-1.6.1.jar"

# MySQL Connector
download_jar "$MAVEN_CENTRAL/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar" \
    "mysql-connector-java-5.1.49.jar"

# Commons Collections (if needed)
download_jar "$MAVEN_CENTRAL/commons-collections/commons-collections/3.2.1/commons-collections-3.2.1.jar" \
    "commons-collections-3.2.1.jar"

echo ""
echo "✅ Download complete!"
echo ""
echo "📋 Downloaded files:"
ls -lh *.jar | grep -E "(hibernate|antlr|dom4j|javassist|jta|slf4j|mysql)"

echo ""
echo "🔨 Next steps:"
echo "1. Review the downloaded JARs in the lib/ directory"
echo "2. Configure database credentials in src/main/resources/hibernate.cfg.xml"
echo "3. Run: ant clean build"
echo "4. Deploy and test the application"
echo ""
echo "📖 For more information, see JQUERY_HIBERNATE_SETUP.md"
