<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Report Club</title>
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
                color: #e74c3c;
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
                min-height: 200px;
            }
            .btn-submit {
                width: 100%;
                padding: 1rem;
                background: #e74c3c;
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 1.1rem;
                cursor: pointer;
            }
            .warning {
                background: #fff3cd;
                border-left: 4px solid #f39c12;
                padding: 1rem;
                margin-bottom: 1.5rem;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>⚠️ Report Club</h1>
            <div class="warning">
                <strong>Important:</strong> Please only report genuine violations. False reports may result in action against your account.
            </div>
            <form action="${pageContext.request.contextPath}/report-club" method="post">
                <input type="hidden" name="clubId" value="${param.clubId}">
                <div class="form-group">
                    <label for="reportType">Report Type *</label>
                    <select id="reportType" name="reportType" required>
                        <option value="">Select a reason</option>
                        <option value="Inappropriate Content">Inappropriate Content</option>
                        <option value="Harassment">Harassment or Bullying</option>
                        <option value="Spam">Spam or Misleading</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="subject">Subject *</label>
                    <input type="text" id="subject" name="subject" required placeholder="Brief summary of the issue">
                </div>
                <div class="form-group">
                    <label for="description">Detailed Description *</label>
                    <textarea id="description" name="description" required placeholder="Please provide as much detail as possible about the issue..."></textarea>
                </div>
                <button type="submit" class="btn-submit">Submit Report</button>
            </form>
        </div>
    </body>
</html>