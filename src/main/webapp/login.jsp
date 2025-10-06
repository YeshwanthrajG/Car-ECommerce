<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | CarExpert</title>
    <link rel="stylesheet" href="style.css">
    <script>
        window.addEventListener('DOMContentLoaded', function(){
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('error') === 'invalid') {
                alert('Invalid username or password!');
            }
        });
    </script>
</head>
<body>
<div class="navbar">
    <div class="brand">CarExpert</div>
    <div class="actions">
        <a class="ghost" href="index.jsp">Home</a>
        <a class="primary" href="register.jsp">Register</a>
    </div>
</div>

<div class="container-login">
    <div class="card">
        <h2>Login</h2>
        <form class="form" action="LoginServlet" method="post">
            <label>Username</label>
            <input type="text" name="username" required>
            <label>Password</label>
            <input type="password" name="password" required>
            <button type="submit" class="primary">Login</button>
        </form>
    </div>
</div>
</body>
</html>
