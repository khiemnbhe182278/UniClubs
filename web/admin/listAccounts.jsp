<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account Management Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #3b82f6;
                --secondary-color: #10b981;
                --danger-color: #ef4444;
                --warning-color: #f59e0b;
                --text-color: #333;
                --bg-light: #f9fafb;
                --bg-white: #fff;
                --border-color: #e5e7eb;
            }

            body {
                font-family: 'Roboto', sans-serif;
                background-color: var(--bg-light);
                margin: 0;
                padding: 40px;
            }

            .container {
                max-width: 1400px;
                margin: auto;
                background: var(--bg-white);
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            }

            h2 {
                text-align: center;
                color: var(--text-color);
                font-weight: 700;
                margin-bottom: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 15px;
            }

            .header-actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 25px;
            }

            .create-btn {
                background-color: var(--secondary-color);
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: background-color 0.2s ease;
            }

            .create-btn:hover {
                background-color: #059669;
            }

            .search-form {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .search-form input[type=text], .search-form select {
                padding: 10px;
                border-radius: 8px;
                border: 1px solid var(--border-color);
                width: 250px;
                transition: box-shadow 0.2s ease, border-color 0.2s ease;
            }

            .search-form input[type=text]:focus, .search-form select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
            }

            .search-form button {
                padding: 10px 15px;
                border: none;
                border-radius: 8px;
                background-color: var(--primary-color);
                color: white;
                cursor: pointer;
                transition: background-color 0.2s ease;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .search-form button:hover {
                background-color: #2563eb;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-top: 20px;
            }

            th, td {
                text-align: left;
                padding: 16px;
                border-bottom: 1px solid var(--border-color);
            }

            th {
                background-color: var(--bg-light);
                color: var(--text-color);
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            tr:hover {
                background-color: #f1f5f9;
            }

            tbody tr:first-child td {
                border-top: 1px solid var(--border-color);
            }

            .actions-cell {
                white-space: nowrap;
            }

            .actions-cell a {
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 6px;
                margin-right: 8px;
                color: white;
                font-weight: 500;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .actions-cell a:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            .change-role {
                background-color: var(--primary-color);
            }
            .ban {
                background-color: var(--danger-color);
            }
            .edit {
                background-color: var(--warning-color);
            }

            .pagination {
                margin-top: 25px;
                text-align: center;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .pagination a {
                text-decoration: none;
                color: var(--primary-color);
                padding: 10px 15px;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                transition: background-color 0.2s ease;
            }

            .pagination a.current {
                background-color: var(--primary-color);
                color: white;
                border: 1px solid var(--primary-color);
                font-weight: 700;
            }

            .pagination a:hover:not(.current) {
                background-color: var(--bg-white);
            }

            .no-data {
                text-align: center;
                color: #6b7280;
                padding: 50px 0;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 20px;
                }
                .header-actions {
                    flex-direction: column;
                    align-items: stretch;
                }
                .search-form {
                    width: 100%;
                }
                .search-form input[type=text], .search-form select, .search-form button {
                    width: 100%;
                    box-sizing: border-box;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2><i class="fas fa-users-cog"></i> Account Management Dashboard</h2>

            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/createUser" class="create-btn">
                    <i class="fas fa-plus"></i> Create Account
                </a>

                <form method="get" action="listAccounts" class="search-form">
                    <input type="text" name="search" placeholder="Search name or email" value="${search}">
                    <select name="role">
                        <option value="">All Roles</option>
                        <option value="Student" ${roleFilter=='Student'?'selected':''}>Student</option>
                        <option value="ClubLeader" ${roleFilter=='ClubLeader'?'selected':''}>Club Leader</option>
                        <option value="Faculty" ${roleFilter=='Faculty'?'selected':''}>Faculty</option>
                        <option value="CLB Manager" ${roleFilter=='CLB Manager'?'selected':''}>CLB Manager</option>
                    </select>
                    <button type="submit">
                        <i class="fas fa-search"></i> Search
                    </button>
                </form>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>User Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Managed Club</th>
                            <th>Joined Clubs</th>
                            <th class="actions-cell">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty users}">
                                <c:forEach var="u" items="${users}">
                                    <tr>
                                        <td>${u.userName}</td>
                                        <td>${u.email}</td>
                                        <td>${u.role}</td>
                                        <td>${u.managedClub != null ? u.managedClub : '-'}</td>
                                        <td>${u.joinedClubs != null ? u.joinedClubs : '-'}</td>
                                        <td class="actions-cell">
                                            <select name="roleID" onchange="confirmChangeRole(this)">
                                                <option value="2" ${u.role == 'CLB Manager' ? 'selected' : ''}>CLB Manager</option>
                                                <option value="3" ${u.role == 'Faculty' ? 'selected' : ''}>Faculty</option>
                                                <option value="4" ${u.role == 'ClubLeader' ? 'selected' : ''}>Club Leader</option>
                                                <option value="5" ${u.role == 'Student' ? 'selected' : ''}>Student</option>
                                            </select>


                                            <c:choose>
                                                <c:when test="${u.status}">
                                                    <a href="javascript:void(0);" 
                                                       onclick="confirmBan('${pageContext.request.contextPath}/banUser?userID=${u.userID}&status=true')" 
                                                       class="ban" title="Ban User">
                                                        <i class="fas fa-ban"></i>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="javascript:void(0);" 
                                                       onclick="confirmBan('${pageContext.request.contextPath}/banUser?userID=${u.userID}&status=false')" 
                                                       class="edit" title="Unban User">
                                                        <i class="fas fa-unlock"></i>
                                                    </a>
                                                </c:otherwise>

                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="no-data">No accounts found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="?page=${i}&search=${search}&role=${roleFilter}" class="${i==currentPage?'current':''}">${i}</a>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </body>
    <script>
        function confirmChangeRole(selectElement) {
            const form = selectElement.form;
            const selectedRole = selectElement.options[selectElement.selectedIndex].text;
            if (confirm("Do you want to change role to " + selectedRole + " ?")) {
                form.submit();
            } else {
                form.reset();
            }
        }
        function confirmBan(url) {
            if (confirm("Do you want to ban this user ?")) {
                window.location.href = url;
            }
        }
    </script>

</html>