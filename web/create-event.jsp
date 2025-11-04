<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New Event - UniClubs</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
            .form-container{background:var(--surface);border:1px solid #eef2f6;border-radius:10px;padding:20px}
            h1{font-size:20px;font-weight:700;color:#0f172a;margin-bottom:6px}
            .subtitle{color:var(--muted);margin-bottom:12px}

            .form-group{margin-bottom:14px}
            label{display:block;font-weight:600;color:#0f172a;margin-bottom:6px;font-size:14px}
            input[type="text"],textarea,select{width:100%;padding:10px 12px;border:1px solid #e6edf3;border-radius:8px;font-size:14px}
            textarea{min-height:120px}
            input[type="text"]:focus,textarea:focus,select:focus{outline:none;border-color:var(--primary);box-shadow:0 0 0 4px rgba(37,99,235,0.06)}

            .btn-back{display:inline-flex;align-items:center;gap:8px;color:var(--primary);text-decoration:none;font-weight:600;padding:8px 12px;border-radius:8px}
            .btn-primary{background:var(--primary);color:#fff;border:none;padding:10px 14px;border-radius:8px;width:100%}
            .btn-secondary{background:#f7fafc;color:#0f172a;border:1px solid #eef2f6;padding:10px 14px;border-radius:8px}

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
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/events') or fn:contains(pageContext.request.requestURI, '/create-event')}">class="active"</c:if>>
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
            <div class="row justify-content-center">
                <div class="col-lg-8">


                    <div class="form-container">
                        <div class="form-header">
                            <h1>Create New Event</h1>
                            <p>Organize an exciting event for your club members</p>
                        </div>

                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>Success!</strong> ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error!</strong> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty myClubs}">
                                <form action="${pageContext.request.contextPath}/create-event" method="post">
                                    <div class="mb-4">
                                        <label for="clubId" class="form-label">
                                            Select Club <span class="required-indicator">*</span>
                                        </label>
                                        <select id="clubId" name="clubId" class="form-select" required>
                                            <option value="">Choose a club...</option>
                                            <c:forEach var="club" items="${myClubs}">
                                                <option value="${club.clubID}">${club.clubName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-4">
                                        <label for="eventName" class="form-label">
                                            Event Name <span class="required-indicator">*</span>
                                        </label>
                                        <input type="text" 
                                               id="eventName" 
                                               name="eventName" 
                                               class="form-control"
                                               placeholder="e.g., Annual Hackathon 2025" 
                                               required 
                                               maxlength="100">
                                    </div>

                                    <div class="mb-4">
                                        <label for="description" class="form-label">
                                            Event Description <span class="required-indicator">*</span>
                                        </label>
                                        <textarea id="description" 
                                                  name="description" 
                                                  class="form-control"
                                                  placeholder="Describe what participants can expect from this event..." 
                                                  required 
                                                  maxlength="500"></textarea>
                                        <div class="form-text">Maximum 500 characters</div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <label for="eventDate" class="form-label">
                                                Event Date <span class="required-indicator">*</span>
                                            </label>
                                            <input type="date" 
                                                   id="eventDate" 
                                                   name="eventDate" 
                                                   class="form-control"
                                                   required>
                                        </div>

                                        <div class="col-md-6 mb-4">
                                            <label for="eventTime" class="form-label">
                                                Event Time <span class="required-indicator">*</span>
                                            </label>
                                            <input type="time" 
                                                   id="eventTime" 
                                                   name="eventTime" 
                                                   class="form-control"
                                                   required>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-calendar-plus"></i> Create Event
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <p>You need to be a club leader to create events.</p>
                                    <a href="${pageContext.request.contextPath}/create-club">
                                        Create Your Own Club <span>→</span>
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

    </div>
    </div>
    <%@ include file="footer.jsp" %>

        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>