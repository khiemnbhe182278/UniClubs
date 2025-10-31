<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Reports - Admin</title>
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
            .report-card {
                background: white;
                padding: 1.5rem;
                border-radius: 10px;
                margin-bottom: 1rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .report-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 1rem;
            }
            .report-type {
                padding: 0.3rem 0.8rem;
                background: #e74c3c;
                color: white;
                border-radius: 20px;
                font-size: 0.85rem;
            }
            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-right: 0.5rem;
            }
            .btn-review {
                background: #3498db;
                color: white;
            }
            .btn-resolve {
                background: #2ecc71;
                color: white;
            }
            .btn-dismiss {
                background: #95a5a6;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header"><h2>🎓 Admin Panel</h2></div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/reports">⚠️ Reports</a></li>
            </ul>
        </div>
        <div class="main-content">
            <h1>Club Reports</h1>
            <c:forEach var="report" items="${reports}">
                <div class="report-card">
                    <div class="report-header">
                        <div>
                            <h3>${report.subject}</h3>
                            <p style="color: #666;">Reported by: ${report.userName} | Club: ${report.clubName}</p>
                        </div>
                        <span class="report-type">${report.reportType}</span>
                    </div>
                    <p>${report.description}</p>
                    <div style="margin-top: 1rem;">
                        <span style="color: #999;">Status: ${report.status}</span>
                        <span style="color: #999; margin-left: 1rem;">Date: <fmt:formatDate value="${report.createdAt}" pattern="MMM dd, yyyy"/></span>
                    </div>
                    <div style="margin-top: 1rem;">
                        <form method="post" style="display: inline;">
                            <input type="hidden" name="reportId" value="${report.reportID}">
                            <button type="submit" name="status" value="Under Review" class="btn btn-review">Under Review</button>
                            <button type="submit" name="status" value="Resolved" class="btn btn-resolve">Resolve</button>
                            <button type="submit" name="status" value="Dismissed" class="btn btn-dismiss">Dismiss</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
