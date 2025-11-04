<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Members - UniClubs</title>
    
    <!-- Load baseline CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        body {
            background: var(--bg);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .layout-container {
            display: flex;
            flex: 1;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: var(--panel-bg);
            border-right: 1px solid var(--border-color);
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            overflow-y: auto;
            transition: all 0.3s ease;
        }

        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .club-logo {
            width: 40px;
            height: 40px;
            background: var(--primary);
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .club-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--heading);
        }

        .sidebar-menu {
            padding: 1.5rem 0;
        }

        .menu-section {
            margin-bottom: 1.5rem;
            padding: 0 1rem;
        }

        .menu-title {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            margin-bottom: 0.75rem;
            padding: 0 0.5rem;
        }

        .menu-items {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .menu-item {
            margin-bottom: 0.25rem;
        }

        .menu-link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            color: var(--text);
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: all 0.2s ease;
        }

        .menu-link:hover {
            background: var(--bg-light);
            color: var(--primary);
        }

        .menu-link.active {
            background: var(--primary);
            color: white;
        }

        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 2rem;
            width: calc(100% - 280px);
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 600;
            color: var(--heading);
            margin-bottom: 0.5rem;
            letter-spacing: -0.02em;
        }

        .page-subtitle {
            color: var(--text-muted);
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .section-card {
            background: var(--panel-bg);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .section-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--heading);
            margin: 0;
        }

        .section-body {
            padding: 1.5rem;
        }

        .table {
            margin: 0;
        }

        .table th {
            font-weight: 600;
            color: var(--heading);
            background: var(--bg-light);
            padding: 1rem;
            font-size: 0.95rem;
            border-bottom-width: 1px;
        }

        .table td {
            padding: 1rem;
            color: var(--text);
            vertical-align: middle;
            border-bottom-color: var(--border-color);
        }

        .btn-action {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            font-weight: 500;
            border-radius: var(--border-radius);
            transition: all 0.2s ease;
        }

        .btn-approve {
            background: rgba(16, 185, 129, 0.1);
            color: rgb(6, 95, 70);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .btn-approve:hover {
            background: rgba(16, 185, 129, 0.15);
            transform: translateY(-1px);
        }

        .btn-reject {
            background: rgba(239, 68, 68, 0.1);
            color: rgb(153, 27, 27);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .btn-reject:hover {
            background: rgba(239, 68, 68, 0.15);
            transform: translateY(-1px);
        }

        .empty-state {
            text-align: center;
            padding: 2rem;
            color: var(--text-muted);
        }
    </style>
</head>
<body>
    <div class="layout-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="club-logo">
                    ${fn:substring(club.clubName, 0, 1)}
                </div>
                <div class="club-info">
                    <div class="club-name">${club.clubName}</div>
                </div>
            </div>

            <nav class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-title">Club Management</div>
                    <ul class="menu-items">
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/leader/dashboard"
                               <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/dashboard')}">class="menu-link active"</c:if>
                               <c:if test="${!fn:contains(pageContext.request.requestURI, '/leader/dashboard')}">class="menu-link"</c:if>>
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/leader/members"
                               <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/members')}">class="menu-link active"</c:if>
                               <c:if test="${!fn:contains(pageContext.request.requestURI, '/leader/members')}">class="menu-link"</c:if>>
                                <i class="bi bi-people"></i> Members
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/leader/events"
                               <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/events')}">class="menu-link active"</c:if>
                               <c:if test="${!fn:contains(pageContext.request.requestURI, '/leader/events')}">class="menu-link"</c:if>>
                                <i class="bi bi-calendar3"></i> Events
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/leader/news"
                               <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/news')}">class="menu-link active"</c:if>
                               <c:if test="${!fn:contains(pageContext.request.requestURI, '/leader/news')}">class="menu-link"</c:if>>
                                <i class="bi bi-newspaper"></i> News
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="menu-section">
                    <div class="menu-title">Club Settings</div>
                    <ul class="menu-items">
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/leader/update-club"
                               <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/update-club')}">class="menu-link active"</c:if>
                               <c:if test="${!fn:contains(pageContext.request.requestURI, '/leader/update-club')}">class="menu-link"</c:if>>
                                <i class="bi bi-gear"></i> Club Details
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/leader/rules"
                               <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/rules')}">class="menu-link active"</c:if>
                               <c:if test="${!fn:contains(pageContext.request.requestURI, '/leader/rules')}">class="menu-link"</c:if>>
                                <i class="bi bi-file-text"></i> Club Rules
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Manage Club Members</h1>
                <p class="page-subtitle">Review and manage member requests and current members</p>
            </div>

            <!-- Pending Members -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">🕒 Pending Requests</h2>
            </div>
        <div class="section-body">
            <c:choose>
                <c:when test="${empty pendingMembers}">
                    <div class="empty-state">
                        <p>No pending membership requests</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="width: 60px">#</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Requested On</th>
                                    <th style="width: 200px">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="m" items="${pendingMembers}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${m.userName}</td>
                                        <td>${m.email}</td>
                                        <td><fmt:setLocale value="en_US"/><fmt:formatDate value="${m.joinedAt}" pattern="MMM d, yyyy"/></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/leader/members" method="post" class="d-inline-flex gap-2">
                                                <input type="hidden" name="memberId" value="${m.memberID}">
                                                <input type="hidden" name="clubId" value="${clubId}">
                                                <button type="submit" name="action" value="approve" class="btn-action btn-approve">
                                                    Approve
                                                </button>
                                                <button type="submit" name="action" value="reject" class="btn-action btn-reject">
                                                    Reject
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Approved Members -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">👥 Active Members</h2>
            </div>
            <div class="section-body">
                <c:choose>
                    <c:when test="${empty approvedMembers}">
                        <div class="empty-state">
                            <p>No active members yet</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th style="width: 60px">#</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Member Since</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="m" items="${approvedMembers}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${m.userName}</td>
                                            <td>${m.email}</td>
                                            <td><fmt:setLocale value="en_US"/><fmt:formatDate value="${m.joinedAt}" pattern="MMM d, yyyy"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            </div>
        </main>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Mobile Sidebar Toggle -->
    <button class="sidebar-toggle" id="sidebarToggle">
        ☰
    </button>

    <script>
        // Mobile Sidebar Toggle
        const sidebar = document.querySelector('.sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');

        sidebarToggle.addEventListener('click', () => {
            sidebar.classList.toggle('active');
        });

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 768 && 
                !sidebar.contains(e.target) && 
                !sidebarToggle.contains(e.target) && 
                sidebar.classList.contains('active')) {
                sidebar.classList.remove('active');
            }
        });
    </script>
</body>
</html>
