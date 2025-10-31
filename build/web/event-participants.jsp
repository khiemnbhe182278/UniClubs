<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Event Participants</title>
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
            .stats {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 1rem;
                margin-top: 1rem;
            }
            .stat-box {
                background: #f8f9fa;
                padding: 1rem;
                border-radius: 10px;
                text-align: center;
            }
            .stat-box .number {
                font-size: 2rem;
                color: #2193b0;
                font-weight: bold;
            }
            table {
                width: 100%;
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            th, td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            th {
                background: #f8f9fa;
                font-weight: 600;
            }
            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-attended {
                background: #2ecc71;
                color: white;
            }
            .btn-absent {
                background: #e74c3c;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>${event.eventName} - Participants</h1>
                <div class="stats">
                    <div class="stat-box">
                        <div class="number">${totalParticipants}</div>
                        <div>Total Registered</div>
                    </div>
                    <div class="stat-box">
                        <div class="number">${attended}</div>
                        <div>Attended</div>
                    </div>
                    <div class="stat-box">
                        <div class="number">${registered}</div>
                        <div>Pending</div>
                    </div>
                </div>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Registration Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="participant" items="${participants}">
                        <tr>
                            <td>${participant.userName}</td>
                            <td>${participant.email}</td>
                            <td><fmt:formatDate value="${participant.registrationDate}" pattern="MMM dd, yyyy"/></td>
                    <td>${participant.attendanceStatus}</td>
                    <td>
                        <form method="post" action="${pageContext.request.contextPath}/leader/mark-attendance" style="display: inline;">
                            <input type="hidden" name="participantId" value="${participant.participantID}">
                            <input type="hidden" name="eventId" value="${event.eventID}">
                            <!-- include club context for consistency -->
                            <input type="hidden" name="clubId" value="${event.clubID}">
                            <input type="hidden" name="clubID" value="${event.clubID}">
                            <button type="submit" name="status" value="Attended" class="btn btn-attended">Mark Attended</button>
                            <button type="submit" name="status" value="Absent" class="btn btn-absent">Mark Absent</button>
                        </form>
                    </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
