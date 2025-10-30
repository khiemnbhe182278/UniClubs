<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Members</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f5f7fa; padding:2rem }
        .container { max-width:1000px; margin:0 auto; background:white; padding:1.5rem; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.06)}
        table { width:100%; border-collapse:collapse }
        th, td { padding:0.8rem; border-bottom:1px solid #eee; text-align:left }
        th { background:#fafafa }
        .no-data { text-align:center; color:#888; padding:2rem }
        .btn { display:inline-block; padding:0.45rem 0.8rem; background:#2193b0; color:white; border-radius:4px; text-decoration:none }
    </style>
</head>
<body>
<div class="container">
    <h1>Members</h1>
    <p>Club ID: <strong>${clubId}</strong></p>
    <p><a class="btn" href="${pageContext.request.contextPath}/leader/dashboard?clubId=${clubId}&amp;clubID=${clubId}">Back to Leader Dashboard</a></p>

    <c:choose>
        <c:when test="${not empty members}">
            <table>
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Joined At</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="member" items="${members}">
                        <tr>
                            <td><strong>${member.userName}</strong></td>
                            <td>${member.email}</td>
                            <td>${member.joinStatus}</td>
                            <td><fmt:formatDate value="${member.joinedAt}" pattern="MMM dd, yyyy"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">
                <p>No members found for this club.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
