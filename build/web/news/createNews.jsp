<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Create News</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* CSS tương tự như createEvent.jsp */
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

            :root {
                --primary-color: #4A90E2;
                --secondary-color: #50E3C2;
                --text-color: #333;
                --bg-color: #F8F9FA;
                --card-bg-color: #fff;
                --border-color: #E0E0E0;
                --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            body {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 40px;
                background-color: var(--bg-color);
                color: var(--text-color);
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .form-container {
                width: 100%;
                max-width: 500px;
                background-color: var(--card-bg-color);
                padding: 30px;
                border-radius: 15px;
                box-shadow: var(--shadow);
                transition: transform 0.3s ease;
            }

            .form-container:hover {
                transform: translateY(-5px);
            }

            .form-header {
                text-align: center;
                margin-bottom: 25px;
                position: relative;
            }

            .form-header h2 {
                color: var(--primary-color);
                font-weight: 600;
                font-size: 1.8rem;
                margin: 0;
                position: relative;
                padding-bottom: 10px;
            }

            .form-header h2::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: var(--secondary-color);
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 0.95rem;
            }

            .input-group {
                position: relative;
            }

            .input-group i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--primary-color);
            }

            input, textarea {
                width: 100%;
                padding: 12px 12px 12px 40px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 1rem;
                color: var(--text-color);
                transition: border-color 0.3s ease;
                box-sizing: border-box;
            }

            input:focus, textarea:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
            }

            textarea {
                padding-left: 12px;
                min-height: 150px;
            }

            #content.textarea-with-icon {
                padding-left: 40px;
            }

            .error-message {
                color: #e74c3c;
                font-size: 0.85rem;
                margin-top: 5px;
                display: none;
            }

            .form-actions {
                margin-top: 30px;
            }

            button {
                width: 100%;
                padding: 14px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            button:hover {
                background-color: #3876C4;
                transform: translateY(-2px);
            }

            .message-box {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 8px;
                font-weight: 600;
                text-align: center;
                transition: opacity 0.5s ease;
            }

            .success-message {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .error-message-box {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
        </style>
    </head>
    <body>
        <%
            // Lấy Club ID từ URL
            String clubID = request.getParameter("clubID");
            if (clubID == null || clubID.trim().isEmpty()) {
                out.println("<h1>Error: Missing Club ID in URL.</h1>");
                return;
            }
        %>
        <div class="form-container">
            <div class="form-header">
                <h2>Create New News</h2>
            </div>

            <%-- Hiển thị thông báo --%>
            <%
                String successMessage = (String) request.getAttribute("successMessage");
                String errorMessage = (String) request.getAttribute("errorMessage");
            %>
            <% if (successMessage != null) { %>
            <div class="message-box success-message">
                <%= successMessage %>
            </div>
            <% } %>
            <% if (errorMessage != null) { %>
            <div class="message-box error-message-box">
                <%= errorMessage %>
            </div>
            <% } %>

            <form id="newsForm" action="createNews" method="post">
                <input type="hidden" name="clubID" value="<%= clubID %>">

                <div class="form-group">
                    <label for="title">News Title</label>
                    <div class="input-group">
                        <i class="fas fa-newspaper"></i>
                        <input type="text" id="title" name="title" required value="<%= request.getAttribute("title") != null ? request.getAttribute("title") : "" %>">
                    </div>
                    <span class="error-message" id="titleError">Title cannot be empty.</span>
                </div>

                <div class="form-group">
                    <label for="content">Content</label>
                    <textarea id="content" name="content" rows="8" required><%= request.getAttribute("content") != null ? request.getAttribute("content") : "" %></textarea>
                    <span class="error-message" id="contentError">Content cannot be empty.</span>
                </div>

                <div class="form-actions">
                    <button type="submit">Create News</button>
                </div>
            </form>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const form = document.getElementById('newsForm');
                const titleInput = document.getElementById('title');
                const contentInput = document.getElementById('content');

                form.addEventListener('submit', function (event) {
                    let isValid = true;

                    if (titleInput.value.trim() === '') {
                        document.getElementById('titleError').style.display = 'block';
                        isValid = false;
                    } else {
                        document.getElementById('titleError').style.display = 'none';
                    }

                    if (contentInput.value.trim() === '') {
                        document.getElementById('contentError').style.display = 'block';
                        isValid = false;
                    } else {
                        document.getElementById('contentError').style.display = 'none';
                    }

                    if (!isValid) {
                        event.preventDefault();
                    }
                });

                const messageBox = document.querySelector('.message-box');
                if (messageBox) {
                    setTimeout(() => {
                        messageBox.style.opacity = '0';
                        setTimeout(() => messageBox.style.display = 'none', 500);
                    }, 5000);
                }
            });
        </script>
    </body>
</html>