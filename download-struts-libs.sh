#!/bin/bash

# Download Struts 1.3.10 and required dependencies
# This script downloads all necessary JARs for Struts 1.3.10

set -e

LIB_DIR="lib"
MAVEN_CENTRAL="https://repo1.maven.org/maven2"

echo "📦 Downloading Struts 1.3.10 and dependencies..."

download_jar() {
    local group_path=$1
    local artifact=$2
    local version=$3
    local jar_file="${artifact}-${version}.jar"
    local url="${MAVEN_CENTRAL}/${group_path}/${artifact}/${version}/${jar_file}"
    
    if [ -f "${LIB_DIR}/${jar_file}" ]; then
        echo "✓ ${jar_file} already exists, skipping"
        return
    fi
    
    echo "⬇️  Downloading ${jar_file}..."
    if wget -q --show-progress -P "${LIB_DIR}" "${url}"; then
        echo "✓ ${jar_file} downloaded successfully"
    else
        echo "❌ Failed to download ${jar_file}"
        return 1
    fi
}

# Create lib directory if it doesn't exist
mkdir -p "${LIB_DIR}"

# Struts Core Libraries
download_jar "org/apache/struts" "struts-core" "1.3.10"
download_jar "org/apache/struts" "struts-taglib" "1.3.10"

# Servlet and JSP APIs (provided by Tomcat, but needed for compilation)
download_jar "javax/servlet/servlet-api" "servlet-api" "2.5"
download_jar "javax/servlet/jsp/jsp-api" "jsp-api" "2.1"

# Apache Commons Dependencies
download_jar "commons-beanutils/commons-beanutils" "commons-beanutils" "1.8.0"
download_jar "commons-chain/commons-chain" "commons-chain" "1.2"
download_jar "commons-digester/commons-digester" "commons-digester" "1.8"
download_jar "commons-fileupload/commons-fileupload" "commons-fileupload" "1.3.3"
download_jar "commons-io/commons-io" "commons-io" "2.4"
download_jar "commons-logging/commons-logging" "commons-logging" "1.0.4"
download_jar "commons-validator/commons-validator" "commons-validator" "1.3.1"
download_jar "commons-lang/commons-lang" "commons-lang" "2.6"

# ORO (Regular Expression Library - required by Commons Validator)
download_jar "oro/oro" "oro" "2.0.8"

# JSTL (JSP Standard Tag Library)
download_jar "javax/servlet/jstl" "jstl" "1.2"

# Additional libraries for EDMS requirements
echo ""
echo "📦 Downloading additional libraries for EDMS..."

# Apache Lucene for full-text search (version 3.6.2)
download_jar "org/apache/lucene/lucene-core" "lucene-core" "3.6.2"
download_jar "org/apache/lucene/lucene-analyzers" "lucene-analyzers" "3.6.2"

# Apache PDFBox for PDF text extraction
download_jar "org/apache/pdfbox/pdfbox" "pdfbox" "1.8.16"
download_jar "org/apache/pdfbox/fontbox" "fontbox" "1.8.16"
download_jar "org/apache/pdfbox/jempbox" "jempbox" "1.8.16"

# Apache POI for Excel/Word processing
download_jar "org/apache/poi/poi" "poi" "3.17"
download_jar "org/apache/poi/poi-ooxml" "poi-ooxml" "3.17"
download_jar "org/apache/poi/poi-ooxml-schemas" "poi-ooxml-schemas" "3.17"
download_jar "org/apache/xmlbeans/xmlbeans" "xmlbeans" "2.6.0"

# iText for PDF generation (version 2.1.7)
# Note: iText 2.1.7 is older and might need special handling
echo "ℹ️  Note: iText 2.1.7 requires manual download from https://sourceforge.net/projects/itext/files/itext/2.1.7/"

# JavaMail for email notifications
download_jar "javax/mail/mail" "mail" "1.4.7"
download_jar "javax/activation/activation" "activation" "1.1"

# Quartz Scheduler for job scheduling
download_jar "org/quartz-scheduler/quartz" "quartz" "1.8.6"

# Log4j for logging
download_jar "log4j/log4j" "log4j" "1.2.17"

# C3P0 for connection pooling
download_jar "c3p0/c3p0" "c3p0" "0.9.1.2"

# EHCache for second-level caching
download_jar "net/sf/ehcache/ehcache-core" "ehcache-core" "2.4.3"

# DisplayTag for table rendering
download_jar "displaytag/displaytag" "displaytag" "1.2"

echo ""
echo "✅ Download complete!"
echo ""
echo "📋 Downloaded Struts and EDMS libraries to ${LIB_DIR}/"
ls -lh "${LIB_DIR}"/*.jar 2>/dev/null | tail -20
echo ""
echo "🔨 Next steps:"
echo "1. Review the downloaded JARs in the ${LIB_DIR}/ directory"
echo "2. Run: ant clean build"
echo "3. Deploy and test the application"
echo ""
echo "ℹ️  Note: iText 2.1.7 may need to be downloaded manually"
