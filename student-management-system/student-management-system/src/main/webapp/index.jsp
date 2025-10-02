<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management System</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        
        h1 {
            color: #667eea;
            margin-bottom: 10px;
            font-size: 32px;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 40px;
            font-size: 16px;
        }
        
        .btn {
            display: inline-block;
            padding: 15px 50px;
            margin: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: bold;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
        }
        
        .features {
            margin-top: 30px;
            text-align: left;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .features h3 {
            color: #667eea;
            margin-bottom: 15px;
        }
        
        .features ul {
            list-style: none;
        }
        
        .features li {
            padding: 8px 0;
            color: #555;
        }
        
        .features li:before {
            content: "✓ ";
            color: #667eea;
            font-weight: bold;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Management System</h1>
        <p class="subtitle">Manage student records efficiently</p>
        
        <a href="login.jsp" class="btn">Login</a>
        
        <div class="features">
            <h3>Features</h3>
            <ul>
                <li>Admin can manage all student records</li>
                <li>Add, update, and delete student data</li>
                <li>Search students by name</li>
                <li>View course-wise toppers</li>
                <li>Students can view and update their marks</li>
            </ul>
        </div>
    </div>
</body>
</html>