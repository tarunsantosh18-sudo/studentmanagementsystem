<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Student Management System</title>
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("user") %></h2>
    <ul>
        <li><a href="addStudent.jsp">Add Student</a></li>
        <li><a href="listStudents.jsp">List Students</a></li>
        <li><a href="topperReport.jsp">Topper Report</a></li>
    </ul>
</body>
</html>
