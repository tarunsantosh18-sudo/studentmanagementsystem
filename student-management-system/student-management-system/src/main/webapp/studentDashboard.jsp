<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%
    if (session.getAttribute("userType") == null || !"student".equals(session.getAttribute("userType"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int studentId = (Integer) session.getAttribute("studentId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
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
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar h1 {
            color: #667eea;
            font-size: 24px;
        }
        
        .navbar .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
            color: #333;
        }
        
        .logout-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
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
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .profile-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            margin-bottom: 30px;
        }
        
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .profile-header h2 {
            color: #667eea;
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .info-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .info-label {
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }
        
        .info-value {
            color: #333;
            font-size: 18px;
            font-weight: bold;
        }
        
        .marks-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px;
            border-radius: 10px;
            color: white;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .marks-section h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        
        .marks-value {
            font-size: 48px;
            font-weight: bold;
        }
        
        .update-marks-form {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .update-marks-form h3 {
            color: #667eea;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-submit {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Student Dashboard</h1>
        <div class="user-info">
            <span><strong>Welcome, <%= session.getAttribute("studentName") %></strong></span>
            <a href="logout.jsp" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <% if ("marks_updated".equals(request.getParameter("success"))) { %>
            <div class="success">Marks updated successfully!</div>
        <% } else if ("update_failed".equals(request.getParameter("error"))) { %>
            <div class="error">Failed to update marks. Please try again.</div>
        <% } %>
        
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
        
        <div class="profile-card">
            <div class="profile-header">
                <h2>My Profile</h2>
            </div>
            
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">Name</div>
                    <div class="info-value"><%= rs.getString("name") %></div>
                </div>
                
                <div class="info-item">
                    <div class="info-label">Roll Number</div>
                    <div class="info-value"><%= rs.getString("roll_no") %></div>
                </div>
                
                <div class="info-item">
                    <div class="info-label">Course</div>
                    <div class="info-value"><%= rs.getString("course") %></div>
                </div>
                
                <div class="info-item">
                    <div class="info-label">Date of Birth</div>
                    <div class="info-value"><%= rs.getDate("date_of_birth") %></div>
                </div>
            </div>
            
            <div class="marks-section">
                <h3>Current Marks</h3>
                <div class="marks-value"><%= rs.getDouble("marks") %>%</div>
            </div>
        </div>
        
        <div class="update-marks-form">
            <h3>Update Your Marks</h3>
            <form action="StudentServlet" method="post">
                <input type="hidden" name="action" value="updateMarks">
                <input type="hidden" name="studentId" value="<%= studentId %>">
                
                <div class="form-group">
                    <label for="marks">Enter New Marks:</label>
                    <input type="number" id="marks" name="marks" step="0.01" min="0" max="100" 
                           value="<%= rs.getDouble("marks") %>" required>
                </div>
                
                <button type="submit" class="btn-submit">Update Marks</button>
            </form>
        </div>
        
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
</html>