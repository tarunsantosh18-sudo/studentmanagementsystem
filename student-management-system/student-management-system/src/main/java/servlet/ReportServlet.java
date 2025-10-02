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

import dao.DBConnection;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String reportType = request.getParameter("type");
        
        if ("toppers".equals(reportType)) {
            getToppers(request, response);
        } else if ("all".equals(reportType)) {
            getAllStudents(request, response);
        }
    }
    
    private void getToppers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT course, name, roll_no, marks FROM students WHERE (course, marks) IN " +
                        "(SELECT course, MAX(marks) FROM students GROUP BY course) ORDER BY course";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            request.setAttribute("toppers", rs);
            request.getRequestDispatcher("topperReport.jsp").forward(request, response);
            
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
    
    private void getAllStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM students ORDER BY name";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            request.setAttribute("students", rs);
            request.getRequestDispatcher("listStudents.jsp").forward(request, response);
            
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
}