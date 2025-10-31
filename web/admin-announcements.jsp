<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Announcements - Admin</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                display: flex;
            }
            .sidebar {
                width: 250px;
                background: #2c3e50;
                min-height: 100vh;
                color: white;
                position: fixed;
            }
            .sidebar-header {
                padding: 2rem;
                background: #34495e;
                text-align: center;
            }
            .sidebar-menu {
                list-style: none;
                padding: 1rem 0;
            }
            .sidebar-menu a {
                display: block;
                padding: 1rem 2rem;
                color: white;
                text-decoration: none;
            }
            .main-content {
                margin-left: 250px;
                flex: 1;
                padding: 2rem;
            }
            .page-header {
                background: white;
                padding: 1.5rem 2rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .btn-create {
                background: #3498db;
                color: white;
                padding: 0.8rem 1.5rem;
                border-radius: 10px;
                text-decoration: none;
                display: inline-block;
                margin-bottom: 1rem;
            }
            .announcement-list {
                background: white;
                border-radius: 10px;
                padding: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .announcement-item {
                padding: 1.5rem;
                border: 1px solid #eee;
                border-radius: 10px;
                margin-bottom: 1rem;
            }
            .announcement-item h3 {
                color: #2c3e50;
                margin-bottom: 0.5rem;
            }
            .badge {
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 500;
            }
            .badge-high {
                background: #e74c3c;
                color: white;
            }
            .badge-medium {
                background: #f39c12;
                color: white;
            }
            .badge-low {
                background: #95a5a6;
                color: white;
            }
            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-right: 0.5rem;
            }
            .btn-toggle {
                background: #3498db;
                color: white;
            }
            .btn-delete {
                background: #e74c3c;
                color: white;
            }
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 1000;
            }
            .modal-content {
                background: white;
                width: 600px;
                margin: 50px auto;
                padding: 2rem;
                border-radius: 15px;
            }
            .form-group {
                margin-bottom: 1.5rem;
            }
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
            }
            .form-group input, .form-group select, .form-group textarea {
                width: 100%;
                padding: 0.8rem;
                border: 2px solid #ddd;
                border-radius: 10px;
            }
            .form-group textarea {
                min-height: 150px;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header"><h2>🎓 Admin Panel</h2></div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/announcements">📢 Announcements</a></li>
            </ul>
        </div>
        <div class="main-content">
            <div class="page-header">
                <h1>Manage Announcements</h1>
                <button onclick="openModal()" class="btn-create">+ Create Announcement</button>
            </div>
            <div class="announcement-list">
                <c:forEach var="announcement" items="${announcements}">
                    <div class="announcement-item">
                        <div style="display: flex; justify-content: space-between; align-items: start;">
                            <div style="flex: 1;">
                                <h3>${announcement.title}</h3>
                                <p style="color: #666; margin: 0.5rem 0;">${announcement.content}</p>
                                <div style="margin-top: 1rem;">
                                    <span class="badge badge-${announcement.priority.toLowerCase()}">${announcement.priority}</span>
                                    <span class="badge" style="background: #e3f2fd; color: #1976d2;">${announcement.targetAudience}</span>
                                    <c:if test="${announcement.active}">
                                        <span class="badge" style="background: #d4edda; color: #155724;">Active</span>
                                    </c:if>
                                </div>
                            </div>
                            <div>
                                <form method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="toggle">
                                    <input type="hidden" name="announcementId" value="${announcement.announcementID}">
                                    <button type="submit" class="btn btn-toggle">Toggle</button>
                                </form>
                                <form method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="announcementId" value="${announcement.announcementID}">
                                    <button type="submit" class="btn btn-delete">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div id="createModal" class="modal">
            <div class="modal-content">
                <h2>Create Announcement</h2>
                <form action="${pageContext.request.contextPath}/admin/announcements" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="form-group">
                        <label for="title">Title *</label>
                        <input type="text" id="title" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="content">Content *</label>
                        <textarea id="content" name="content" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="priority">Priority</label>
                        <select id="priority" name="priority">
                            <option value="Low">Low</option>
                            <option value="Medium" selected>Medium</option>
                            <option value="High">High</option>
                            <option value="Urgent">Urgent</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="targetAudience">Target Audience</label>
                        <select id="targetAudience" name="targetAudience">
                            <option value="All" selected>All Users</option>
                            <option value="Students">Students Only</option>
                            <option value="Leaders">Club Leaders Only</option>
                            <option value="Specific Club">Specific Club</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="expiresAt">Expires At (Optional)</label>
                        <input type="date" id="expiresAt" name="expiresAt">
                    </div>
                    <div style="display: flex; gap: 1rem;">
                        <button type="submit" class="btn btn-toggle" style="flex: 1;">Create</button>
                        <button type="button" onclick="closeModal()" class="btn btn-delete" style="flex: 1;">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function openModal() {
                document.getElementById('createModal').style.display = 'block';
            }
            function closeModal() {
                document.getElementById('createModal').style.display = 'none';
            }
        </script>
    </body>
</html>