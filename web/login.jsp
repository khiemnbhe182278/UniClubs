<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - UniClubs</title>
        
    <!-- Load baseline CSS so page styles can override admin rules -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

    <style>
            .auth-container {
                min-height: calc(100vh - 140px);
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 3rem;
                background: linear-gradient(180deg, var(--bg) 0%, rgba(255,255,255,0.95) 100%);
                backdrop-filter: blur(10px);
            }
            
            .auth-card {
                background: var(--panel-bg);
                padding: 4rem 3rem;
                border-radius: 20px;
                box-shadow: 
                    0 4px 12px rgba(0,0,0,0.03),
                    0 1px 2px rgba(0,0,0,0.02),
                    0 20px 40px rgba(0,0,0,0.04);
                width: 100%;
                max-width: 640px;
                margin: 0 auto;
                border: 1px solid rgba(0,0,0,0.03);
                animation: slideUp 0.45s cubic-bezier(.2,.9,.3,1) forwards;
                position: relative;
                overflow: hidden;
            }

            .login-form {
                width: 100%;
                max-width: 480px;
                margin: 0 auto;
            }

            .auth-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--accent) 0%, #4f46e5 100%);
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .auth-header {
                text-align: center;
                margin-bottom: 3.5rem;
                animation: fadeIn 0.5s ease-out forwards;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .auth-header h1 {
                font-size: 2.75rem;
                font-weight: 700;
                background: linear-gradient(to right, var(--accent), #4f46e5);
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1rem;
                letter-spacing: -0.02em;
            }

            .auth-header p {
                color: #64748b;
                font-size: 1.2rem;
                max-width: 400px;
                margin: 0 auto;
                line-height: 1.6;
            }

            .form-group {
                margin-bottom: 1.5rem;
                opacity: 0;
                animation: slideIn 0.5s ease-out forwards;
            }

            .form-group:nth-child(1) { animation-delay: 0.1s; }
            .form-group:nth-child(2) { animation-delay: 0.2s; }
            .form-group:nth-child(3) { animation-delay: 0.3s; }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .form-group label {
                display: block;
                margin-bottom: 0.75rem;
                font-weight: 500;
                color: var(--heading);
                font-size: 0.95rem;
                transition: all 0.2s ease;
            }

            .form-control {
                display: block;
                width: 100%;
                padding: 1.1rem 1.25rem;
                font-size: 1.05rem;
                font-weight: 450;
                line-height: 1.5;
                color: var(--text);
                background-color: var(--bg);
                border: 1px solid rgba(0,0,0,0.08);
                border-radius: 12px;
                transition: all 0.2s ease;
            }

            .form-control:hover {
                border-color: rgba(79, 70, 229, 0.25);
                background-color: rgba(255,255,255,0.8);
            }

            .form-control:focus {
                border-color: #4f46e5;
                outline: 0;
                box-shadow: 
                    0 0 0 3px rgba(79, 70, 229, 0.1),
                    0 2px 4px rgba(0,0,0,0.02);
                background-color: white;
            }

            /* Floating label effect */
            .form-group {
                position: relative;
                margin-bottom: 2.5rem;
            }

            .form-group label {
                font-size: 1.1rem;
                margin-bottom: 0.875rem;
                display: block;
                color: var(--text);
                font-weight: 500;
            }

            .form-control::placeholder {
                color: #94a3b8;
                font-size: 1.02rem;
                transition: color 0.2s ease;
            }

            .form-control:focus::placeholder {
                color: #cbd5e1;
            }

            .form-group:focus-within label {
                color: var(--primary);
                transform: translateY(-2px);
            }

            .btn-auth {
                display: block;
                width: 100%;
                padding: 0.9rem 1.25rem;
                background: var(--accent);
                color: white;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                font-size: 1rem;
                text-align: center;
                transition: transform 0.15s ease, box-shadow 0.15s ease;
                cursor: pointer;
                box-shadow: var(--shadow-sm);
                margin-top: 1.25rem;
                opacity: 0;
                animation: fadeIn 0.45s ease-out 0.25s forwards;
            }

            .btn-auth:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
                filter: brightness(0.98);
            }

            .btn-auth:active {
                transform: translateY(1px);
            }

            .auth-footer {
                text-align: center;
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 1px solid rgba(var(--primary-rgb), 0.1);
                font-size: 1rem;
                color: var(--text-muted);
                opacity: 0;
                animation: fadeIn 0.5s ease-out 0.5s forwards;
            }

            .auth-footer a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
                margin-left: 0.5rem;
                transition: all 0.2s ease;
            }

            .auth-footer a:hover {
                color: var(--primary-dark);
                text-decoration: none;
                transform: translateX(3px);
            }

            /* Alert styling */
            .alert {
                margin: 0 auto 2.5rem;
                padding: 1.25rem 1.5rem;
                border-radius: 12px;
                font-size: 1.05rem;
                animation: shake 0.5s ease-in-out;
                max-width: 480px;
            }

            .alert-danger {
                background-color: rgba(220, 53, 69, 0.1);
                color: #dc3545;
                border: 1px solid rgba(220, 53, 69, 0.2);
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                10%, 30%, 50%, 70%, 90% { transform: translateX(-2px); }
                20%, 40%, 60%, 80% { transform: translateX(2px); }
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
                width: 100%;
                max-width: 900px;
            }

            .login-card {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-sm);
                overflow: hidden;
                transition: var(--transition);
                border: 1px solid var(--border-color);
            }

            .row.g-0 {
                min-height: 550px;
            }

            /* Left Side - Branding */
            .brand-section {
                background: var(--primary);
                color: white;
                padding: 3rem 2.5rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
            }

            .brand-content {
                max-width: 400px;
            }

            .brand-logo {
                width: 80px;
                height: 80px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: var(--border-radius);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1.5rem;
                border: 2px solid rgba(255, 255, 255, 0.2);
            }

            .brand-logo-text {
                font-size: 2rem;
                font-weight: 600;
            }

            .brand-section h1 {
                font-size: 2rem;
                font-weight: 600;
                margin-bottom: 1rem;
            }

            .brand-section p {
                font-size: 1rem;
                opacity: 0.9;
                line-height: 1.6;
                margin-bottom: 2rem;
            }

            .feature-list {
                list-style: none;
                padding: 0;
                margin: 2rem 0 0 0;
            }

            .feature-item {
                background: rgba(255, 255, 255, 0.1);
                padding: 1rem 1.5rem;
                border-radius: var(--border-radius);
                margin-bottom: 0.75rem;
                border: 1px solid rgba(255, 255, 255, 0.1);
                transition: var(--transition);
            }

            .feature-item:hover {
                background: rgba(255, 255, 255, 0.15);
            }

            .feature-item h6 {
                font-weight: 600;
                margin-bottom: 0.25rem;
                font-size: 0.95rem;
            }

            .feature-item small {
                opacity: 0.9;
                font-size: 0.85rem;
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
                padding: 1.2rem;
                background: linear-gradient(135deg, var(--accent) 0%, #4f46e5 100%);
                border: none;
                border-radius: 12px;
                font-size: 1.1rem;
                font-weight: 600;
                color: white;
                transition: all 0.2s ease;
                margin-top: 3rem;
                position: relative;
                overflow: hidden;
                letter-spacing: 0.01em;
                display: block;
            }

            .btn-login::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(
                    90deg, 
                    transparent 0%, 
                    rgba(255,255,255,0.1) 50%,
                    transparent 100%
                );
                transition: left 0.5s ease;
            }

            .btn-login:hover::before {
                left: 100%;
            }

            .btn-login:hover {
                transform: translateY(-1px);
                box-shadow: 
                    0 4px 12px rgba(79, 70, 229, 0.2),
                    0 2px 4px rgba(79, 70, 229, 0.1);
                background: linear-gradient(135deg, #4f46e5 0%, var(--accent) 100%);
            }

            .btn-login:active { 
                transform: translateY(1px);
                box-shadow: 
                    0 2px 6px rgba(79, 70, 229, 0.15),
                    0 1px 2px rgba(79, 70, 229, 0.08);
            }

            .divider {
                display: flex;
                align-items: center;
                text-align: center;
                margin: 2.5rem 0;
                opacity: 0;
                animation: fadeIn 0.4s ease-out 0.6s forwards;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(0,0,0,0.06) 50%,
                    transparent 100%
                );
            }

            .divider span {
                padding: 0 2rem;
                font-weight: 500;
                color: #94a3b8;
                font-size: 1rem;
                letter-spacing: 0.025em;
            }

            .link-primary {
                color: var(--accent);
                text-decoration: none;
                font-weight: 600;
                transition: all 0.2s ease;
                position: relative;
                padding: 0.2rem 0;
            }

            .link-primary::after {
                content: '';
                position: absolute;
                width: 0;
                height: 2px;
                bottom: 0;
                left: 0;
                background: linear-gradient(90deg, var(--accent) 0%, #4f46e5 100%);
                transition: width 0.2s ease;
                border-radius: 2px;
                opacity: 0.8;
            }

            .link-primary:hover::after {
                width: 100%;
            }

            .link-primary:hover {
                color: #4f46e5;
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
                margin-top: 2.5rem;
                opacity: 0;
                animation: fadeIn 0.4s ease-out 0.7s forwards;
            }

            .text-links p {
                color: #64748b;
                margin-bottom: 1rem;
                font-size: 1.05rem;
                line-height: 1.6;
            }

            /* Add subtle shadows for depth */
            .auth-card {
                position: relative;
                z-index: 1;
            }
            
            .auth-card::after {
                content: '';
                position: absolute;
                inset: 1px;
                background: linear-gradient(to bottom, rgba(255,255,255,0.07), transparent);
                z-index: 2;
                pointer-events: none;
                border-radius: 15px;
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
    <body class="login-page">
        <%@ include file="header.jsp" %>

        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-header">
                    <h1>Welcome Back!</h1>
                    <p>Sign in to access your UniClubs account</p>
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
                <form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" 
                               class="form-control" 
                               id="email" 
                               name="email" 
                               placeholder="your.email@university.edu" 
                               value="${email}" 
                               required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" 
                               class="form-control" 
                               id="password" 
                               name="password" 
                               placeholder="Enter your password" 
                               required>
                    </div>

                    <button type="submit" class="btn-login">Login to Your Account</button>
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