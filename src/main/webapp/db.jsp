<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="CarExpert.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DB Test</title>
    <link rel="stylesheet" href="style.css">
</head>
<body class="container">
<div class="card">
<%
    try (Connection conn = DBConnection.getConnection()) {
%>
    <p>DB Connection OK</p>
<%
    } catch (Exception e) {
%>
    <p>DB Connection Failed: <%= e.getMessage() %></p>
<%
    }
%>
</div>
</body>
</html>
