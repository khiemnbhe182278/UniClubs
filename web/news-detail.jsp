<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${news.title} - News Detail</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <style>
            /* Minimal / flat theme for news detail */
            :root{--bg:#f7fafc;--surface:#ffffff;--muted:#6b7280;--primary:#2563eb;--sidebar-w:250px}

            *{box-sizing:border-box;margin:0;padding:0}

            body{font-family:'Inter',system-ui,-apple-system,sans-serif;background:var(--bg);color:#0f172a;display:flex;min-height:100vh}

            /* Sidebar (canonical structure, simple visuals) */
            .sidebar{width:var(--sidebar-w);background:var(--surface);border-right:1px solid #e6edf3;position:fixed;height:100vh;overflow:auto}
            .sidebar-header{padding:18px 20px;border-bottom:1px solid #f1f5f9}
            .sidebar-header h2{font-size:1.05rem;font-weight:600}
            .sidebar-header p{color:var(--muted);font-size:0.875rem;margin-top:4px}
            .sidebar-menu{list-style:none;padding:10px 0}
            .sidebar-menu li{margin:6px 8px}
            .sidebar-menu a{display:block;padding:10px 14px;color:var(--muted);text-decoration:none;border-radius:6px;font-weight:500}
            .sidebar-menu a:hover{background:#f1f5f9;color:var(--primary)}
            .sidebar-menu a.active{background:#eef2ff;color:var(--primary);font-weight:600}

            /* Main content */
            .main-content{margin-left:var(--sidebar-w);padding:28px;flex:1}

            /* Simplified detail card */
            .container{max-width:900px;margin:0 auto}
            .detail-card{background:var(--surface);border-radius:10px;border:1px solid #eef2f6;overflow:hidden}
            .detail-header{padding:20px;border-bottom:1px solid #f1f5f9}
            .back-link{display:inline-flex;align-items:center;gap:8px;color:var(--primary);text-decoration:none;font-weight:600;margin-bottom:12px}
            .news-title{font-size:22px;font-weight:700;color:#0f172a;margin:6px 0}
            .news-meta{display:flex;flex-wrap:wrap;gap:12px;color:var(--muted);font-size:13px}
            .badge{padding:6px 12px;border-radius:14px;font-weight:600;font-size:12px}
            .badge-published{background:#d4f4dd;color:#22543d}
            .badge-draft{background:#fef5e7;color:#f39c12}
            .detail-content{padding:18px}
            .content-body{color:var(--muted);font-size:15px;line-height:1.7;white-space:pre-wrap}
            .detail-actions{padding:16px;border-top:1px solid #f1f5f9;display:flex;gap:12px;flex-wrap:wrap}

            .btn{padding:8px 12px;border-radius:8px;border:none;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;gap:8px}
            .btn-warning{background:#f59e0b;color:#fff}
            .btn-danger{background:#ef4444;color:#fff}

            @media(max-width:768px){.main-content{margin-left:0;padding:16px}.sidebar{position:relative;width:100%;height:auto}}
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
            <div class="detail-card">
                <div class="detail-header">
                    <a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}" 
                       class="back-link">
                        <i class="bi bi-arrow-left"></i> Back to News
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
                        <i class="bi bi-pencil"></i> Edit News
                    </a>
                    <form method="post" 
                          action="${pageContext.request.contextPath}/leader/delete-news" 
                          style="display: inline;">
                        <input type="hidden" name="newsId" value="${news.newsID}">
                        <input type="hidden" name="clubId" value="${club.clubID}">
                        <button type="submit" 
                                class="btn btn-danger" 
                                onclick="return confirm('Are you sure you want to delete this news? This action cannot be undone.')">
                            <i class="bi bi-trash"></i> Delete News
                        </button>
                    </form>
                </div>
            </div>
        </div>
        </div>
    </body>
</html>