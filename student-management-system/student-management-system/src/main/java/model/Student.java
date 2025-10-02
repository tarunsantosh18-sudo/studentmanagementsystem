package model;

import java.sql.Date;

public class Student {
    private int id;
    private String name;
    private String rollNo;
    private String password;
    private String course;
    private double marks;
    private Date dateOfBirth;
    
    // Constructors
    public Student() {}
    
    public Student(int id, String name, String rollNo, String course, double marks, Date dateOfBirth) {
        this.id = id;
        this.name = name;
        this.rollNo = rollNo;
        this.course = course;
        this.marks = marks;
        this.dateOfBirth = dateOfBirth;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getRollNo() {
        return rollNo;
    }
    
    public void setRollNo(String rollNo) {
        this.rollNo = rollNo;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getCourse() {
        return course;
    }
    
    public void setCourse(String course) {
        this.course = course;
    }
    
    public double getMarks() {
        return marks;
    }
    
    public void setMarks(double marks) {
        this.marks = marks;
    }
    
    public Date getDateOfBirth() {
        return dateOfBirth;
    }
    
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
}