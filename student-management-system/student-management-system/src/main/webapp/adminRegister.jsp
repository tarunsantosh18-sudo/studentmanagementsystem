<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #ff512f, #dd2476);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .register-container {
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.2);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #dd2476;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 8px;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #ff512f, #dd2476);
            border: none;
            border-radius: 8px;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .back-link {
            text-align: center;
            margin-top: 15px;
        }
        .back-link a {
            text-decoration: none;
            color: #dd2476;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Admin Registration</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div style="color:red;text-align:center;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("message") != null) { %>
            <div style="color:green;text-align:center;">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>

        <form action="RegisterServlet" method="post">
            <input type="hidden" name="userType" value="admin">
            
            <div class="form-group">
                <label for="secretKey">Secret Key:</label>
                <input type="password" id="secretKey" name="secretKey" required>
            </div>
            
            <div class="form-group">
                <label for="username">Admin Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Admin Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn">Register Admin</button>
        </form>
        
        <div class="back-link">
            <a href="login.jsp">← Back to Login</a>
        </div>
    </div>
</body>
</html>
