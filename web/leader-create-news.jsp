<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Create News</title>
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
            .form-group input, .form-group textarea {
                width: 100%;
                padding: 1rem;
                border: 2px solid #ddd;
                border-radius: 10px;
                font-size: 1rem;
                font-family: inherit;
            }
            .form-group textarea {
                min-height: 300px;
            }
            .btn-submit {
                width: 100%;
                padding: 1rem;
                background: #2193b0;
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 1.1rem;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Create News Post</h1>
            <!-- Normalize club id parameter names so servlets receive either clubId or clubID -->
            <c:set var="clubValue" value="${not empty param.clubId ? param.clubId : (not empty param.clubID ? param.clubID : sessionScope.currentClubId)}" />
            <form action="${pageContext.request.contextPath}/leader/create-news" method="post">
                <!-- provide both parameter names to be safe for different servlets -->
                <input type="hidden" name="clubID" value="${clubValue}">
                <input type="hidden" name="clubId" value="${clubValue}">
                <div class="form-group">
                    <label for="title">Title *</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="content">Content *</label>
                    <textarea id="content" name="content" required placeholder="Write your news content here..."></textarea>
                </div>
                <button type="submit" class="btn-submit">Publish News</button>
            </form>
        </div>
    </body>
</html>