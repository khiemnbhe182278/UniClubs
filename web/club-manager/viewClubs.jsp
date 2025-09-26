<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Club Management</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 30px;
                background: #f9fafb;
            }
            .container {
                max-width: 1100px;
                margin: auto;
                background: white;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            }
            h2 {
                text-align: center;
                margin-bottom: 20px;
            }
            .search-form {
                margin-bottom: 20px;
                text-align: right;
            }
            .search-form input {
                padding: 8px;
                border-radius: 6px;
                border: 1px solid #ddd;
            }
            .search-form button {
                padding: 8px 14px;
                border: none;
                background: #3b82f6;
                color: white;
                border-radius: 6px;
                cursor: pointer;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            th, td {
                padding: 12px;
                border-bottom: 1px solid #e5e7eb;
                text-align: left;
            }
            th {
                background: #f1f5f9;
            }
            tr:hover {
                background: #f9fafb;
            }
            .no-data {
                text-align: center;
                color: #777;
                padding: 30px 0;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Club Management</h2>

            <form method="get" action="viewClubs" class="search-form">
                <input type="text" name="search" value="${search}" placeholder="Search club name or description">
                <button type="submit">Search</button>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>Club Name</th>
                        <th>Description</th>
                        <th>Faculty</th>
                        <th>Leader</th>
                        <th>Status</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty clubs}">
                            <c:forEach var="c" items="${clubs}">
                                <tr>
                                    <td>${c.clubName}</td>
                                    <td>${c.description}</td>
                                    <td>${c.facultyName != null ? c.facultyName : '-'}</td>
                                    <td>${c.leaderName != null ? c.leaderName : '-'}</td>
                                    <td>${c.status ? "Active" : "Inactive"}</td>
                                    <td>${c.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="no-data">No clubs found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </body>
</html>
