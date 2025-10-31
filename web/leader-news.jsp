<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage News - ${club.clubName}</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                min-height: 100vh;
                padding: 40px 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .header {
                background: white;
                padding: 30px;
                border-radius: 20px;
                margin-bottom: 30px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header h1 {
                font-size: 28px;
                font-weight: 700;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 12px;
                font-weight: 600;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(33, 147, 176, 0.3);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 25px rgba(33, 147, 176, 0.5);
            }

            .btn-back {
                background: #f7fafc;
                color: #2d3748;
                border: 2px solid #e2e8f0;
            }

            .btn-back:hover {
                background: #edf2f7;
                transform: translateY(-2px);
            }

            .news-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                gap: 25px;
                margin-bottom: 30px;
            }

            .news-card {
                background: white;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
                position: relative;
            }

            .news-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
            }

            .news-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #2193b0 0%, #6dd5ed 100%);
            }

            .news-header {
                padding: 25px;
                border-bottom: 2px solid #f7fafc;
            }

            .news-title {
                font-size: 20px;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 10px;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .news-meta {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 10px;
            }

            .news-date {
                color: #718096;
                font-size: 13px;
                font-weight: 500;
            }

            .badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .badge-published {
                background: #d4f4dd;
                color: #22543d;
            }

            .badge-draft {
                background: #fef5e7;
                color: #f39c12;
            }

            .news-content {
                padding: 20px 25px;
                color: #4a5568;
                font-size: 14px;
                line-height: 1.6;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .news-actions {
                padding: 20px 25px;
                border-top: 2px solid #f7fafc;
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .btn-sm {
                padding: 8px 16px;
                font-size: 13px;
            }

            .btn-info {
                background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
                color: white;
            }

            .btn-info:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
            }

            .btn-warning {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                color: white;
            }

            .btn-warning:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(243, 156, 18, 0.4);
            }

            .btn-danger {
                background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
                color: white;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(245, 101, 101, 0.4);
            }

            .no-data {
                background: white;
                padding: 80px 40px;
                border-radius: 20px;
                text-align: center;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            }

            .no-data::before {
                content: "📰";
                font-size: 72px;
                display: block;
                margin-bottom: 20px;
                opacity: 0.5;
            }

            .no-data p {
                color: #718096;
                font-size: 18px;
                font-weight: 500;
                margin-bottom: 25px;
            }

            .header-actions {
                display: flex;
                gap: 15px;
            }

            @media (max-width: 768px) {
                .header {
                    flex-direction: column;
                    gap: 20px;
                    text-align: center;
                }

                .header-actions {
                    width: 100%;
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                    justify-content: center;
                }

                .news-grid {
                    grid-template-columns: 1fr;
                }
            }

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

            .news-card {
                animation: fadeIn 0.5s ease;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div>
                    <h1>📰 Manage News</h1>
                    <p style="color: #718096; margin-top: 5px; font-weight: 500;">${club.clubName}</p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/leader/create-news?clubId=${club.clubID}" class="btn btn-primary">
                        ➕ Create News
                    </a>
                    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}" class="btn btn-back">
                        ← Back
                    </a>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty newsList}">
                    <div class="news-grid">
                        <c:forEach var="news" items="${newsList}">
                            <div class="news-card">
                                <div class="news-header">
                                    <h3 class="news-title">${news.title}</h3>
                                    <div class="news-meta">
                                        <span class="news-date">
                                            📅 <fmt:formatDate value="${news.createdAt}" pattern="MMM dd, yyyy"/>
                                        </span>
                                        <span class="badge badge-${news.status.toLowerCase()}">
                                            ${news.status}
                                        </span>
                                    </div>
                                </div>
                                <div class="news-content">
                                    ${news.content}
                                </div>
                                <div class="news-actions">
                                    <a href="${pageContext.request.contextPath}/leader/news-detail?id=${news.newsID}&clubId=${club.clubID}" 
                                       class="btn btn-info btn-sm">
                                        👁️ View
                                    </a>
                                    <a href="${pageContext.request.contextPath}/leader/update-news?id=${news.newsID}&clubId=${club.clubID}" 
                                       class="btn btn-warning btn-sm">
                                        ✏️ Edit
                                    </a>
                                    <form method="post" 
                                          action="${pageContext.request.contextPath}/leader/delete-news" 
                                          style="display: inline;">
                                        <input type="hidden" name="newsId" value="${news.newsID}">
                                        <input type="hidden" name="clubId" value="${club.clubID}">
                                        <button type="submit" 
                                                class="btn btn-danger btn-sm" 
                                                onclick="return confirm('Are you sure you want to delete this news?')">
                                            🗑️ Delete
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <p>No news yet</p>
                        <a href="${pageContext.request.contextPath}/leader/create-news?clubId=${club.clubID}" 
                           class="btn btn-primary">
                            ➕ Create Your First News
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>