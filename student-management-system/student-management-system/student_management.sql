-- Create Database
CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

-- Admin Table
CREATE TABLE IF NOT EXISTS admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Students Table
CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    roll_no VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    course VARCHAR(100) NOT NULL,
    marks DECIMAL(5,2) DEFAULT 0,
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample admin (username: admin, password: admin123)
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- Insert sample students (password same as roll number for simplicity)
INSERT INTO students (name, roll_no, password, course, marks, date_of_birth) VALUES
('John Doe', 'CS001', 'CS001', 'Computer Science', 85.5, '2002-05-15'),
('Jane Smith', 'CS002', 'CS002', 'Computer Science', 92.0, '2002-08-20'),
('Mike Johnson', 'EC001', 'EC001', 'Electronics', 78.5, '2002-03-10'),
('Sarah Williams', 'EC002', 'EC002', 'Electronics', 88.0, '2002-11-25'),
('David Brown', 'ME001', 'ME001', 'Mechanical', 81.5, '2002-07-30');