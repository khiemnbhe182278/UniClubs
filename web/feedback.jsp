<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback - UniClubs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style> .container{max-width:900px;margin:40px auto;padding:20px} .nav {margin-bottom:20px} form{max-width:600px} </style>
</head>
<body>
<div class="container">
    <div class="nav">
        <a href="${pageContext.request.contextPath}/home">Home</a> •
        <a href="${pageContext.request.contextPath}/about">About</a>
    </div>

    <h1>Submit Feedback</h1>
    <form action="${pageContext.request.contextPath}/submit-feedback" method="post">
        <label>Subject</label><br>
        <input type="text" name="subject" required><br>
        <label>Message</label><br>
        <textarea name="message" rows="6" required></textarea><br>
        <button type="submit">Send Feedback</button>
    </form>

    <p><a href="${pageContext.request.contextPath}/home">← Back to Home</a></p>
</div>
</body>
</html>
