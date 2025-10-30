<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage News</title>
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
                max-width: 1000px;
                margin: 0 auto;
            }
            .header {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .btn-create {
                background: #2193b0;
                color: white;
                padding: 0.8rem 1.5rem;
                border-radius: 10px;
                text-decoration: none;
            }
            .news-card {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                margin-bottom: 1rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .news-card h2 {
                color: #2193b0;
                margin-bottom: 0.5rem;
            }
            .news-card .date {
                color: #999;
                font-size: 0.9rem;
                margin-bottom: 1rem;
            }
            .news-card .content {
                color: #666;
                line-height: 1.6;
                margin-bottom: 1rem;
            }
            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-right: 0.5rem;
            }
            .btn-delete {
                background: #e74c3c;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>News Posts - ${club.clubName}</h1>
                <!-- Pass both clubId and clubID for compatibility -->
                <a href="${pageContext.request.contextPath}/leader/create-news?clubId=${club.clubID}&amp;clubID=${club.clubID}" class="btn-create">+ Create News</a>
            </div>
            <c:forEach var="news" items="${newsList}">
                <div class="news-card">
                    <h2>${news.title}</h2>
                    <div class="date"><fmt:formatDate value="${news.createdAt}" pattern="MMMM dd, yyyy"/></div>
                    <div class="content">${news.content}</div>
                    <div>
                        <span style="padding: 0.3rem 0.8rem; background: #e3f2fd; color: #1976d2; border-radius: 20px; font-size: 0.85rem;">${news.status}</span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
</html>