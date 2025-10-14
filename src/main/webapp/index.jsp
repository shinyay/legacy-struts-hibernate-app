<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Java 5 Legacy Struts Application</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <jsp:include page="/includes/header.jsp" />
</head>
<body>
    <div class="container">
        <h1>🎯 Welcome to Java 5 Legacy Development Environment</h1>
        <p>This is a comprehensive development environment for legacy Java applications using:</p>

        <ul>
            <li><strong>Java 1.5.0_22 (J2SE 5.0)</strong> - Legacy Java runtime</li>
            <li><strong>Apache Struts 1.x</strong> - MVC framework</li>
            <li><strong>jQuery 1.12.4</strong> - JavaScript library for UI interactivity</li>
            <li><strong>Hibernate 3.6.x</strong> - ORM framework (requires setup)</li>
            <li><strong>Apache Ant</strong> - Build automation</li>
            <li><strong>MySQL 5.7</strong> - Database support</li>
        </ul>

        <h2>🚀 Quick Start</h2>
        <ul>
            <li><a href="sample.jsp">Sample Form Application</a></li>
            <li><a href="users.jsp">User Management (jQuery + Hibernate Demo)</a></li>
            <li><a href="docs/javadoc/">API Documentation</a></li>
        </ul>

        <h2>📋 Development Tools</h2>
        <p>Use the following commands in the Dev Container terminal:</p>
        <pre>
# Build the application
ant build

# Compile only
ant compile

# Create WAR file
ant war

# Generate JavaDoc
ant javadoc
        </pre>
    </div>
    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
