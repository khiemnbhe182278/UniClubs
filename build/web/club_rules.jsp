<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Rules</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
            background: #ffffff;
            color: #000000;
            line-height: 1.6;
            padding: 40px 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 2px solid #000000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-content h1 {
            font-size: 3em;
            font-weight: 700;
            letter-spacing: -0.02em;
            margin-bottom: 15px;
        }

        .header-content p {
            font-size: 1.1em;
            color: #666666;
            font-weight: 400;
        }

        .divider {
            width: 60px;
            height: 3px;
            background: #000000;
            margin: 20px 0 30px 0;
        }

        .add-button {
            padding: 12px 30px;
            background: #000000;
            color: #ffffff;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9em;
            letter-spacing: 0.02em;
            transition: all 0.3s ease;
            border: 2px solid #000000;
            display: inline-block;
        }

        .add-button:hover {
            background: #ffffff;
            color: #000000;
        }

        .stats {
            display: flex;
            gap: 40px;
            margin-bottom: 40px;
            padding: 20px 0;
        }

        .stat-item {
            display: flex;
            flex-direction: column;
        }

        .stat-value {
            font-size: 2.5em;
            font-weight: 700;
            line-height: 1;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 0.9em;
            color: #666666;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .rules-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
        }

        .rules-table thead {
            border-bottom: 2px solid #000000;
        }

        .rules-table th {
            text-align: left;
            padding: 15px 10px;
            font-size: 0.85em;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #000000;
        }

        .rules-table th:last-child {
            text-align: right;
        }

        .rules-table tbody tr {
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.2s ease;
        }

        .rules-table tbody tr:hover {
            background-color: #f8f8f8;
        }

        .rules-table td {
            padding: 20px 10px;
            vertical-align: middle;
        }

        .rule-number {
            font-size: 0.85em;
            color: #999999;
            font-weight: 500;
        }

        .rule-title {
            font-size: 1.1em;
            font-weight: 600;
            color: #000000;
        }

        .rule-date {
            font-size: 0.9em;
            color: #666666;
        }

        .actions {
            text-align: right;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn {
            padding: 8px 20px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.85em;
            letter-spacing: 0.02em;
            transition: all 0.3s ease;
            border: 1px solid;
            display: inline-block;
            cursor: pointer;
        }

        .btn-update {
            background: #ffffff;
            color: #000000;
            border-color: #000000;
        }

        .btn-update:hover {
            background: #000000;
            color: #ffffff;
        }

        .btn-delete {
            background: #000000;
            color: #ffffff;
            border-color: #000000;
        }

        .btn-delete:hover {
            background: #ffffff;
            color: #000000;
        }

        .no-rules {
            text-align: center;
            padding: 100px 20px;
        }

        .no-rules h2 {
            font-size: 2em;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .no-rules p {
            font-size: 1.1em;
            color: #666666;
            margin-bottom: 30px;
        }

        .back-button {
            display: inline-block;
            padding: 15px 40px;
            background: #000000;
            color: #ffffff;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95em;
            letter-spacing: 0.02em;
            transition: all 0.3s ease;
            border: 2px solid #000000;
        }

        .back-button:hover {
            background: #ffffff;
            color: #000000;
        }

        @media (max-width: 768px) {
            body {
                padding: 30px 15px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }

            .header-content h1 {
                font-size: 2.2em;
            }

            .stats {
                gap: 30px;
            }

            .stat-value {
                font-size: 2em;
            }

            .rules-table {
                font-size: 0.9em;
            }

            .rules-table th,
            .rules-table td {
                padding: 12px 8px;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-content">
                <h1>Club Rules</h1>
                <div class="divider"></div>
                <p>Manage all club regulations and terms</p>
            </div>
            <a href="rule/create?clubID=${param.clubID}" class="add-button">Add New Rule</a>
        </div>

        <c:if test="${not empty rules}">
            <div class="stats">
                <div class="stat-item">
                    <div class="stat-value">${rules.size()}</div>
                    <div class="stat-label">Total Rules</div>
                </div>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty rules}">
                <div class="no-rules">
                    <h2>No Rules Yet</h2>
                    <p>The club currently has no published rules</p>
                    <a href="addRule.jsp?clubID=${param.clubID}" class="add-button">Create First Rule</a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="rules-table">
                    <thead>
                        <tr>
                            <th style="width: 10%;">No.</th>
                            <th style="width: 45%;">Title</th>
                            <th style="width: 20%;">Created Date</th>
                            <th style="width: 25%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="rule" items="${rules}" varStatus="status">
                            <tr>
                                <td>
                                    <span class="rule-number">${status.index + 1}</span>
                                </td>
                                <td>
                                    <span class="rule-title">
                                        ${rule.title != null ? rule.title : 'Rule #'.concat(rule.ruleID)}
                                    </span>
                                </td>
                                <td>
                                    <span class="rule-date">
                                        <fmt:formatDate value="${rule.createdAt}" pattern="MMM dd, yyyy"/>
                                    </span>
                                </td>
                                <td>
                                    <div class="actions">
                                        <a href="rule/view?id=${rule.ruleID}" class="btn btn-update">View Details</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <div style="text-align: center; margin-top: 60px;">
            <a href="javascript:history.back()" class="back-button">Back</a>
        </div>
    </div>
</body>
</html>