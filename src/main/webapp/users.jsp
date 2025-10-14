<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<html>
<head>
    <title>User Management - jQuery + Hibernate Demo</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <jsp:include page="/includes/header.jsp" />
    <style>
        .user-list {
            margin: 20px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .user-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .user-item:last-child {
            border-bottom: none;
        }
        .user-item:hover {
            background-color: #f5f5f5;
        }
        #userForm {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
        }
        .form-group input {
            width: 300px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            // Load users on page load
            loadUsers();

            // Form submission with AJAX
            $('#userForm').on('submit', function(e) {
                e.preventDefault();

                var formData = {
                    username: $('#username').val(),
                    email: $('#email').val(),
                    password: $('#password').val()
                };

                $.ajax({
                    url: APP_CONTEXT + '/user/save.do',
                    type: 'POST',
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            alert('User saved successfully!');
                            $('#userForm')[0].reset();
                            loadUsers();
                        } else {
                            alert('Error: ' + response.message);
                        }
                    },
                    error: function() {
                        alert('Error saving user. Please try again.');
                    }
                });
            });

            // Load users with AJAX
            function loadUsers() {
                $.ajax({
                    url: APP_CONTEXT + '/user/list.do',
                    type: 'GET',
                    dataType: 'json',
                    success: function(response) {
                        var html = '';
                        if (response.users && response.users.length > 0) {
                            $.each(response.users, function(i, user) {
                                html += '<div class="user-item">';
                                html += '<strong>' + user.username + '</strong> - ' + user.email;
                                html += ' <small>(ID: ' + user.id + ')</small>';
                                html += '</div>';
                            });
                        } else {
                            html = '<div class="user-item">No users found. Add one above!</div>';
                        }
                        $('#userList').html(html);
                    },
                    error: function() {
                        $('#userList').html('<div class="user-item">Error loading users</div>');
                    }
                });
            }

            // Refresh button
            $('#refreshUsers').on('click', function() {
                loadUsers();
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h1>👥 User Management</h1>
        <p>jQuery + Hibernate 3.x Integration Demo</p>

        <h2>Add New User</h2>
        <form id="userForm">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label></label>
                <button type="submit" class="btn-primary">Add User</button>
            </div>
        </form>

        <h2>User List <button id="refreshUsers" class="btn">🔄 Refresh</button></h2>
        <div class="user-list" id="userList">
            <div class="user-item">Loading users...</div>
        </div>

        <p><a href="index.jsp">← Back to Home</a></p>
    </div>
    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
