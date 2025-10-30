<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New Club - UniClubs</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                padding-top: 70px;
            }

            header {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                padding: 1rem 0;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
            }

            nav {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 2rem;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: bold;
            }

            nav a {
                color: white;
                text-decoration: none;
            }

            .container {
                max-width: 800px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .form-container {
                background: white;
                padding: 3rem;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .form-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .form-header h1 {
                color: #2193b0;
                margin-bottom: 0.5rem;
            }

            .form-header p {
                color: #666;
            }

            .alert {
                padding: 1rem;
                border-radius: 10px;
                margin-bottom: 1.5rem;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .alert-error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                color: #333;
                font-weight: 500;
            }

            .form-group input,
            .form-group textarea {
                width: 100%;
                padding: 1rem;
                border: 2px solid #ddd;
                border-radius: 10px;
                font-size: 1rem;
                font-family: inherit;
            }

            .form-group textarea {
                min-height: 150px;
                resize: vertical;
            }

            .form-group input:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #2193b0;
            }

            .info-box {
                background: #e3f2fd;
                padding: 1rem;
                border-radius: 10px;
                border-left: 4px solid #2193b0;
                margin-bottom: 1.5rem;
            }

            .info-box p {
                color: #1976d2;
                margin-bottom: 0.5rem;
            }

            .btn-submit {
                width: 100%;
                padding: 1rem;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.3s;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
            }

            .btn-back {
                display: inline-block;
                color: #2193b0;
                text-decoration: none;
                margin-bottom: 1rem;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-back">← Back to Dashboard</a>

            <div class="form-container">
                <div class="form-header">
                    <h1>Create New Club</h1>
                    <p>Start your own university club and build a community</p>
                </div>

                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>

                <div class="info-box">
                    <p><strong>📋 Requirements:</strong></p>
                    <p>• Your club will be reviewed by administrators</p>
                    <p>• Approval typically takes 2-3 business days</p>
                    <p>• Provide clear and detailed information about your club</p>
                </div>

                <form action="${pageContext.request.contextPath}/create-club" method="post">
                    <div class="form-group">
                        <label for="clubName">Club Name *</label>
                        <input type="text" id="clubName" name="clubName" 
                               placeholder="e.g., Technology Innovation Club" 
                               required maxlength="100">
                    </div>

                    <div class="form-group">
                        <label for="description">Club Description *</label>
                        <textarea id="description" name="description" 
                                  placeholder="Describe your club's mission, activities, and goals..." 
                                  required maxlength="500"></textarea>
                        <small style="color: #666;">Maximum 500 characters</small>
                    </div>

                    <button type="submit" class="btn-submit">Submit for Approval</button>
                </form>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>