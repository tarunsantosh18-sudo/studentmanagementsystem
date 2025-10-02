package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            HttpSession session = request.getSession();
            
            if ("admin".equals(userType)) {
                // Admin login
                String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    session.setAttribute("userType", "admin");
                    session.setAttribute("username", username);
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    request.setAttribute("error", "Invalid admin credentials!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else if ("student".equals(userType)) {
                // Student login (username is roll number)
                String sql = "SELECT * FROM students WHERE roll_no = ? AND password = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    session.setAttribute("userType", "student");
                    session.setAttribute("rollNo", username);
                    session.setAttribute("studentId", rs.getInt("id"));
                    session.setAttribute("studentName", rs.getString("name"));
                    response.sendRedirect("studentDashboard.jsp");
                } else {
                    request.setAttribute("error", "Invalid student credentials!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                DBConnection.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}