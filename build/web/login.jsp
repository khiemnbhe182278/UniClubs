<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - UniClubs</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2193b0;
                --secondary-color: #6dd5ed;
                --dark-color: #1a1a2e;
                --light-color: #f8f9fa;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                padding: 20px;
                position: relative;
                overflow: hidden;
            }

            /* Animated background shapes */
            body::before {
                content: '';
                position: absolute;
                width: 500px;
                height: 500px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                top: -250px;
                right: -250px;
                animation: float 6s ease-in-out infinite;
            }

            body::after {
                content: '';
                position: absolute;
                width: 400px;
                height: 400px;
                background: rgba(255, 255, 255, 0.08);
                border-radius: 50%;
                bottom: -200px;
                left: -200px;
                animation: float 8s ease-in-out infinite reverse;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0) rotate(0deg);
                }
                50% {
                    transform: translateY(-30px) rotate(5deg);
                }
            }

            .login-container {
                position: relative;
                z-index: 1;
                width: 100%;
                max-width: 950px;
            }

            .login-card {
                background: white;
                border-radius: 24px;
                box-shadow: 0 20px 60px rgba(0,0,0,0.3);
                overflow: hidden;
                backdrop-filter: blur(10px);
                transition: transform 0.3s ease;
            }

            .login-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 25px 70px rgba(0,0,0,0.35);
            }

            .row.g-0 {
                min-height: 600px;
            }

            /* Left Side - Branding */
            .brand-section {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 3rem 2.5rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .brand-section::before {
                content: '';
                position: absolute;
                width: 300px;
                height: 300px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                top: -100px;
                right: -100px;
            }

            .brand-section::after {
                content: '';
                position: absolute;
                width: 200px;
                height: 200px;
                background: rgba(255, 255, 255, 0.08);
                border-radius: 50%;
                bottom: -50px;
                left: -50px;
            }

            .brand-content {
                position: relative;
                z-index: 1;
            }

            .brand-logo {
                width: 100px;
                height: 100px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1.5rem;
                backdrop-filter: blur(10px);
                border: 2px solid rgba(255, 255, 255, 0.3);
            }

            .brand-logo-text {
                font-size: 2.5rem;
                font-weight: 800;
                letter-spacing: -1px;
            }

            .brand-section h1 {
                font-size: 2.8rem;
                font-weight: 800;
                margin-bottom: 1rem;
                letter-spacing: -1px;
            }

            .brand-section p {
                font-size: 1.15rem;
                opacity: 0.95;
                line-height: 1.6;
                margin-bottom: 2rem;
            }

            .feature-list {
                list-style: none;
                padding: 0;
                margin: 2rem 0 0 0;
            }

            .feature-item {
                background: rgba(255, 255, 255, 0.15);
                padding: 1rem 1.5rem;
                border-radius: 12px;
                margin-bottom: 1rem;
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
                transition: all 0.3s ease;
            }

            .feature-item:hover {
                background: rgba(255, 255, 255, 0.25);
                transform: translateX(5px);
            }

            .feature-item h6 {
                font-weight: 700;
                margin-bottom: 0.25rem;
                font-size: 1rem;
            }

            .feature-item small {
                opacity: 0.9;
                font-size: 0.875rem;
            }

            /* Right Side - Form */
            .form-section {
                padding: 3rem 2.5rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .form-header {
                margin-bottom: 2rem;
            }

            .form-header h2 {
                font-size: 2rem;
                font-weight: 700;
                color: #1a1a2e;
                margin-bottom: 0.5rem;
            }

            .form-header p {
                color: #6c757d;
                font-size: 1rem;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 0.5rem;
                font-size: 0.95rem;
                display: block;
            }

            .form-control {
                padding: 0.875rem 1.25rem;
                border: 2px solid #e9ecef;
                border-radius: 12px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: #f8f9fa;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.15);
                background: white;
                outline: none;
            }

            .form-control::placeholder {
                color: #adb5bd;
            }

            .btn-login {
                width: 100%;
                padding: 1rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 12px;
                font-size: 1.05rem;
                font-weight: 600;
                color: white;
                transition: all 0.3s ease;
                margin-top: 0.5rem;
                position: relative;
                overflow: hidden;
            }

            .btn-login::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: left 0.5s ease;
            }

            .btn-login:hover::before {
                left: 100%;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            .btn-login:active {
                transform: translateY(0);
            }

            .divider {
                display: flex;
                align-items: center;
                text-align: center;
                color: #999;
                margin: 2rem 0;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                border-bottom: 2px solid #e9ecef;
            }

            .divider span {
                padding: 0 1.25rem;
                font-weight: 600;
                color: #6c757d;
                font-size: 0.9rem;
            }

            .link-primary {
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                position: relative;
            }

            .link-primary::after {
                content: '';
                position: absolute;
                width: 0;
                height: 2px;
                bottom: -2px;
                left: 0;
                background: #667eea;
                transition: width 0.3s ease;
            }

            .link-primary:hover::after {
                width: 100%;
            }

            .link-primary:hover {
                color: #764ba2;
            }

            .alert {
                border-radius: 12px;
                border: none;
                font-weight: 500;
                padding: 1rem 1.25rem;
                margin-bottom: 1.5rem;
                animation: slideIn 0.3s ease;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .alert-danger {
                background: linear-gradient(135deg, #fff5f5 0%, #ffe0e0 100%);
                color: #c53030;
                border-left: 4px solid #c53030;
            }

            .alert-success {
                background: linear-gradient(135deg, #f0fff4 0%, #c6f6d5 100%);
                color: #22543d;
                border-left: 4px solid #38a169;
            }

            .text-links {
                text-align: center;
                margin-top: 1.5rem;
            }

            .text-links p {
                color: #6c757d;
                margin-bottom: 0.75rem;
                font-size: 0.95rem;
            }

            /* Responsive Design */
            @media (max-width: 991px) {
                .brand-section {
                    padding: 2.5rem 2rem;
                }

                .brand-section h1 {
                    font-size: 2.2rem;
                }

                .feature-list {
                    display: none;
                }
            }

            @media (max-width: 767px) {
                body {
                    padding: 10px;
                }

                .login-card {
                    border-radius: 20px;
                }

                .form-section {
                    padding: 2rem 1.5rem;
                }

                .brand-section {
                    padding: 2rem 1.5rem;
                }

                .form-header h2 {
                    font-size: 1.75rem;
                }

                .brand-section h1 {
                    font-size: 2rem;
                }
            }

            /* Input focus animation */
            .form-floating {
                position: relative;
                margin-bottom: 1.5rem;
            }

            .input-group {
                position: relative;
            }

            .input-group .form-control {
                padding-left: 1.25rem;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-card">
                <div class="row g-0">
                    <!-- Left Side - Branding -->
                    <div class="col-lg-5 d-none d-lg-block">
                        <div class="brand-section">
                            <div class="brand-content">
                                <div class="brand-logo">
                                    <span class="brand-logo-text">UC</span>
                                </div>
                                <h1>UniClubs</h1>
                                <p>Connect, Collaborate, and Grow with your university community</p>

                                <ul class="feature-list">
                                    <li class="feature-item">
                                        <h6>Join Clubs</h6>
                                        <small>Discover and join clubs that match your interests</small>
                                    </li>
                                    <li class="feature-item">
                                        <h6>Network</h6>
                                        <small>Connect with students who share your passions</small>
                                    </li>
                                    <li class="feature-item">
                                        <h6>Events</h6>
                                        <small>Stay updated with upcoming activities and workshops</small>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Right Side - Login Form -->
                    <div class="col-lg-7">
                        <div class="form-section">
                            <div class="form-header">
                                <h2>Welcome Back!</h2>
                                <p>Please login to access your account</p>
                            </div>

                            <!-- Error Alert -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <!-- Success Alert -->
                            <c:if test="${not empty success}">
                                <div class="alert alert-success" role="alert">
                                    ${success}
                                </div>
                            </c:if>

                            <!-- Login Form -->
                            <form action="${pageContext.request.contextPath}/login" method="post">
                                <div class="mb-4">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" 
                                           class="form-control" 
                                           id="email" 
                                           name="email" 
                                           placeholder="your.email@university.edu" 
                                           value="${email}" 
                                           required>
                                </div>

                                <div class="mb-4">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" 
                                           class="form-control" 
                                           id="password" 
                                           name="password" 
                                           placeholder="Enter your password" 
                                           required>
                                </div>

                                <button type="submit" class="btn btn-login">Login to Your Account</button>
                            </form>

                            <!-- Divider -->
                            <div class="divider">
                                <span>OR</span>
                            </div>

                            <!-- Links -->
                            <div class="text-links">
                                <p>Don't have an account? 
                                    <a href="${pageContext.request.contextPath}/register" class="link-primary">Create one now</a>
                                </p>
                                <p class="mb-0">
                                    <a href="${pageContext.request.contextPath}/home" class="link-primary">Return to Homepage</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>