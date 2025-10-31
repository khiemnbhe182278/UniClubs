<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Users - Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
            }

            /* Sidebar Styles */
            .sidebar {
                width: 280px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 30px 20px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .sidebar-header h2 {
                font-size: 24px;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .sidebar-menu {
                list-style: none;
                padding: 20px 0;
            }

            .sidebar-menu li {
                margin: 5px 15px;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 14px 18px;
                color: #4a5568;
                text-decoration: none;
                border-radius: 12px;
                transition: all 0.3s ease;
                font-weight: 500;
                font-size: 15px;
            }

            .sidebar-menu a:hover {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                transform: translateX(5px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
            }

            /* Main Content */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 40px;
                min-height: 100vh;
            }

            .page-header {
                background: white;
                padding: 30px;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                position: relative;
                overflow: hidden;
            }

            .page-header::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            }

            .page-header h1 {
                color: #2d3748;
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 8px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .page-header p {
                color: #718096;
                font-size: 16px;
            }

            /* Stats Cards */
            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 24px;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                display: flex;
                align-items: center;
                gap: 16px;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .stat-card::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            }

            .stat-icon {
                width: 56px;
                height: 56px;
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 28px;
                flex-shrink: 0;
            }

            .stat-icon.total {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            .stat-icon.active {
                background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            }

            .stat-icon.inactive {
                background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            }

            .stat-icon.admin {
                background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%);
            }

            .stat-content h3 {
                font-size: 28px;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 4px;
            }

            .stat-content p {
                font-size: 13px;
                color: #718096;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Search and Filter */
            .controls-container {
                background: white;
                padding: 20px;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                margin-bottom: 20px;
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
                align-items: center;
            }

            .search-box {
                flex: 1;
                min-width: 250px;
                position: relative;
            }

            .search-box input {
                width: 100%;
                padding: 12px 16px 12px 42px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-size: 14px;
                font-family: 'Inter', sans-serif;
                transition: all 0.3s ease;
            }

            .search-box input:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .search-box::before {
                content: "🔍";
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 16px;
            }

            .filter-select {
                padding: 12px 16px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-size: 14px;
                font-family: 'Inter', sans-serif;
                font-weight: 500;
                color: #4a5568;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .filter-select:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            /* Table Container */
            .table-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .table-header {
                padding: 25px 30px;
                background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
                border-bottom: 2px solid #e2e8f0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .table-header h2 {
                font-size: 20px;
                font-weight: 700;
                color: #2d3748;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            thead th {
                padding: 18px 20px;
                text-align: left;
                color: white;
                font-weight: 600;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            tbody tr {
                border-bottom: 1px solid #e2e8f0;
                transition: all 0.3s ease;
            }

            tbody tr:hover {
                background: linear-gradient(90deg, rgba(102, 126, 234, 0.03) 0%, rgba(118, 75, 162, 0.03) 100%);
            }

            tbody tr:last-child {
                border-bottom: none;
            }

            tbody td {
                padding: 20px;
                color: #4a5568;
                font-size: 14px;
                vertical-align: middle;
            }

            /* User Info */
            .user-info {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .user-avatar {
                width: 44px;
                height: 44px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 700;
                font-size: 16px;
                flex-shrink: 0;
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            }

            .user-details strong {
                display: block;
                color: #2d3748;
                font-weight: 600;
                font-size: 15px;
                margin-bottom: 2px;
            }

            .user-id {
                font-size: 12px;
                color: #a0aec0;
            }

            /* Email Badge */
            .email-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 14px;
                background: #f7fafc;
                border: 1px solid #e2e8f0;
                border-radius: 10px;
                font-size: 13px;
                color: #4a5568;
                font-weight: 500;
            }

            /* Role Badge */
            .role-badge {
                display: inline-block;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .role-admin {
                background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%);
                color: white;
                box-shadow: 0 2px 8px rgba(237, 137, 54, 0.3);
            }

            .role-student {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
            }

            .role-club-leader {
                background: linear-gradient(135deg, #9f7aea 0%, #805ad5 100%);
                color: white;
                box-shadow: 0 2px 8px rgba(159, 122, 234, 0.3);
            }

            /* Status Badge */
            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 14px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
            }

            .status-active {
                background: #d4f4dd;
                color: #22543d;
            }

            .status-active::before {
                content: "●";
                color: #38a169;
                font-size: 14px;
            }

            .status-inactive {
                background: #fed7d7;
                color: #742a2a;
            }

            .status-inactive::before {
                content: "●";
                color: #e53e3e;
                font-size: 14px;
            }

            /* Date Badge */
            .date-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 14px;
                background: #f7fafc;
                border: 1px solid #e2e8f0;
                border-radius: 10px;
                font-weight: 500;
                color: #2d3748;
                font-size: 13px;
            }

            /* Buttons */
            .btn {
                padding: 10px 18px;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .btn-activate {
                background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
                color: white;
            }

            .btn-activate:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(72, 187, 120, 0.4);
            }

            .btn-deactivate {
                background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
                color: white;
            }

            .btn-deactivate:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(245, 101, 101, 0.4);
            }

            .btn:active {
                transform: translateY(0);
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

            .table-container, .stats-container, .controls-container {
                animation: fadeIn 0.6s ease;
            }

            /* Responsive Design */
            @media (max-width: 1024px) {
                .sidebar {
                    width: 240px;
                }

                .main-content {
                    margin-left: 240px;
                    padding: 20px;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                }

                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }

                .page-header {
                    padding: 20px;
                }

                .page-header h1 {
                    font-size: 24px;
                }

                .stats-container {
                    grid-template-columns: 1fr;
                }

                .controls-container {
                    flex-direction: column;
                }

                .search-box {
                    width: 100%;
                }

                table {
                    font-size: 12px;
                }

                .user-info {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 8px;
                }

                .user-avatar {
                    width: 36px;
                    height: 36px;
                    font-size: 14px;
                }

                thead th, tbody td {
                    padding: 12px 8px;
                }

                .btn {
                    padding: 8px 12px;
                    font-size: 11px;
                }
            }

            /* Scrollbar Styling */
            ::-webkit-scrollbar {
                width: 8px;
                height: 8px;
            }

            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            ::-webkit-scrollbar-thumb {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 10px;
            }

            ::-webkit-scrollbar-thumb:hover {
                background: #764ba2;
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
                <li><a href="${pageContext.request.contextPath}/admin/clubs">🏛️ Manage Clubs</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/members">👥 Manage Members</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/events">📅 Manage Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">👤 Manage Users</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1>Manage Users</h1>
                <p>View and manage all system users and their permissions</p>
            </div>

            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-icon total">👥</div>
                    <div class="stat-content">
                        <h3>${users.size()}</h3>
                        <p>Total Users</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon active">✓</div>
                    <div class="stat-content">
                        <h3>
                            <c:set var="activeCount" value="0"/>
                            <c:forEach var="user" items="${users}">
                                <c:if test="${user.status}">
                                    <c:set var="activeCount" value="${activeCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${activeCount}
                        </h3>
                        <p>Active Users</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon inactive">⊗</div>
                    <div class="stat-content">
                        <h3>${users.size() - activeCount}</h3>
                        <p>Inactive Users</p>
                    </div>
                </div>
            </div>

            <!-- Search and Filter Controls -->
            <div class="controls-container">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search by name or email..." onkeyup="filterTable()">
                </div>
                <select class="filter-select" id="roleFilter" onchange="filterTable()">
                    <option value="">All Roles</option>
                    <option value="Admin">Admin</option>
                    <option value="Student">Student</option>
                    <option value="Club Leader">Club Leader</option>
                </select>
                <select class="filter-select" id="statusFilter" onchange="filterTable()">
                    <option value="">All Status</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                </select>
                <a href="${pageContext.request.contextPath}/admin/create-account" class="btn btn-create">
                    ➕ Create Account
                </a>
            </div>

            <!-- Users Table -->
            <div class="table-container">
                <div class="table-header">
                    <h2>📋 Users List</h2>
                </div>
                <table id="usersTable">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Created Date</th>
                            <th style="text-align: center;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>
                                    <div class="user-info">
                                        <div class="user-avatar">
                                            ${user.userName.substring(0, 1).toUpperCase()}
                                        </div>
                                        <div class="user-details">
                                            <strong>${user.userName}</strong>
                                            <span class="user-id">ID: ${user.userID}</span>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="email-badge">
                                        📧 ${user.email}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.roleName == 'Admin'}">
                                            <span class="role-badge role-admin">👑 ${user.roleName}</span>
                                        </c:when>
                                        <c:when test="${user.roleName == 'Club Leader'}">
                                            <span class="role-badge role-club-leader">⭐ ${user.roleName}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="role-badge role-student">🎓 ${user.roleName}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status}">
                                            <span class="status-badge status-active">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="date-badge">
                                        📅 <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy"/>
                                    </span>
                                </td>
                                <td style="text-align: center;">
                                    <form method="post" style="display: inline;">
                                        <input type="hidden" name="userId" value="${user.userID}">
                                        <c:choose>
                                            <c:when test="${user.status}">
                                                <button type="submit" class="btn btn-deactivate">
                                                    ⊗ Deactivate
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="submit" class="btn btn-activate">
                                                    ✓ Activate
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            function filterTable() {
                const searchInput = document.getElementById('searchInput').value.toLowerCase();
                const roleFilter = document.getElementById('roleFilter').value.toLowerCase();
                const statusFilter = document.getElementById('statusFilter').value.toLowerCase();
                const table = document.getElementById('usersTable');
                const rows = table.getElementsByTagName('tr');

                for (let i = 1; i < rows.length; i++) {
                    const row = rows[i];
                    const userName = row.cells[0].textContent.toLowerCase();
                    const email = row.cells[1].textContent.toLowerCase();
                    const role = row.cells[2].textContent.toLowerCase();
                    const status = row.cells[3].textContent.toLowerCase();

                    const matchesSearch = userName.includes(searchInput) || email.includes(searchInput);
                    const matchesRole = roleFilter === '' || role.includes(roleFilter);
                    const matchesStatus = statusFilter === '' || status.includes(statusFilter);

                    if (matchesSearch && matchesRole && matchesStatus) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                }
            }
        </script>
    </body>
</html>