<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create News - ${club.clubName}</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <style>
            :root{--bg:#f7fafc;--surface:#ffffff;--muted:#6b7280;--primary:#2563eb;--sidebar-w:250px}

            *{box-sizing:border-box;margin:0;padding:0}

            body{font-family:'Inter',sans-serif;background:var(--bg);min-height:100vh}

            /* Sidebar (kept consistent) */
            .sidebar{width:var(--sidebar-w);background:var(--surface);border-right:1px solid #e6edf3;position:fixed;height:100vh;overflow:auto}
            .sidebar-header{padding:18px 20px;border-bottom:1px solid #f1f5f9}
            .sidebar-header h2{font-size:1.05rem;font-weight:600}
            .sidebar-header p{color:var(--muted);font-size:0.875rem;margin-top:4px}
            .sidebar-menu{list-style:none;padding:10px 0}
            .sidebar-menu li{margin:6px 8px}
            .sidebar-menu a{display:block;padding:10px 14px;color:var(--muted);text-decoration:none;border-radius:6px;font-weight:500}
            .sidebar-menu a:hover{background:#f1f5f9;color:var(--primary)}
            .sidebar-menu a.active{background:#eef2ff;color:var(--primary);font-weight:600}

            .main-content{margin-left:var(--sidebar-w);padding:28px}

            /* Simple form card */
            .container{max-width:900px;margin:0 auto}
            .form-card{background:var(--surface);border:1px solid #eef2f6;border-radius:10px;padding:20px}
            h1{font-size:20px;font-weight:700;color:#0f172a;margin-bottom:6px}
            .subtitle{color:var(--muted);margin-bottom:12px}

            .form-group{margin-bottom:14px}
            label{display:block;font-weight:600;color:#0f172a;margin-bottom:6px;font-size:14px}
            input[type="text"],textarea,select{width:100%;padding:10px 12px;border:1px solid #e6edf3;border-radius:8px;font-size:14px}
            input[type="text"]:focus,textarea:focus,select:focus{outline:none;border-color:var(--primary);box-shadow:0 0 0 4px rgba(37,99,235,0.06)}

            .button-group{display:flex;gap:12px;margin-top:18px}
            .btn{flex:1;padding:10px 14px;border-radius:8px;border:none;cursor:pointer;display:inline-flex;align-items:center;justify-content:center;gap:8px}
            .btn-primary{background:var(--primary);color:#fff}
            .btn-secondary{background:#f7fafc;color:#0f172a;border:1px solid #eef2f6}

            .alert{padding:10px 12px;border-radius:8px;margin-bottom:12px}
            .alert-error{background:#fff5f5;color:#7f1d1d;border-left:4px solid #f56565}

            .char-count{text-align:right;font-size:12px;color:var(--muted);margin-top:6px}

            @media(max-width:768px){.main-content{margin-left:0;padding:16px}.button-group{flex-direction:column}}
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
            <div class="form-card">
                <h1><i class="bi bi-newspaper"></i> Create News</h1>
                <p class="subtitle">${club.clubName}</p>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/leader/create-news">
                    <input type="hidden" name="clubId" value="${club.clubID}">

                    <div class="form-group">
                        <label for="title">News Title *</label>
                        <input type="text" 
                               id="title" 
                               name="title" 
                               placeholder="Enter news title"
                               maxlength="200"
                               required>
                        <div class="char-count" id="titleCount">0/200</div>
                    </div>

                    <div class="form-group">
                        <label for="content">Content *</label>
                        <textarea id="content" 
                                  name="content" 
                                  placeholder="Write your news content here..."
                                  required></textarea>
                        <div class="char-count" id="contentCount">0 characters</div>
                    </div>

                    <div class="form-group">
                        <label for="status">Status *</label>
                        <select id="status" name="status" required>
                            <option value="">Select status</option>
                            <option value="Draft">Draft</option>
                            <option value="Published">Published</option>
                        </select>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-lg"></i> Create News
                        </button>
                        <a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}" 
                           class="btn btn-secondary">
                            <i class="bi bi-x-lg"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
        </div>

        <script>
            // Character counter for title
            const titleInput = document.getElementById('title');
            const titleCount = document.getElementById('titleCount');

            titleInput.addEventListener('input', function () {
                titleCount.textContent = this.value.length + '/200';
            });

            // Character counter for content
            const contentInput = document.getElementById('content');
            const contentCount = document.getElementById('contentCount');

            contentInput.addEventListener('input', function () {
                contentCount.textContent = this.value.length + ' characters';
            });
        </script>
    </body>
</html>