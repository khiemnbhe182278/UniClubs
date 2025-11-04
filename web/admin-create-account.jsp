<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account - Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: #f6f8fb;
                min-height: 100vh;
                display: flex;
                color: #1f2937;
            }

            /* Sidebar */
            .sidebar {
                width: 280px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 20px;
                background: #2b6cb0;
                color: white;
            }

            .sidebar-header h2 {
                font-size: 24px;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .sidebar-menu {
                list-style: none;
                padding: 20px 0;
            }

            .sidebar-menu li {
                margin: 5px 15px;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 14px 18px;
                color: #4a5568;
                text-decoration: none;
                border-radius: 12px;
                transition: all 0.3s ease;
                font-weight: 500;
                font-size: 15px;
            }

            .sidebar-menu a:hover {
                background: #eef2ff;
                color: #2b6cb0;
                transform: translateX(4px);
            }

            /* Main Content */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 40px;
                min-height: 100vh;
            }

            .page-header {
                background: #ffffff;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 6px 18px rgba(16,24,40,0.06);
                margin-bottom: 20px;
                overflow: hidden;
            }

            /* Logout is provided by header.jsp - no per-page logout styling */

            .page-header::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            }

            .page-header h1 {
                color: #2d3748;
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 8px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .page-header p {
                color: #718096;
                font-size: 16px;
            }

            /* Form Container */
            .form-container {
                background: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 6px 18px rgba(16,24,40,0.04);
            }

            .form-header {
                margin-bottom: 35px;
                padding-bottom: 20px;
                border-bottom: 2px solid #e2e8f0;
            }

            .form-header h2 {
                font-size: 24px;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .form-header p {
                color: #718096;
                font-size: 14px;
            }

            /* Alert Messages */
            .alert {
                padding: 16px 20px;
                border-radius: 12px;
                margin-bottom: 25px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 14px;
                font-weight: 500;
            }

            .alert-error {
                background: linear-gradient(135deg, #fed7d7 0%, #feb2b2 100%);
                color: #742a2a;
                border: 1px solid #fc8181;
            }

            .alert-error::before {
                content: "⚠️";
                font-size: 20px;
            }

            .alert-success {
                background: linear-gradient(135deg, #c6f6d5 0%, #9ae6b4 100%);
                color: #22543d;
                border: 1px solid #68d391;
            }

            .alert-success::before {
                content: "✓";
                font-size: 20px;
            }

            /* Form Groups */
            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-group label {
                font-size: 14px;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .form-group label .required {
                color: #e53e3e;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 14px 16px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-size: 14px;
                font-family: 'Inter', sans-serif;
                transition: all 0.3s ease;
                background: white;
                color: #2d3748;
            }

            .form-group input:focus,
            .form-group select:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .form-group input::placeholder {
                color: #a0aec0;
            }

            /* Input Icons */
            .input-wrapper {
                position: relative;
            }

            .input-icon {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 16px;
                color: #718096;
            }

            .input-wrapper input {
                padding-left: 45px;
            }

            /* Password Toggle */
            .password-wrapper {
                position: relative;
            }

            .password-toggle {
                position: absolute;
                right: 16px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                font-size: 18px;
                user-select: none;
            }

            /* Select Styling */
            .form-group select {
                cursor: pointer;
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23718096' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 16px center;
                padding-right: 45px;
            }

            /* Button Styling */
            .form-actions {
                display: flex;
                gap: 15px;
                margin-top: 35px;
                padding-top: 25px;
                border-top: 2px solid #e2e8f0;
            }

            .btn {
                flex: 1;
                padding: 12px 18px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.15s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                text-decoration: none;
            }

            .btn-submit {
                background: #2b6cb0;
                color: white;
            }

            .btn-submit:hover { transform: translateY(-2px); }

            .btn-cancel {
                background: #f1f5f9;
                color: #475569;
                border: 1px solid #e6eef6;
            }

            .btn-cancel:hover {
                background: #edf2f7;
                border-color: #cbd5e0;
            }

            .btn:active {
                transform: translateY(0);
            }

            /* Helper Text */
            .helper-text {
                font-size: 12px;
                color: #718096;
                margin-top: 6px;
            }

            /* Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Responsive */
            @media (max-width: 1024px) {
                .sidebar {
                    width: 240px;
                }
                .main-content {
                    margin-left: 240px;
                    padding: 20px;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                }
                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }
                .page-header {
                    padding: 20px;
                }
                .page-header h1 {
                    font-size: 24px;
                }
                .form-container {
                    padding: 25px;
                }
                .form-row {
                    grid-template-columns: 1fr;
                    gap: 15px;
                }
                .form-actions {
                    flex-direction: column;
                }
            }

            /* Scrollbar */
            ::-webkit-scrollbar {
                width: 8px;
                height: 8px;
            }

            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            ::-webkit-scrollbar-thumb {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 10px;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Admin Panel</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/clubs">🏛️ Manage Clubs</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/events">📅 Manage Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">👤 Manage Users</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1>Create New Account</h1>
                <p>Add a new user to the system with appropriate role and permissions</p>
            </div>

            <div class="form-container">
                <div class="form-header">
                    <h2>👤 Account Information</h2>
                    <p>Fill in the details below to create a new account</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        ${error}
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        ${success}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/create-account" method="post">
                    <!-- Basic Information -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="userName">
                                Username <span class="required">*</span>
                            </label>
                            <div class="input-wrapper">
                                <span class="input-icon">👤</span>
                                <input type="text" id="userName" name="userName" 
                                       placeholder="Enter username" required>
                            </div>
                            <span class="helper-text">Username must be unique</span>
                        </div>

                        <div class="form-group">
                            <label for="email">
                                Email Address <span class="required">*</span>
                            </label>
                            <div class="input-wrapper">
                                <span class="input-icon">📧</span>
                                <input type="email" id="email" name="email" 
                                       placeholder="user@example.com" required>
                            </div>
                            <span class="helper-text">Must be a valid email address</span>
                        </div>
                    </div>

                    <!-- Security Information -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">
                                Password <span class="required">*</span>
                            </label>
                            <div class="input-wrapper password-wrapper">
                                <span class="input-icon">🔒</span>
                                <input type="password" id="password" name="password" 
                                       placeholder="Enter password" required minlength="6">
                                <span class="password-toggle" onclick="togglePassword()">👁️</span>
                            </div>
                            <span class="helper-text">Minimum 6 characters</span>
                        </div>

                        <div class="form-group">
                            <label for="roleId">
                                Role <span class="required">*</span>
                            </label>
                            <select id="roleId" name="roleId" required>
                                <option value="">Select a role</option>
                                <option value="1">Admin</option>
                                <option value="2">Faculty Advisor</option>
                                <option value="3">Club Leader</option>
                                <option value="4">Student</option>
                            </select>
                            <span class="helper-text">Defines user permissions</span>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fullName">Full Name</label>
                            <div class="input-wrapper">
                                <span class="input-icon">📝</span>
                                <input type="text" id="fullName" name="fullName" 
                                       placeholder="Enter full name">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <div class="input-wrapper">
                                <span class="input-icon">📱</span>
                                <input type="tel" id="phone" name="phone" 
                                       placeholder="Enter phone number">
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="submit" class="btn btn-submit">
                            ✓ Create Account
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-cancel">
                            ✗ Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function togglePassword() {
                const passwordInput = document.getElementById('password');
                const toggle = document.querySelector('.password-toggle');

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    toggle.textContent = '🙈';
                } else {
                    passwordInput.type = 'password';
                    toggle.textContent = '👁️';
                }
            }
        </script>
    </body>
</html>