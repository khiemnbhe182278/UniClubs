<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resources - UniClubs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style> .container{max-width:900px;margin:40px auto;padding:20px} .nav {margin-bottom:20px} </style>
</head>
<body>
<div class="container">
    <div class="nav">
        <a href="${pageContext.request.contextPath}/home">Home</a> •
        <a href="${pageContext.request.contextPath}/clubs">Clubs</a> •
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
    </div>

    <h1>Resources</h1>
    <p>Links and documents useful for club organizers.</p>
    <ul>
        <li><a href="#">Event Planning Checklist</a></li>
        <li><a href="#">Budget Template</a></li>
    </ul>

    <p><a href="${pageContext.request.contextPath}/home">← Back to Home</a></p>
</div>
</body>
</html>
