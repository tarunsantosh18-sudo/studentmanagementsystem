<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%
    if (session.getAttribute("userType") == null || !"admin".equals(session.getAttribute("userType"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background: #f5f5f5;
        }
        
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 15px 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar h1 {
            font-size: 24px;
        }
        
        .navbar .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .logout-btn {
            background: white;
            color: #667eea;
            padding: 8px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            transition: transform 0.3s;
        }
        
        .logout-btn:hover {
            transform: scale(1.05);
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .search-bar {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            gap: 10px;
        }
        
        .search-bar input {
            flex: 1;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
        }
        
        .search-bar button {
            padding: 12px 30px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .actions {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: transform 0.3s;
            display: inline-block;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        table {
            width: 100%;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
        }
        
        tbody tr:nth-child(even) {
            background: #f8f9fa;
        }
        
        tbody tr:hover {
            background: #e3f2fd;
        }
        
        .action-btns {
            display: flex;
            gap: 10px;
        }
        
        .edit-btn {
            background: #4caf50;
            color: white;
            padding: 6px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }
        
        .delete-btn {
            background: #f44336;
            color: white;
            padding: 6px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }
        
        .edit-btn:hover {
            background: #45a049;
        }
        
        .delete-btn:hover {
            background: #da190b;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 18px;
        }
    </style>
    <script>
        function searchStudent() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toUpperCase();
            var table = document.getElementById("studentTable");
            var tr = table.getElementsByTagName("tr");
            
            for (var i = 1; i < tr.length; i++) {
                var td = tr[i].getElementsByTagName("td")[1];
                if (td) {
                    var txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
        
        function confirmDelete(id, name) {
            if (confirm("Are you sure you want to delete student: " + name + "?")) {
                window.location.href = "StudentServlet?action=delete&id=" + id;
            }
        }
    </script>
</head>
<body>
    <div class="navbar">
        <h1>Admin Dashboard</h1>
        <div class="user-info">
            <span>Welcome, <%= session.getAttribute("username") %></span>
            <a href="logout.jsp" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <% if ("added".equals(request.getParameter("success"))) { %>
            <div class="success">Student added successfully!</div>
        <% } else if ("updated".equals(request.getParameter("success"))) { %>
            <div class="success">Student updated successfully!</div>
        <% } else if ("deleted".equals(request.getParameter("success"))) { %>
            <div class="success">Student deleted successfully!</div>
        <% } %>
        
        <div class="actions">
            <a href="addStudent.jsp" class="btn">+ Add New Student</a>
            <a href="topperReport.jsp" class="btn">View Toppers Report</a>
        </div>
        
        <div class="search-bar">
            <input type="text" id="searchInput" onkeyup="searchStudent()" placeholder="Search by student name...">
            <button onclick="searchStudent()">Search</button>
        </div>
        
        <table id="studentTable">
            <thead>
                <tr>
                    <th>Roll No</th>
                    <th>Name</th>
                    <th>Course</th>
                    <th>Marks</th>
                    <th>Date of Birth</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    
                    try {
                        conn = DBConnection.getConnection();
                        String sql = "SELECT * FROM students ORDER BY name";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        
                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                %>
                <tr>
                    <td><%= rs.getString("roll_no") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("course") %></td>
                    <td><%= rs.getDouble("marks") %></td>
                    <td><%= rs.getDate("date_of_birth") %></td>
                    <td class="action-btns">
                        <a href="updateStudent.jsp?id=<%= rs.getInt("id") %>" class="edit-btn">Edit</a>
                        <a href="javascript:void(0)" onclick="confirmDelete(<%= rs.getInt("id") %>, '<%= rs.getString("name") %>')" class="delete-btn">Delete</a>
                    </td>
                </tr>
                <%
                        }
                        
                        if (!hasData) {
                %>
                <tr>
                    <td colspan="6" class="no-data">No students found. Add new students to get started.</td>
                </tr>
                <%
                        }
                        
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        DBConnection.closeConnection(conn);
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>