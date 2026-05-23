<%@ page import="java.sql.*, java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<%
// DATABASE CONFIGURATION
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}

final String DB_URL = "jdbc:mysql://localhost:3306/wsu_db";
final String DB_USER = "root";
final String DB_PASS = "";

String action = request.getParameter("action");
String message = "";
String error = "";

// ============================================
// STUDENT REGISTRATION
// ============================================
if("register".equals(action)) {
    String studentId = request.getParameter("studentId");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String department = request.getParameter("department");
    String phone = request.getParameter("phone");
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        String checkSql = "SELECT * FROM students WHERE student_id=? OR email=?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, studentId);
        checkStmt.setString(2, email);
        ResultSet checkRs = checkStmt.executeQuery();
        
        if(checkRs.next()) {
            error = "Student ID or Email already exists!";
        } else {
            String sql = "INSERT INTO students (student_id, full_name, email, password, department, phone) VALUES (?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, studentId);
            pstmt.setString(2, fullName);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
            pstmt.setString(5, department);
            pstmt.setString(6, phone);
            
            if(pstmt.executeUpdate() > 0) {
                message = "Registration successful! Please login.";
            } else {
                error = "Registration failed!";
            }
        }
        conn.close();
    } catch(Exception e) {
        error = "Error: " + e.getMessage();
    }
}

// ============================================
// STUDENT LOGIN
// ============================================
else if("studentLogin".equals(action)) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        String sql = "SELECT * FROM students WHERE email=? AND password=? AND student_id != 'ADMIN001'";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();
        
        if(rs.next()) {
            session.setAttribute("studentId", rs.getString("student_id"));
            session.setAttribute("studentName", rs.getString("full_name"));
            session.setAttribute("studentEmail", rs.getString("email"));
            session.setAttribute("studentDept", rs.getString("department"));
            session.setAttribute("studentPhone", rs.getString("phone"));
            session.setAttribute("userType", "student");
            response.sendRedirect("?page=studentDashboard");
            return;
        } else {
            error = "Invalid email or password!";
        }
        conn.close();
    } catch(Exception e) {
        error = "Login Error: " + e.getMessage();
    }
}

// ============================================
// ADMIN LOGIN
// ============================================
else if("adminLogin".equals(action)) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        String sql = "SELECT * FROM students WHERE email=? AND password=? AND student_id='ADMIN001'";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();
        
        if(rs.next()) {
            session.setAttribute("adminName", rs.getString("full_name"));
            session.setAttribute("userType", "admin");
            response.sendRedirect("?page=adminDashboard");
            return;
        } else {
            error = "Invalid admin credentials!";
        }
        conn.close();
    } catch(Exception e) {
        error = "Admin Login Error: " + e.getMessage();
    }
}

// ============================================
// ADMIN CREATE STUDENT
// ============================================
else if("adminCreate".equals(action)) {
    String studentId = request.getParameter("studentId");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String department = request.getParameter("department");
    String phone = request.getParameter("phone");
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        String sql = "INSERT INTO students (student_id, full_name, email, password, department, phone) VALUES (?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, studentId);
        pstmt.setString(2, fullName);
        pstmt.setString(3, email);
        pstmt.setString(4, password);
        pstmt.setString(5, department);
        pstmt.setString(6, phone);
        
        if(pstmt.executeUpdate() > 0) {
            message = "Student added successfully!";
        } else {
            error = "Failed to add student!";
        }
        conn.close();
    } catch(Exception e) {
        error = "Create Error: " + e.getMessage();
    }
    response.sendRedirect("?page=adminDashboard");
    return;
}

// ============================================
// ADMIN UPDATE STUDENT
// ============================================
else if("adminUpdate".equals(action)) {
    String studentId = request.getParameter("studentId");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String department = request.getParameter("department");
    String phone = request.getParameter("phone");
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        String sql = "UPDATE students SET full_name=?, email=?, department=?, phone=? WHERE student_id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, fullName);
        pstmt.setString(2, email);
        pstmt.setString(3, department);
        pstmt.setString(4, phone);
        pstmt.setString(5, studentId);
        
        pstmt.executeUpdate();
        message = "Student updated successfully!";
        conn.close();
    } catch(Exception e) {
        error = "Update Error: " + e.getMessage();
    }
    response.sendRedirect("?page=adminDashboard");
    return;
}

// ============================================
// ADMIN DELETE STUDENT
// ============================================
else if("adminDelete".equals(action)) {
    String studentId = request.getParameter("studentId");
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        String sql = "DELETE FROM students WHERE student_id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, studentId);
        pstmt.executeUpdate();
        message = "Student deleted successfully!";
        conn.close();
    } catch(Exception e) {
        error = "Delete Error: " + e.getMessage();
    }
    response.sendRedirect("?page=adminDashboard");
    return;
}

// ============================================
// ADMIN ADD COURSE (WITH DEPARTMENT)
// ============================================
else if("adminAddCourse".equals(action)) {
    String courseCode = request.getParameter("courseCode");
    String courseName = request.getParameter("courseName");
    int creditHours = Integer.parseInt(request.getParameter("creditHours"));
    String department = request.getParameter("department");
    int yearLevel = Integer.parseInt(request.getParameter("yearLevel"));
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        String checkSql = "SELECT * FROM courses WHERE course_code=?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, courseCode);
        ResultSet checkRs = checkStmt.executeQuery();
        
        if(checkRs.next()) {
            error = "Course code already exists!";
        } else {
            String sql = "INSERT INTO courses (course_code, course_name, credit_hours, department, year_level) VALUES (?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, courseCode);
            pstmt.setString(2, courseName);
            pstmt.setInt(3, creditHours);
            pstmt.setString(4, department);
            pstmt.setInt(5, yearLevel);
            
            if(pstmt.executeUpdate() > 0) {
                message = "Course added successfully for " + department + " department!";
            } else {
                error = "Failed to add course!";
            }
        }
        conn.close();
    } catch(Exception e) {
        error = "Add Course Error: " + e.getMessage();
    }
    response.sendRedirect("?page=adminDashboard");
    return;
}

// ============================================
// ADMIN DELETE COURSE
// ============================================
else if("adminDeleteCourse".equals(action)) {
    String courseCode = request.getParameter("courseCode");
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        
        String checkSql = "SELECT * FROM enrollments WHERE course_code=?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, courseCode);
        ResultSet checkRs = checkStmt.executeQuery();
        
        if(checkRs.next()) {
            error = "Cannot delete course! Students are enrolled in this course.";
        } else {
            String sql = "DELETE FROM courses WHERE course_code=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, courseCode);
            pstmt.executeUpdate();
            message = "Course deleted successfully!";
        }
        conn.close();
    } catch(Exception e) {
        error = "Delete Course Error: " + e.getMessage();
    }
    response.sendRedirect("?page=adminDashboard");
    return;
}

// ============================================
// ADMIN ENROLL STUDENT (STRICT DEPARTMENT VALIDATION)
// ============================================
else if("adminEnroll".equals(action)) {
    String studentId = request.getParameter("studentId");
    String courseCode = request.getParameter("courseCode");
    
    try {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        
        String studentSql = "SELECT department FROM students WHERE student_id=?";
        PreparedStatement studentStmt = conn.prepareStatement(studentSql);
        studentStmt.setString(1, studentId);
        ResultSet studentRs = studentStmt.executeQuery();
        
        String studentDept = "";
        String studentName = "";
        if(studentRs.next()) {
            studentDept = studentRs.getString("department");
        }
        
        String courseSql = "SELECT department, course_name FROM courses WHERE course_code=?";
        PreparedStatement courseStmt = conn.prepareStatement(courseSql);
        courseStmt.setString(1, courseCode);
        ResultSet courseRs = courseStmt.executeQuery();
        
        String courseDept = "";
        String courseName = "";
        if(courseRs.next()) {
            courseDept = courseRs.getString("department");
            courseName = courseRs.getString("course_name");
        }
        
        if(!studentDept.equals(courseDept)) {
            error = "ENROLLMENT REJECTED! Student belongs to '" + studentDept + "' department, but the course belongs to '" + courseDept + "' department.";
        } else {
            String checkSql = "SELECT * FROM enrollments WHERE student_id=? AND course_code=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, studentId);
            checkStmt.setString(2, courseCode);
            ResultSet checkRs = checkStmt.executeQuery();
            
            if(checkRs.next()) {
                error = "Student is already enrolled in this course!";
            } else {
                String sql = "INSERT INTO enrollments (student_id, course_code) VALUES (?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, studentId);
                pstmt.setString(2, courseCode);
                
                if(pstmt.executeUpdate() > 0) {
                    message = "SUCCESS! Student successfully enrolled in " + courseCode + " - " + courseName;
                } else {
                    error = "Failed to enroll student!";
                }
            }
        }
        conn.close();
    } catch(Exception e) {
        error = "Enrollment Error: " + e.getMessage();
    }
    response.sendRedirect("?page=adminDashboard");
    return;
}

// ============================================
// LOGOUT
// ============================================
else if("logout".equals(action)) {
    session.invalidate();
    response.sendRedirect("?page=home");
    return;
}

String page_view = request.getParameter("page");
if(page_view == null) page_view = "home";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WSU Student Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .header, .card { background: white; border-radius: 10px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header { text-align: center; }
        .nav { background: white; padding: 15px; border-radius: 10px; margin-bottom: 20px; text-align: center; }
        .nav a { color: #667eea; text-decoration: none; padding: 10px 20px; margin: 0 10px; border-radius: 5px; display: inline-block; transition: all 0.3s; }
        .nav a:hover { background: #667eea; color: white; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        button { background: #667eea; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin: 5px; font-size: 14px; transition: all 0.3s; }
        button:hover { background: #764ba2; transform: translateY(-2px); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background: #667eea; color: white; }
        tr:hover { background: #f5f5f5; }
        .message { background: #4CAF50; color: white; padding: 12px; border-radius: 5px; margin-bottom: 15px; }
        .error { background: #f44336; color: white; padding: 12px; border-radius: 5px; margin-bottom: 15px; }
        .btn-edit { background: #ffc107; color: #333; padding: 5px 10px; border: none; border-radius: 3px; cursor: pointer; margin-right: 5px; }
        .btn-delete { background: #dc3545; color: white; padding: 5px 10px; border: none; border-radius: 3px; cursor: pointer; }
        .btn-add { background: #28a745; color: white; padding: 5px 10px; border: none; border-radius: 3px; cursor: pointer; }
        .dashboard-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; }
        .logout-btn { background: #dc3545; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 10px; }
        .grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        @media (max-width: 768px) { .grid-2 { grid-template-columns: 1fr; } }
        .tab { overflow: hidden; background: #f1f1f1; border-radius: 5px; margin-bottom: 20px; }
        .tab button { background: inherit; float: left; border: none; outline: none; cursor: pointer; padding: 14px 16px; transition: 0.3s; font-size: 16px; }
        .tab button:hover { background: #ddd; }
        .tab button.active { background: #667eea; color: white; }
        .tabcontent { display: none; padding: 20px; background: white; border-radius: 5px; }
        .table-responsive { overflow-x: auto; }
        .info-box { background: #e3f2fd; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 4px solid #2196F3; }
        .warning-box { background: #fff3cd; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 4px solid #ffc107; }
    </style>
</head>
<body>
<div class="container">
    
    <% if(!"studentDashboard".equals(page_view) && !"adminDashboard".equals(page_view)) { %>
    <div class="header">
        <h1>Wolaita Sodo University</h1>
        <p>Student Management and Course Registration System</p>
    </div>
    <% } %>
    
    <% if(message != null && !message.isEmpty()) { %>
        <div class="message"><%= message %></div>
    <% } %>
    <% if(error != null && !error.isEmpty()) { %>
        <div class="error"><%= error %></div>
    <% } %>
    
    <!-- HOME PAGE -->
    <% if("home".equals(page_view)) { %>
        <div class="nav">
            <a href="?page=studentRegister">Student Registration</a>
            <a href="?page=studentLogin">Student Login</a>
            <a href="?page=adminLogin">Admin Login</a>
        </div>
        <div class="grid-2">
            <div class="card">
                <h3>For Students</h3>
                <p>Register, login and view your enrolled courses</p>
                <br>
                <a href="?page=studentLogin"><button>Student Login</button></a>
            </div>
            <div class="card">
                <h3>For Administrators</h3>
                <p>Manage students, courses and enrollments</p>
                <br>
                <a href="?page=adminLogin"><button>Admin Login</button></a>
            </div>
        </div>
    <% } %>
    
    <!-- STUDENT REGISTRATION -->
    <% if("studentRegister".equals(page_view)) { %>
        <div class="card">
            <h2>Student Registration</h2>
            <form method="post">
                <input type="hidden" name="action" value="register">
                <div class="grid-2">
                    <div class="form-group"><label>Student ID:</label><input type="text" name="studentId" placeholder="e.g., CS001/25" required></div>
                    <div class="form-group"><label>Full Name:</label><input type="text" name="fullName" required></div>
                    <div class="form-group"><label>Email:</label><input type="email" name="email" required></div>
                    <div class="form-group"><label>Password:</label><input type="password" name="password" required></div>
                    <div class="form-group">
                        <label>Department:</label>
                        <select name="department" required>
                            <option value="">Select Department</option>
                            <option>Computer Science</option>
                            <option>Software Engineering</option>
                            <option>Information Technology</option>
                            <option>Electrical Engineering</option>
                            <option>Civil Engineering</option>
                            <option>Mechanical Engineering</option>
                            <option>Chemical Engineering</option>
                            <option>Accounting and Finance</option>
                            <option>Marketing Management</option>
                            <option>Public Health</option>
                        </select>
                    </div>
                    <div class="form-group"><label>Phone:</label><input type="text" name="phone"></div>
                </div>
                <button type="submit">Register</button>
            </form>
            <br><a href="?page=studentLogin">Already have an account? Login</a>
        </div>
    <% } %>
    
    <!-- STUDENT LOGIN -->
    <% if("studentLogin".equals(page_view)) { %>
        <div class="card">
            <h2>Student Login</h2>
            <form method="post">
                <input type="hidden" name="action" value="studentLogin">
                <div class="form-group"><label>Email:</label><input type="email" name="email" required></div>
                <div class="form-group"><label>Password:</label><input type="password" name="password" required></div>
                <button type="submit">Login</button>
            </form>
            <br><a href="?page=studentRegister">New student? Register</a>
        </div>
    <% } %>
    
    <!-- ADMIN LOGIN -->
    <% if("adminLogin".equals(page_view)) { %>
        <div class="card">
            <h2>Admin Login</h2>
            <form method="post">
                <input type="hidden" name="action" value="adminLogin">
                <div class="form-group"><label>Email:</label><input type="email" name="email" required></div>
                <div class="form-group"><label>Password:</label><input type="password" name="password" required></div>
                <button type="submit">Login</button>
            </form>
        </div>
    <% } %>
    
    <!-- STUDENT DASHBOARD -->
    <% if("studentDashboard".equals(page_view) && session.getAttribute("userType") != null && "student".equals(session.getAttribute("userType"))) { 
        List<String[]> courses = new ArrayList<>();
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            String sql = "SELECT c.course_code, c.course_name, c.credit_hours, c.year_level " +
                        "FROM courses c INNER JOIN enrollments e ON c.course_code = e.course_code " +
                        "WHERE e.student_id=? ORDER BY c.year_level, c.course_code";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, (String)session.getAttribute("studentId"));
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                courses.add(new String[]{rs.getString("course_code"), rs.getString("course_name"), 
                                        String.valueOf(rs.getInt("credit_hours")),
                                        String.valueOf(rs.getInt("year_level"))});
            }
            conn.close();
        } catch(Exception e) { error = e.getMessage(); }
    %>
        <div class="dashboard-header">
            <h2>Welcome, <%= session.getAttribute("studentName") %>!</h2>
            <p>Student ID: <%= session.getAttribute("studentId") %></p>
            <p>Department: <strong><%= session.getAttribute("studentDept") %></strong></p>
            <a href="?action=logout" class="logout-btn">Logout</a>
        </div>
        <div class="grid-2">
            <div class="card">
                <h3>My Enrolled Courses</h3>
                <% if(courses.isEmpty()) { %>
                    <div class="warning-box">
                        <p>No courses enrolled yet. Contact admin for course registration.</p>
                        <p><strong>Note:</strong> You can only enroll in courses from your department: <strong><%= session.getAttribute("studentDept") %></strong></p>
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table>
                            <thead>
                                <tr><th>Year</th><th>Code</th><th>Course Name</th><th>Credits</th></tr>
                            </thead>
                            <tbody>
                                <% for(String[] c : courses) { %>
                                    <tr><td><%= c[3] %></td><td><%= c[0] %></td><td><%= c[1] %></td><td><%= c[2] %></td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>
            <div class="card">
                <h3>My Profile</h3>
                <p><strong>Email:</strong> <%= session.getAttribute("studentEmail") %></p>
                <p><strong>Department:</strong> <%= session.getAttribute("studentDept") %></p>
                <p><strong>Phone:</strong> <%= session.getAttribute("studentPhone") %></p>
            </div>
        </div>
    <% } %>
    
    <!-- ADMIN DASHBOARD -->
    <% if("adminDashboard".equals(page_view) && session.getAttribute("userType") != null && "admin".equals(session.getAttribute("userType"))) { 
        List<Object[]> students = new ArrayList<>();
        List<String[]> allCourses = new ArrayList<>();
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            Statement stmt = conn.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT student_id, full_name, email, department, phone FROM students WHERE student_id != 'ADMIN001' ORDER BY department, full_name");
            while(rs.next()) {
                students.add(new Object[]{rs.getString("student_id"), rs.getString("full_name"), rs.getString("email"), rs.getString("department"), rs.getString("phone")});
            }
            
            ResultSet rs2 = stmt.executeQuery("SELECT course_code, course_name, credit_hours, department, year_level FROM courses ORDER BY department, course_code");
            while(rs2.next()) {
                allCourses.add(new String[]{rs2.getString("course_code"), rs2.getString("course_name"), 
                                           String.valueOf(rs2.getInt("credit_hours")), rs2.getString("department"),
                                           String.valueOf(rs2.getInt("year_level"))});
            }
            conn.close();
        } catch(Exception e) { error = "Database Error: " + e.getMessage(); }
    %>
        <div class="dashboard-header">
            <h2>Admin Dashboard</h2>
            <p>Welcome, <%= session.getAttribute("adminName") %>!</p>
            <a href="?action=logout" class="logout-btn">Logout</a>
        </div>
        
        <div class="tab">
            <button class="tablinks active" onclick="openTab(event, 'Students')">Students Management</button>
            <button class="tablinks" onclick="openTab(event, 'Courses')">Courses Management</button>
            <button class="tablinks" onclick="openTab(event, 'Enrollments')">Enrollments</button>
        </div>
        
        <!-- Students Tab -->
        <div id="Students" class="tabcontent" style="display:block">
            <div class="card">
                <h3>Add New Student</h3>
                <form method="post">
                    <input type="hidden" name="action" value="adminCreate">
                    <div class="grid-2">
                        <div><input type="text" name="studentId" placeholder="Student ID (e.g., CS001/25)" required></div>
                        <div><input type="text" name="fullName" placeholder="Full Name" required></div>
                        <div><input type="email" name="email" placeholder="Email" required></div>
                        <div><input type="password" name="password" placeholder="Password" required></div>
                        <div>
                            <select name="department" required>
                                <option>Computer Science</option>
                                <option>Software Engineering</option>
                                <option>Information Technology</option>
                                <option>Electrical Engineering</option>
                                <option>Civil Engineering</option>
                                <option>Mechanical Engineering</option>
                                <option>Chemical Engineering</option>
                                <option>Accounting and Finance</option>
                                <option>Marketing Management</option>
                                <option>Public Health</option>
                            </select>
                        </div>
                        <div><input type="text" name="phone" placeholder="Phone"></div>
                    </div>
                    <button type="submit">Add Student</button>
                </form>
            </div>
            
            <div class="card">
                <h3>All Students List</h3>
                <div class="table-responsive">
                    <table style="width: 100%; border-collapse: collapse;">
                        <thead>
                            <tr style="background: #667eea; color: white;">
                                <th style="padding: 12px; border: 1px solid #ddd;">Student ID</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Full Name</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Email</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Department</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Phone</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(Object[] s : students) { %>
                            <tr style="border: 1px solid #ddd;">
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= s[0] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= s[1] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= s[2] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= s[3] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= s[4] != null ? s[4] : "N/A" %></td>
                                <td style="padding: 10px; border: 1px solid #ddd; white-space: nowrap;">
                                    <button class="btn-edit" onclick="editStudent('<%= s[0] %>','<%= s[1] %>','<%= s[2] %>','<%= s[3] %>','<%= s[4] %>')">Edit</button>
                                    <form method="post" style="display:inline;" onsubmit="return confirm('Delete this student?')">
                                        <input type="hidden" name="action" value="adminDelete">
                                        <input type="hidden" name="studentId" value="<%= s[0] %>">
                                        <button type="submit" class="btn-delete">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Courses Tab -->
        <div id="Courses" class="tabcontent">
            <div class="card">
                <h3>Add New Course</h3>
                <div class="info-box">
                    <strong>Note:</strong> Each course is assigned to a specific department. Students can only enroll in courses from their own department.
                </div>
                <form method="post">
                    <input type="hidden" name="action" value="adminAddCourse">
                    <div class="grid-2">
                        <div><input type="text" name="courseCode" placeholder="Course Code (e.g., CS101)" required></div>
                        <div><input type="text" name="courseName" placeholder="Course Name" required></div>
                        <div><input type="number" name="creditHours" placeholder="Credit Hours" required></div>
                        <div>
                            <label>Department:</label>
                            <select name="department" required>
                                <option value="">Select Department</option>
                                <option>Computer Science</option>
                                <option>Software Engineering</option>
                                <option>Information Technology</option>
                                <option>Electrical Engineering</option>
                                <option>Civil Engineering</option>
                                <option>Mechanical Engineering</option>
                                <option>Chemical Engineering</option>
                                <option>Accounting and Finance</option>
                                <option>Marketing Management</option>
                                <option>Public Health</option>
                            </select>
                        </div>
                        <div>
                            <label>Year Level:</label>
                            <select name="yearLevel" required>
                                <option value="1">Year 1</option>
                                <option value="2">Year 2</option>
                                <option value="3">Year 3</option>
                                <option value="4">Year 4</option>
                            </select>
                        </div>
                    </div>
                    <button type="submit" class="btn-add">Add Course</button>
                </form>
            </div>
            
            <div class="card">
                <h3>All Courses List</h3>
                <div class="table-responsive">
                    <table style="width: 100%; border-collapse: collapse;">
                        <thead>
                            <tr style="background: #667eea; color: white;">
                                <th style="padding: 12px; border: 1px solid #ddd;">Course Code</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Course Name</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Credits</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Department</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Year</th>
                                <th style="padding: 12px; border: 1px solid #ddd;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(String[] c : allCourses) { %>
                            <tr style="border: 1px solid #ddd;">
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= c[0] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= c[1] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= c[2] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= c[3] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd;"><%= c[4] %></td>
                                <td style="padding: 10px; border: 1px solid #ddd; white-space: nowrap;">
                                    <form method="post" style="display:inline;" onsubmit="return confirm('Delete this course? Students will be removed from this course!')">
                                        <input type="hidden" name="action" value="adminDeleteCourse">
                                        <input type="hidden" name="courseCode" value="<%= c[0] %>">
                                        <button type="submit" class="btn-delete">Delete</button>
                                    </form>
                                 </td>
                             </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Enrollments Tab -->
        <div id="Enrollments" class="tabcontent">
            <div class="card">
                <h3>Enroll Student in Course</h3>
                <div class="warning-box">
                    <strong>IMPORTANT RULE:</strong> Students can ONLY be enrolled in courses from their own department!<br>
                    <strong>How it works:</strong> Select a department first, then only students and courses from that department will appear.
                </div>
                
                <form method="post" onsubmit="return validateEnrollment()">
                    <input type="hidden" name="action" value="adminEnroll">
                    
                    <div class="grid-2">
                        <div class="form-group">
                            <label>Select Student:</label>
                            <select name="studentId" id="studentSelect" required>
                                <option value="">-- Select Student --</option>
                                <% for(Object[] s : students) { %>
                                    <option value="<%= s[0] %>" data-dept="<%= s[3] %>"><%= s[1] %> - <%= s[3] %> (<%= s[0] %>)</option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Select Course:</label>
                            <select name="courseCode" id="courseSelect" required>
                                <option value="">-- Select Course --</option>
                                <% for(String[] c : allCourses) { %>
                                    <option value="<%= c[0] %>" data-dept="<%= c[3] %>"><%= c[0] %> - <%= c[1] %> (<%= c[2] %> credits) - <%= c[3] %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    
                    <div id="warningMsg" style="display:none; background:#ffebee; color:#c62828; padding:12px; margin:15px 0; border-radius:5px;"></div>
                    <div id="successMsg" style="display:none; background:#e8f5e9; color:#2e7d32; padding:12px; margin:15px 0; border-radius:5px;"></div>
                    
                    <button type="submit" id="enrollBtn" style="background: #4CAF50; padding: 12px 25px; font-size: 16px;">
                        Enroll Student
                    </button>
                </form>
            </div>
        </div>
        
        <script>
            function openTab(evt, tabName) {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }
                document.getElementById(tabName).style.display = "block";
                evt.currentTarget.className += " active";
            }
            
            function editStudent(id, name, email, dept, phone) {
                document.getElementById('editId').value = id;
                document.getElementById('editName').value = name;
                document.getElementById('editEmail').value = email;
                document.getElementById('editDept').value = dept;
                document.getElementById('editPhone').value = phone || '';
                document.getElementById('editModal').style.display = 'block';
            }
            
            function closeModal() {
                document.getElementById('editModal').style.display = 'none';
            }
            
            const studentSelect = document.getElementById('studentSelect');
            const courseSelect = document.getElementById('courseSelect');
            const warningMsg = document.getElementById('warningMsg');
            const successMsg = document.getElementById('successMsg');
            const enrollBtn = document.getElementById('enrollBtn');
            
            function checkMatch() {
                if(studentSelect.value && courseSelect.value) {
                    const studentDept = studentSelect.options[studentSelect.selectedIndex].getAttribute('data-dept');
                    const courseDept = courseSelect.options[courseSelect.selectedIndex].getAttribute('data-dept');
                    const studentName = studentSelect.options[studentSelect.selectedIndex].text;
                    const courseText = courseSelect.options[courseSelect.selectedIndex].text;
                    
                    if(studentDept !== courseDept) {
                        warningMsg.innerHTML = 'Warning: Student department (' + studentDept + ') does not match course department (' + courseDept + ')!';
                        warningMsg.style.display = 'block';
                        successMsg.style.display = 'none';
                        enrollBtn.disabled = true;
                        enrollBtn.style.opacity = '0.5';
                    } else {
                        warningMsg.style.display = 'none';
                        successMsg.innerHTML = 'Valid! Student and course are from the same department: ' + studentDept;
                        successMsg.style.display = 'block';
                        enrollBtn.disabled = false;
                        enrollBtn.style.opacity = '1';
                    }
                } else {
                    warningMsg.style.display = 'none';
                    successMsg.style.display = 'none';
                    enrollBtn.disabled = true;
                    enrollBtn.style.opacity = '0.5';
                }
            }
            
            function validateEnrollment() {
                const studentDept = studentSelect.options[studentSelect.selectedIndex].getAttribute('data-dept');
                const courseDept = courseSelect.options[courseSelect.selectedIndex].getAttribute('data-dept');
                
                if(studentDept !== courseDept) {
                    alert('Cannot enroll! Student department does not match course department!');
                    return false;
                }
                return confirm('Enroll this student in the selected course?');
            }
            
            studentSelect.addEventListener('change', checkMatch);
            courseSelect.addEventListener('change', checkMatch);
            checkMatch();
        </script>
        
        <!-- Edit Modal -->
        <div id="editModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:1000;">
            <div style="background:white; width:500px; margin:100px auto; padding:30px; border-radius:10px;">
                <h3>Edit Student</h3>
                <form method="post">
                    <input type="hidden" name="action" value="adminUpdate">
                    <input type="hidden" id="editId" name="studentId">
                    <div class="form-group"><label>Full Name:</label><input type="text" id="editName" name="fullName" required></div>
                    <div class="form-group"><label>Email:</label><input type="email" id="editEmail" name="email" required></div>
                    <div class="form-group">
                        <label>Department:</label>
                        <select id="editDept" name="department">
                            <option>Computer Science</option>
                            <option>Software Engineering</option>
                            <option>Information Technology</option>
                            <option>Electrical Engineering</option>
                            <option>Civil Engineering</option>
                            <option>Mechanical Engineering</option>
                            <option>Chemical Engineering</option>
                            <option>Accounting and Finance</option>
                            <option>Marketing Management</option>
                            <option>Public Health</option>
                        </select>
                    </div>
                    <div class="form-group"><label>Phone:</label><input type="text" id="editPhone" name="phone"></div>
                    <button type="submit">Update</button>
                    <button type="button" onclick="closeModal()">Cancel</button>
                </form>
            </div>
        </div>
    <% } %>
    
</div>
</body>
</html>
