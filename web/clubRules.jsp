<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Danh sách Rules của CLB</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px 12px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
    <c:if test="${not empty rules}">
        <h2>Danh sách Rules - CLB: ${rules[0].clubName}</h2>
        <table>
            <tr>
                <th>Rule ID</th>
                <th>Rule Title</th>
                <th>Rule Text</th>
                <th>Created At</th>
            </tr>
            <c:forEach var="r" items="${rules}">
                <tr>
                    <td>${r.ruleID}</td>
                    <td>${r.title}</td>
                    <td>${r.ruleText}</td>
                    <td>${r.createdAt}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

    <c:if test="${empty rules}">
        <h2 style="text-align:center;">CLB chưa có rules nào</h2>
    </c:if>
</body>
</html>
