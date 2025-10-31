<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Club - Leader</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                padding: 2rem;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #2193b0;
                margin-bottom: 2rem;
            }
            .form-group {
                margin-bottom: 1.5rem;
            }
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
            }
            .form-group input, .form-group textarea, .form-group select {
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
            .btn-submit {
                width: 100%;
                padding: 1rem;
                background: #2193b0;
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
            }
            .btn-back {
                display: inline-block;
                color: #2193b0;
                text-decoration: none;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}&amp;clubID=${club.clubID}" class="btn-back">← Back to Dashboard</a>
        <div class="container">
            <h1>Update Club Information</h1>
            <form action="${pageContext.request.contextPath}/leader/update-club" method="post">
                <input type="hidden" name="clubId" value="${club.clubID}">
                <div class="form-group">
                    <label for="clubName">Club Name *</label>
                    <input type="text" id="clubName" name="clubName" value="${club.clubName}" required>
                </div>
                <div class="form-group">
                    <label for="description">Description *</label>
                    <textarea id="description" name="description" required>${club.description}</textarea>
                </div>
                <div class="form-group">
                    <label for="categoryId">Category</label>
                    <select id="categoryId" name="categoryId">
                        <option value="">Select Category</option>
                        <option value="1">Technology</option>
                        <option value="2">Arts & Culture</option>
                        <option value="3">Sports & Fitness</option>
                        <option value="4">Academic</option>
                        <option value="5">Social & Community</option>
                        <option value="6">Professional Development</option>
                    </select>
                </div>
                <button type="submit" class="btn-submit">Update Club</button>
            </form>
        </div>
    </body>
</html>
