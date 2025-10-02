<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%
    if (session.getAttribute("userType") == null || !"admin".equals(session.getAttribute("userType"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int studentId = Integer.parseInt(request.getParameter("id"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        
        h2 {
            color: #667eea;
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }
        
        input[type="text"],
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-cancel {
            background: #e0e0e0;
            color: #333;
            text-decoration: none;
            text-align: center;
            line-height: 48px;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Student Details</h2>
        
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                conn = DBConnection.getConnection();
                String sql = "SELECT * FROM students WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, studentId);
                rs = ps.executeQuery();
                
                if (rs.next()) {
        %>
        
        <form action="StudentServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            
            <div class="form-group">
                <label for="rollNo">Roll Number: *</label>
                <input type="text" id="rollNo" name="rollNo" value="<%= rs.getString("roll_no") %>" required>
            </div>
            
            <div class="form-group">
                <label for="course">Course: *</label>
                <input type="text" id="course" name="course" value="<%= rs.getString("course") %>" required>
            </div>
            
            <div class="form-group">
                <label for="marks">Marks:</label>
                <input type="number" id="marks" name="marks" step="0.01" min="0" max="100" 
                       value="<%= rs.getDouble("marks") %>" required>
            </div>
            
            <div class="form-group">
                <label for="dob">Date of Birth: *</label>
                <input type="date" id="dob" name="dob" value="<%= rs.getDate("date_of_birth") %>" required>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-submit">Update Student</button>
                <a href="adminDashboard.jsp" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
        
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
    </div>
</body>
</html><label for="name">Student Name: *</label>
                <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required>
            </div>
            
            <div class="form-group">
                