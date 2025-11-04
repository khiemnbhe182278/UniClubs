<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage News - ${club.clubName}</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <style>
            /* Minimal / flat theme */
            :root{
                --bg: #f7fafc;
                --surface: #ffffff;
                --muted: #6b7280;
                --primary: #2563eb;
                --sidebar-w: 250px;
            }

            *{box-sizing:border-box;margin:0;padding:0}

            body{
                font-family: 'Inter', system-ui, -apple-system, sans-serif;
                background: var(--bg);
                color: #111827;
                display:flex;
                min-height:100vh;
            }

            /* Sidebar (kept same structure but simplified visuals) */
            .sidebar{width:var(--sidebar-w);background:var(--surface);border-right:1px solid #e6edf3;position:fixed;height:100vh;overflow:auto;padding:0}
            .sidebar-header{padding:18px 20px;border-bottom:1px solid #f1f5f9}
            .sidebar-header h2{font-size:1.05rem;font-weight:600;color:#0f172a}
            .sidebar-header p{color:var(--muted);font-size:0.875rem;margin-top:4px}
            .sidebar-menu{list-style:none;padding:10px 0}
            .sidebar-menu li{margin:6px 8px}
            .sidebar-menu a{display:block;padding:10px 14px;color:var(--muted);text-decoration:none;border-radius:6px;font-weight:500}
            .sidebar-menu a:hover{background:#f1f5f9;color:var(--primary)}
            .sidebar-menu a.active{background:#eef2ff;color:var(--primary);font-weight:600}

            /* Main content wrapper (minimal) */
            .main-content{margin-left:var(--sidebar-w);padding:28px;flex:1}

            /* Simple cards */
            .header,.news-card,.no-data{background:var(--surface);border:1px solid #eef2f6;border-radius:8px}
            .header{padding:18px;display:flex;justify-content:space-between;align-items:center}
            .news-card{padding:16px;border-radius:8px}
            .news-title{font-size:1.05rem;font-weight:600;color:#0f172a}
            .news-content{color:var(--muted);font-size:0.95rem}

            /* Simple buttons */
            .btn{display:inline-flex;align-items:center;gap:8px;padding:8px 12px;border-radius:8px;border:none;cursor:pointer;text-decoration:none}
            .btn-primary{background:var(--primary);color:#fff}
            .btn-back{background:#f8fafc;color:#0f172a;border:1px solid #e6edf3}
            .btn-info{background:#0ea5a4;color:#fff}
            .btn-warning{background:#f59e0b;color:#fff}
            .btn-danger{background:#ef4444;color:#fff}

            @media (max-width:768px){
                .main-content{margin-left:0;padding:16px}
                .sidebar{position:relative;width:100%;height:auto}
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
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 2; /* keep truncated but compatible */
                line-clamp: 2;
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
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 3; /* extra compatibility */
                line-clamp: 3;
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
        <div class="sidebar">
            <div class="sidebar-header">
                <h2><i class="bi bi-person-badge"></i> Leader Dashboard</h2>
                <p>${club.clubName}</p>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/dashboard')}">class="active"</c:if>>
                        <i class="bi bi-speedometer2"></i> Overview
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/club/members?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/club/members')}">class="active"</c:if>>
                        <i class="bi bi-people"></i> Members
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/events?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/events')}">class="active"</c:if>>
                        <i class="bi bi-calendar3"></i> Events
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/rules?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/rules')}">class="active"</c:if>>
                        <i class="bi bi-file-text"></i> Rules
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/news')}">class="active"</c:if>>
                        <i class="bi bi-newspaper"></i> News
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">
            <div class="container">
            <div class="header">
                <div>
                    <h1><i class="bi bi-newspaper"></i> Manage News</h1>
                    <p style="color: #718096; margin-top: 5px; font-weight: 500;">${club.clubName}</p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/leader/create-news?clubId=${club.clubID}" class="btn btn-primary">
                        <i class="bi bi-plus-lg"></i> Create News
                    </a>
                    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}" class="btn btn-back">
                        <i class="bi bi-arrow-left"></i> Back
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
                                            <i class="bi bi-calendar3"></i>
                                            <fmt:formatDate value="${news.createdAt}" pattern="MMM dd, yyyy"/>
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
                                        <i class="bi bi-eye"></i> View
                                    </a>
                                    <a href="${pageContext.request.contextPath}/leader/update-news?id=${news.newsID}&clubId=${club.clubID}" 
                                       class="btn btn-warning btn-sm">
                                        <i class="bi bi-pencil"></i> Edit
                                    </a>
                                    <form method="post" 
                                          action="${pageContext.request.contextPath}/leader/delete-news" 
                                          style="display: inline;">
                                        <input type="hidden" name="newsId" value="${news.newsID}">
                                        <input type="hidden" name="clubId" value="${club.clubID}">
                                                <button type="submit" 
                                                class="btn btn-danger btn-sm" 
                                                onclick="return confirm('Are you sure you want to delete this news?')">
                                            <i class="bi bi-trash"></i> Delete
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
        </div>
    </body>
</html>