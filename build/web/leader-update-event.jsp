<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Event</title>
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
            .form-group input, .form-group textarea {
                width: 100%;
                padding: 1rem;
                border: 2px solid #ddd;
                border-radius: 10px;
                font-size: 1rem;
                font-family: inherit;
            }
            .form-group textarea {
                min-height: 120px;
            }
            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
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
            <h1>Update Event</h1>
            <form action="${pageContext.request.contextPath}/leader/update-event" method="post">
                <input type="hidden" name="eventId" value="${event.eventID}">
                <!-- include club context so update handlers can redirect back correctly -->
                <input type="hidden" name="clubId" value="${event.clubID}">
                <input type="hidden" name="clubID" value="${event.clubID}">
                <div class="form-group">
                    <label for="eventName">Event Name *</label>
                    <input type="text" id="eventName" name="eventName" value="${event.eventName}" required>
                </div>
                <div class="form-group">
                    <label for="description">Description *</label>
                    <textarea id="description" name="description" required>${event.description}</textarea>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="eventDate">Event Date *</label>
                        <input type="date" id="eventDate" name="eventDate" value="<fmt:formatDate value='${event.eventDate}' pattern='yyyy-MM-dd'/>" required>
                    </div>
                    <div class="form-group">
                        <label for="eventTime">Event Time *</label>
                        <input type="time" id="eventTime" name="eventTime" value="<fmt:formatDate value='${event.eventDate}' pattern='HH:mm'/>" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="location">Location</label>
                        <input type="text" id="location" name="location" value="${event.location}">
                    </div>
                    <div class="form-group">
                        <label for="maxParticipants">Max Participants</label>
                        <input type="number" id="maxParticipants" name="maxParticipants" value="${event.maxParticipants}">
                    </div>
                </div>
                <button type="submit" class="btn-submit">Update Event</button>
            </form>
        </div>
    </body>
</html>