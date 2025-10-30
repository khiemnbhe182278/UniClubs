<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account - Admin</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                display: flex;
            }
            .sidebar {
                width: 250px;
                background: #2c3e50;
                min-height: 100vh;
                color: white;
                position: fixed;
            }
            .sidebar-header {
                padding: 2rem;
                background: #34495e;
                text-align: center;
            }
            .sidebar-menu {
                list-style: none;
                padding: 1rem 0;
            }
            .sidebar-menu a {
                display: block;
                padding: 1rem 2rem;
                color: white;
                text-decoration: none;
            }
            .sidebar-menu a:hover {
                background: #34495e;
            }
            .main-content {
                margin-left: 250px;
                flex: 1;
                padding: 2rem;
            }
            .form-container {
                max-width: 800px;
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .form-header {
                margin-bottom: 2rem;
            }
            .form-header h1 {
                color: #2c3e50;
            }
            .form-group {
                margin-bottom: 1.5rem;
            }
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
            }
            .form-group input, .form-group select {
                width: 100%;
                padding: 0.8rem;
                border: 2px solid #ddd;
                border-radius: 10px;
                font-size: 1rem;
            }
            .form-group input:focus, .form-group select:focus {
                outline: none;
                border-color: #3498db;
            }
            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }
            .btn-submit {
                width: 100%;
                padding: 1rem;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
            }
            .btn-submit:hover {
                background: #2980b9;
            }
            .alert {
                padding: 1rem;
                border-radius: 10px;
                margin-bottom: 1.5rem;
            }
            .alert-error {
                background: #f8d7da;
                color: #721c24;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header"><h2>🎓 Admin Panel</h2></div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">👤 Manage Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/clubs">🏛️ Manage Clubs</a></li>
            </ul>
        </div>
        <div class="main-content">
            <div class="form-container">
                <div class="form-header">
                    <h1>Create New Account</h1>
                    <p>Create an account for club supervisor or staff member</p>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/create-account" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="userName">Username *</label>
                            <input type="text" id="userName" name="userName" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email *</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password *</label>
                            <input type="password" id="password" name="password" required minlength="6">
                        </div>
                        <div class="form-group">
                            <label for="roleId">Role *</label>
                            <select id="roleId" name="roleId" required>
                                <option value="">Select Role</option>
                                <option value="2">Faculty Advisor</option>
                                <option value="3">Club Leader</option>
                                <option value="4">Member</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fullName">Full Name</label>
                            <input type="text" id="fullName" name="fullName">
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="tel" id="phone" name="phone">
                        </div>
                    </div>
                    <button type="submit" class="btn-submit">Create Account</button>
                </form>
            </div>
        </div>
    </body>
</html>

