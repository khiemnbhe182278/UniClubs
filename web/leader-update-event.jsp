<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Event</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <style>
            :root{--bg:#f7fafc;--surface:#ffffff;--muted:#6b7280;--primary:#2563eb;--sidebar-w:250px}
            *{box-sizing:border-box;margin:0;padding:0}
            body{font-family:Inter, sans-serif;background:var(--bg);min-height:100vh}

            /* Sidebar */
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

            .container{max-width:900px;margin:0 auto}
            .form-card{background:var(--surface);border:1px solid #eef2f6;border-radius:10px;padding:20px}
            h1{font-size:20px;font-weight:700;color:#0f172a;margin-bottom:6px}
            .subtitle{color:var(--muted);margin-bottom:12px}

            .form-group{margin-bottom:14px}
            label{display:block;font-weight:600;color:#0f172a;margin-bottom:6px;font-size:14px}
            input[type="text"],textarea,input[type="date"],input[type="time"],input[type="number"]{width:100%;padding:10px 12px;border:1px solid #e6edf3;border-radius:8px;font-size:14px}
            textarea{min-height:120px}
            input:focus,textarea:focus{outline:none;border-color:var(--primary);box-shadow:0 0 0 4px rgba(37,99,235,0.06)}

            .btn-primary{background:var(--primary);color:#fff;border:none;padding:10px 14px;border-radius:8px;width:100%;display:inline-flex;align-items:center;justify-content:center;gap:8px}

            @media(max-width:768px){.main-content{margin-left:0;padding:16px}}
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2><i class="bi bi-person-badge"></i> Leader Dashboard</h2>
                <p>Manage your clubs</p>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/leader/dashboard"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/dashboard')}">class="active"</c:if>>
                        <i class="bi bi-speedometer2"></i> Overview
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/club/members"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/club/members')}">class="active"</c:if>>
                        <i class="bi bi-people"></i> Members
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/events"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/events')}">class="active"</c:if>>
                        <i class="bi bi-calendar3"></i> Events
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/rules"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/rules')}">class="active"</c:if>>
                        <i class="bi bi-file-text"></i> Rules
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/news"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/news')}">class="active"</c:if>>
                        <i class="bi bi-newspaper"></i> News
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">
        <div class="container py-4">
            <div class="form-card">
                <h1><i class="bi bi-calendar-event"></i> Update Event</h1>
                <form action="${pageContext.request.contextPath}/leader/update-event" method="post">
                    <input type="hidden" name="eventId" value="${event.eventID}">
                    <!-- include club context so update handlers can redirect back correctly -->
                    <input type="hidden" name="clubId" value="${event.clubID}">
                    <input type="hidden" name="clubID" value="${event.clubID}">
                    <div class="form-group">
                        <label for="eventName">Event Name *</label>
                        <input type="text" id="eventName" name="eventName" value="${event.eventName}" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description *</label>
                        <textarea id="description" name="description" required>${event.description}</textarea>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="eventDate">Event Date *</label>
                            <input type="date" id="eventDate" name="eventDate" value="<fmt:formatDate value='${event.eventDate}' pattern='yyyy-MM-dd'/>" required>
                        </div>
                        <div class="form-group">
                            <label for="eventTime">Event Time *</label>
                            <input type="time" id="eventTime" name="eventTime" value="<fmt:formatDate value='${event.eventDate}' pattern='HH:mm'/>" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="location">Location</label>
                            <input type="text" id="location" name="location" value="${event.location}">
                        </div>
                        <div class="form-group">
                            <label for="maxParticipants">Max Participants</label>
                            <input type="number" id="maxParticipants" name="maxParticipants" value="${event.maxParticipants}">
                        </div>
                    </div>
                    <button type="submit" class="btn-primary"><i class="bi bi-check-lg"></i> Update Event</button>
                </form>
            </div>
        </div>
        </div>
    </body>
</html>