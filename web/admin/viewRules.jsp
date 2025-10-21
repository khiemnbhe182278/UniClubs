<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Danh sách Rules</title>
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
    <h2>Danh sách Rules</h2>
    <table>
        <tr>
            <th>Rule ID</th>
            <th>Club ID</th>
            <th>Rule Text</th>
            <th>Created At</th>
        </tr>
        <c:forEach var="r" items="${rules}">
            <tr>
                <td>${r.ruleID}</td>
                <td>${r.clubID}</td>
                <td>${r.ruleText}</td>
                <td>${r.createdAt}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
