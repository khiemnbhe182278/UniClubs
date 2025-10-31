<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Clubs - Admin</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
            }

            .sidebar {
                width: 280px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                min-height: 100vh;
                position: fixed;
                box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
                z-index: 1000;
            }

            .sidebar-header {
                padding: 2rem 1.5rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                text-align: center;
                color: white;
            }

            .sidebar-header h2 {
                font-size: 1.5rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .sidebar-menu {
                list-style: none;
                padding: 1.5rem 1rem;
            }

            .sidebar-menu li {
                margin-bottom: 0.5rem;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem 1.5rem;
                color: #4a5568;
                text-decoration: none;
                border-radius: 12px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .sidebar-menu a:hover {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                transform: translateX(5px);
            }

            .sidebar-menu a.active {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .main-content {
                margin-left: 280px;
                flex: 1;
                padding: 2rem;
            }

            .page-header {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                padding: 2rem 2.5rem;
                border-radius: 20px;
                margin-bottom: 2rem;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            }

            .page-header h1 {
                color: #2d3748;
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .page-header p {
                color: #718096;
                font-size: 1rem;
            }

            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                padding: 1.5rem;
                border-radius: 16px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            .stat-info h3 {
                color: #2d3748;
                font-size: 1.8rem;
                font-weight: 700;
            }

            .stat-info p {
                color: #718096;
                font-size: 0.9rem;
            }

            .table-container {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                padding: 2rem;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .table-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #e2e8f0;
            }

            .table-header h2 {
                color: #2d3748;
                font-size: 1.5rem;
                font-weight: 600;
            }

            .filter-buttons {
                display: flex;
                gap: 0.5rem;
            }

            .filter-btn {
                padding: 0.5rem 1rem;
                border: 2px solid #e2e8f0;
                background: white;
                border-radius: 8px;
                cursor: pointer;
                font-size: 0.9rem;
                font-weight: 500;
                color: #4a5568;
                transition: all 0.3s ease;
            }

            .filter-btn:hover, .filter-btn.active {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-color: transparent;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
            }

            thead {
                background: #f7fafc;
            }

            th {
                padding: 1.2rem 1rem;
                text-align: left;
                color: #4a5568;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            tbody tr {
                transition: all 0.3s ease;
            }

            tbody tr:hover {
                background: #f7fafc;
                transform: scale(1.01);
            }

            td {
                padding: 1.5rem 1rem;
                border-bottom: 1px solid #e2e8f0;
                color: #2d3748;
            }

            td strong {
                color: #1a202c;
                font-weight: 600;
                font-size: 1.05rem;
            }

            .club-description {
                color: #718096;
                max-width: 400px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .date-badge {
                display: inline-block;
                padding: 0.4rem 1rem;
                background: #edf2f7;
                color: #4a5568;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 500;
            }

            .btn {
                padding: 0.6rem 1.5rem;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                margin-right: 0.5rem;
                font-size: 0.9rem;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            .btn-approve {
                background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
                color: white;
            }

            .btn-approve:hover {
                background: linear-gradient(135deg, #38a169 0%, #2f855a 100%);
            }

            .btn-reject {
                background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
                color: white;
            }

            .btn-reject:hover {
                background: linear-gradient(135deg, #e53e3e 0%, #c53030 100%);
            }

            .no-data {
                text-align: center;
                padding: 4rem 2rem;
            }

            .no-data-icon {
                font-size: 4rem;
                margin-bottom: 1rem;
                opacity: 0.5;
            }

            .no-data h3 {
                color: #2d3748;
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
            }

            .no-data p {
                color: #718096;
            }

            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                }

                .main-content {
                    margin-left: 0;
                }

                .stats-container {
                    grid-template-columns: 1fr;
                }

                .table-container {
                    overflow-x: auto;
                }
            }

            /* Animation */
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

            .table-container, .page-header, .stat-card {
                animation: fadeIn 0.6s ease-out;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Admin Panel</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/clubs" class="active">🏛️ Manage Clubs</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/members">👥 Manage Members</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/events">📅 Manage Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">👤 Manage Users</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1>Manage Pending Clubs</h1>
                <p>Review and approve club registration requests</p>
            </div>

            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-icon">⏳</div>
                    <div class="stat-info">
                        <h3>${not empty pendingClubs ? pendingClubs.size() : 0}</h3>
                        <p>Pending Reviews</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">✅</div>
                    <div class="stat-info">
                        <h3>0</h3>
                        <p>Approved Today</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">🏛️</div>
                    <div class="stat-info">
                        <h3>0</h3>
                        <p>Total Clubs</p>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <div class="table-header">
                    <h2>Pending Club Requests</h2>
                    <div class="filter-buttons">
                        <button class="filter-btn active">All</button>
                        <button class="filter-btn">Recent</button>
                        <button class="filter-btn">Oldest</button>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty pendingClubs}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Club Name</th>
                                    <th>Description</th>
                                    <th>Created Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="club" items="${pendingClubs}">
                                    <tr>
                                        <td><strong>${club.clubName}</strong></td>
                                        <td><span class="club-description">${club.description}</span></td>
                                        <td>
                                            <span class="date-badge">
                                                <fmt:formatDate value="${club.createdAt}" pattern="MMM dd, yyyy"/>
                                            </span>
                                        </td>
                                        <td>
                                            <form method="post" style="display: inline;">
                                                <input type="hidden" name="clubId" value="${club.clubID}">
                                                <button type="submit" name="action" value="approve" class="btn btn-approve">
                                                    ✓ Approve
                                                </button>
                                                <button type="submit" name="action" value="reject" class="btn btn-reject">
                                                    ✗ Reject
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <div class="no-data-icon">🎉</div>
                            <h3>No Pending Clubs</h3>
                            <p>All club requests have been reviewed. Great job!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>