<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.util.HibernateUtil" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Database Connection Test</title>
    <style>
        .success { color: green; }
        .error { color: red; }
        .warning { color: orange; }
    </style>
</head>
<body>
    <h1>Database Connection Test</h1>

    <h2>1. JDBC Connection Test</h2>
    <%
        String url = "jdbc:mysql://localhost:3306/legacy_db?useSSL=false";
        String user = "legacy_user";
        String password = "legacy_pass";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            out.println("<p class='success'>JDBC Connection successful!</p>");
            out.println("<p>Database: " + conn.getCatalog() + "</p>");

            // Check if users table exists
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rs = meta.getTables(null, null, "users", new String[] {"TABLE"});
            if (rs.next()) {
                out.println("<p class='success'>Users table exists</p>");
            } else {
                out.println("<p class='warning'>Users table does not exist - will be created by Hibernate</p>");
            }
            rs.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p class='error'>JDBC Connection failed!</p>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
        }
    %>

    <h2>2. Hibernate SessionFactory Test</h2>
    <%
        try {
            SessionFactory sf = HibernateUtil.getSessionFactory();
            out.println("<p class='success'>Hibernate SessionFactory initialized!</p>");

            Session hibSession = sf.openSession();
            out.println("<p class='success'>Hibernate Session opened!</p>");
            hibSession.close();
            out.println("<p class='success'>Hibernate Session closed!</p>");
        } catch (Exception e) {
            out.println("<p class='error'>Hibernate initialization failed!</p>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
        }
    %>

    <h2>3. User Query Test</h2>
    <%
        try {
            Session hibSession2 = HibernateUtil.getSessionFactory().openSession();
            java.util.List users = hibSession2.createQuery("FROM User").list();
            out.println("<p class='success'>Query executed successfully!</p>");
            out.println("<p>Found " + users.size() + " users</p>");
            hibSession2.close();
        } catch (Exception e) {
            out.println("<p class='error'>Query failed!</p>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
        }
    %>    <p><a href="index.jsp">Back to Home</a></p>
</body>
</html>
