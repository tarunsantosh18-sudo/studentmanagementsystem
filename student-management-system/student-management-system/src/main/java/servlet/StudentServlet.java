package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DBConnection;

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addStudent(request, response);
        } else if ("update".equals(action)) {
            updateStudent(request, response);
        } else if ("delete".equals(action)) {
            deleteStudent(request, response);
        } else if ("updateMarks".equals(action)) {
            updateMarks(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteStudent(request, response);
        } else if ("edit".equals(action)) {
            getStudentForEdit(request, response);
        }
    }
    
    private void addStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String rollNo = request.getParameter("rollNo");
        String password = request.getParameter("password");
        String course = request.getParameter("course");
        String marksStr = request.getParameter("marks");
        String dob = request.getParameter("dob");
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            double marks = marksStr != null && !marksStr.isEmpty() ? Double.parseDouble(marksStr) : 0.0;
            
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO students (name, roll_no, password, course, marks, date_of_birth) VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, rollNo);
            ps.setString(3, password);
            ps.setString(4, course);
            ps.setDouble(5, marks);
            ps.setDate(6, Date.valueOf(dob));
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                request.setAttribute("success", "Student added successfully!");
            } else {
                request.setAttribute("error", "Failed to add student!");
            }
            
            response.sendRedirect("adminDashboard.jsp?success=added");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("addStudent.jsp").forward(request, response);
        } finally {
            try {
                if (ps != null) ps.close();
                DBConnection.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    private void updateStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String rollNo = request.getParameter("rollNo");
        String course = request.getParameter("course");
        double marks = Double.parseDouble(request.getParameter("marks"));
        String dob = request.getParameter("dob");
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE students SET name=?, roll_no=?, course=?, marks=?, date_of_birth=? WHERE id=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, rollNo);
            ps.setString(3, course);
            ps.setDouble(4, marks);
            ps.setDate(5, Date.valueOf(dob));
            ps.setInt(6, id);
            
            ps.executeUpdate();
            response.sendRedirect("adminDashboard.jsp?success=updated");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        } finally {
            try {
                if (ps != null) ps.close();
                DBConnection.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM students WHERE id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            
            ps.executeUpdate();
            response.sendRedirect("adminDashboard.jsp?success=deleted");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=delete_failed");
        } finally {
            try {
                if (ps != null) ps.close();
                DBConnection.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    private void getStudentForEdit(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM students WHERE id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("student", rs);
                request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
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
    
    private void updateMarks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        double marks = Double.parseDouble(request.getParameter("marks"));
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE students SET marks=? WHERE id=?";
            ps = conn.prepareStatement(sql);
            ps.setDouble(1, marks);
            ps.setInt(2, studentId);
            
            ps.executeUpdate();
            response.sendRedirect("studentDashboard.jsp?success=marks_updated");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("studentDashboard.jsp?error=update_failed");
        } finally {
            try {
                if (ps != null) ps.close();
                DBConnection.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}