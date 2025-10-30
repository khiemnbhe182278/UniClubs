<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Submit Feedback</title>
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
                max-width: 800px;
                margin: 0 auto;
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #2193b0;
                margin-bottom: 2rem;
            }
            .form-group {
                margin-bottom: 1.5rem;
            }
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
            }
            .form-group input, .form-group select, .form-group textarea {
                width: 100%;
                padding: 1rem;
                border: 2px solid #ddd;
                border-radius: 10px;
                font-size: 1rem;
                font-family: inherit;
            }
            .form-group textarea {
                min-height: 150px;
            }
            .rating-group {
                display: flex;
                gap: 0.5rem;
                font-size: 2rem;
            }
            .rating-group input {
                display: none;
            }
            .rating-group label {
                cursor: pointer;
                color: #ddd;
            }
            .rating-group input:checked ~ label {
                color: #f39c12;
            }
            .btn-submit {
                width: 100%;
                padding: 1rem;
                background: #2193b0;
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 1.1rem;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Submit Feedback</h1>
            <form action="${pageContext.request.contextPath}/submit-feedback" method="post">
                <input type="hidden" name="clubId" value="${param.clubId}">
                <div class="form-group">
                    <label for="feedbackType">Feedback Type *</label>
                    <select id="feedbackType" name="feedbackType" required>
                        <option value="Club">Club Feedback</option>
                        <option value="Event">Event Feedback</option>
                        <option value="General">General Feedback</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="subject">Subject *</label>
                    <input type="text" id="subject" name="subject" required>
                </div>
                <div class="form-group">
                    <label for="content">Your Feedback *</label>
                    <textarea id="content" name="content" required></textarea>
                </div>
                <div class="form-group">
                    <label>Rating *</label>
                    <div class="rating-group">
                        <input type="radio" id="star5" name="rating" value="5" required>
                        <label for="star5">⭐</label>
                        <input type="radio" id="star4" name="rating" value="4">
                        <label for="star4">⭐</label>
                        <input type="radio" id="star3" name="rating" value="3">
                        <label for="star3">⭐</label>
                        <input type="radio" id="star2" name="rating" value="2">
                        <label for="star2">⭐</label>
                        <input type="radio" id="star1" name="rating" value="1">
                        <label for="star1">⭐</label>
                    </div>
                </div>
                <button type="submit" class="btn-submit">Submit Feedback</button>
            </form>
        </div>
    </body>
</html>
