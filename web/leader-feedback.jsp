<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>View Feedback</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                padding: 2rem;
            }
            .container {
                max-width: 1000px;
                margin: 0 auto;
            }
            .header {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .header h1 {
                color: #2193b0;
                margin-bottom: 0.5rem;
            }
            .avg-rating {
                font-size: 2rem;
                color: #f39c12;
                margin-top: 1rem;
            }
            .feedback-card {
                background: white;
                padding: 1.5rem;
                border-radius: 15px;
                margin-bottom: 1rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .feedback-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 1rem;
            }
            .rating {
                color: #f39c12;
                font-size: 1.2rem;
            }
            .feedback-content {
                color: #666;
                line-height: 1.6;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>Feedback - ${club.clubName}</h1>
                <div class="avg-rating">Average Rating: <fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/> ⭐</div>
            </div>
            <c:forEach var="feedback" items="${feedbacks}">
                <div class="feedback-card">
                    <div class="feedback-header">
                        <div>
                            <strong>${feedback.userName}</strong>
                            <div class="rating">${'⭐'.repeat(feedback.rating)}</div>
                        </div>
                        <div style="color: #999;"><fmt:formatDate value="${feedback.createdAt}" pattern="MMM dd, yyyy"/></div>
                    </div>
                    <h3>${feedback.subject}</h3>
                    <p class="feedback-content">${feedback.content}</p>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
