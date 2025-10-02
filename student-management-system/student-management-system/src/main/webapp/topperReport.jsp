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
    <title>Course Toppers Report</title>
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
        
        .back-btn {
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
        
        .back-btn:hover {
            transform: scale(1.05);
        }
        
        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .report-header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        
        .report-header h2 {
            color: #667eea;
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .report-header p {
            color: #666;
            font-size: 16px;
        }
        
        .topper-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .topper-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
            transition: transform 0.3s;
        }
        
        .topper-card:hover {
            transform: translateY(-5px);
        }
        
        .topper-card::before {
            content: '🏆';
            position: absolute;
            top: -20px;
            right: -20px;
            font-size: 100px;
            opacity: 0.1;
        }
        
        .course-name {
            color: #667eea;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }
        
        .student-info {
            margin-bottom: 10px;
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
        
        .marks-badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 20px;
            font-size: 24px;
            font-weight: bold;
            margin-top: 15px;
        }
        
        .no-data {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 10px;
            color: #999;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Course Toppers Report</h1>
        <a href="adminDashboard.jsp" class="back-btn">← Back to Dashboard</a>
    </div>
    
    <div class="container">
        <div class="report-header">
            <h2>🏆 Top Performers by Course</h2>
            <p>Highest scoring students in each course</p>
        </div>
        
        <div class="topper-grid">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                
                try {
                    conn = DBConnection.getConnection();
                    String sql = "SELECT s1.* FROM students s1 " +
                               "INNER JOIN (SELECT course, MAX(marks) as max_marks FROM students GROUP BY course) s2 " +
                               "ON s1.course = s2.course AND s1.marks = s2.max_marks " +
                               "ORDER BY s1.course";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();
                    
                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
            %>
            
            <div class="topper-card">
                <div class="course-name"><%= rs.getString("course") %></div>
                
                <div class="student-info">
                    <div class="info-label">Student Name</div>
                    <div class="info-value"><%= rs.getString("name") %></div>
                </div>
                
                <div class="student-info">
                    <div class="info-label">Roll Number</div>
                    <div class="info-value"><%= rs.getString("roll_no") %></div>
                </div>
                
                <div class="student-info">
                    <div class="info-label">Score</div>
                    <div class="marks-badge"><%= rs.getDouble("marks") %>%</div>
                </div>
            </div>
            
            <%
                    }
                    
                    if (!hasData) {
            %>
            <div class="no-data">
                No student data available to generate topper report.
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
    </div>
</body>
</html>