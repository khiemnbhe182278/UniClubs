<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create User</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f3f4f6;
                padding: 40px;
            }
            .form-container {
                max-width: 500px;
                margin: auto;
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #111827;
            }
            label {
                display: block;
                margin-top: 15px;
                font-weight: 600;
                color: #374151;
            }
            input, select {
                width: 100%;
                padding: 10px;
                border-radius: 8px;
                border: 1px solid #ddd;
                margin-top: 5px;
                font-size: 14px;
            }
            button {
                margin-top: 20px;
                padding: 12px;
                width: 100%;
                border: none;
                border-radius: 8px;
                background: #10b981;
                color: white;
                font-weight: 600;
                cursor: pointer;
                transition: background 0.2s;
            }
            button:hover {
                background: #059669;
            }
            .success {
                color: #16a34a;
                margin-top: 10px;
                text-align: center;
                font-size: 14px;
            }
            .error {
                color: #dc2626;
                margin-top: 10px;
                text-align: center;
                font-size: 14px;
            }
            .back-btn {
                margin-top: 15px;
                display: inline-block;
                text-decoration: none;
                color: #2563eb;
                font-size: 14px;
                text-align: center;
                width: 100%;
            }
            .back-btn:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Create New User</h2>

            <!-- Hi?n th? thông báo -->
            <c:if test="${not empty message}">
                <div class="success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <!-- Form create user -->
            <form method="post" action="${pageContext.request.contextPath}/createUser">
                <label>Username:</label>
                <input type="text" name="username" 
                       value="${param.username}" required>

                <label>Email:</label>
                <input type="email" name="email" 
                       value="${param.email}" required>

                <label>Password:</label>
                <input type="password" name="password" required>

                <label>Role:</label>
                <select name="role" required>
                    <option value="">-- Select Role --</option>
                    <c:forEach var="r" items="${roles}">
                        <option value="${r.roleID}" 
                                <c:if test="${param.role == r.roleID}">selected</c:if>>
                            ${r.roleName}
                        </option>
                    </c:forEach>
                </select>

                <button type="submit">Create</button>
            </form>

            <a href="${pageContext.request.contextPath}/admin/listAccounts" class="back-btn">
                Back to User List
            </a>
        </div>
    </body>
</html>
