<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${news.title} - News Detail</title>
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
                max-width: 900px;
                margin: 0 auto;
            }

            .detail-card {
                background: white;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                position: relative;
            }

            .detail-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #2193b0 0%, #6dd5ed 100%);
            }

            .detail-header {
                padding: 40px;
                border-bottom: 2px solid #f7fafc;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                color: #2193b0;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                margin-bottom: 20px;
                transition: all 0.3s ease;
            }

            .back-link:hover {
                gap: 12px;
            }

            .news-title {
                font-size: 36px;
                font-weight: 800;
                color: #2d3748;
                margin-bottom: 20px;
                line-height: 1.3;
            }

            .news-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 25px;
                align-items: center;
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 8px;
                color: #718096;
                font-size: 14px;
                font-weight: 500;
            }

            .meta-item strong {
                color: #2d3748;
            }

            .badge {
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 13px;
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

            .detail-content {
                padding: 40px;
            }

            .content-body {
                color: #4a5568;
                font-size: 16px;
                line-height: 1.8;
                white-space: pre-wrap;
            }

            .detail-actions {
                padding: 30px 40px;
                border-top: 2px solid #f7fafc;
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
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

            .btn-warning {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(243, 156, 18, 0.3);
            }

            .btn-warning:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 25px rgba(243, 156, 18, 0.5);
            }

            .btn-danger {
                background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(245, 101, 101, 0.3);
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 25px rgba(245, 101, 101, 0.5);
            }

            .club-tag {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 10px 18px;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                border-radius: 12px;
                font-weight: 600;
                font-size: 14px;
                margin-bottom: 20px;
            }

            @media (max-width: 768px) {
                .detail-header,
                .detail-content,
                .detail-actions {
                    padding: 25px;
                }

                .news-title {
                    font-size: 28px;
                }

                .news-meta {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }

                .detail-actions {
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                    justify-content: center;
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

            .detail-card {
                animation: fadeIn 0.5s ease;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="detail-card">
                <div class="detail-header">
                    <a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}" 
                       class="back-link">
                        ← Back to News
                    </a>

                    <div class="club-tag">
                        🎓 ${club.clubName}
                    </div>

                    <h1 class="news-title">${news.title}</h1>

                    <div class="news-meta">
                        <div class="meta-item">
                            📅 <strong>Published:</strong> 
                            <fmt:formatDate value="${news.createdAt}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                        </div>
                        <div class="meta-item">
                            📰 <strong>News ID:</strong> #${news.newsID}
                        </div>
                        <span class="badge badge-${news.status.toLowerCase()}">
                            ${news.status}
                        </span>
                    </div>
                </div>

                <div class="detail-content">
                    <div class="content-body">
                        ${news.content}
                    </div>
                </div>

                <div class="detail-actions">
                    <a href="${pageContext.request.contextPath}/leader/update-news?id=${news.newsID}&clubId=${club.clubID}" 
                       class="btn btn-warning">
                        ✏️ Edit News
                    </a>
                    <form method="post" 
                          action="${pageContext.request.contextPath}/leader/delete-news" 
                          style="display: inline;">
                        <input type="hidden" name="newsId" value="${news.newsID}">
                        <input type="hidden" name="clubId" value="${club.clubID}">
                        <button type="submit" 
                                class="btn btn-danger" 
                                onclick="return confirm('Are you sure you want to delete this news? This action cannot be undone.')">
                            🗑️ Delete News
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>