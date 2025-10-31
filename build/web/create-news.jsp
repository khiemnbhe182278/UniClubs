<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create News - ${club.clubName}</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                min-height: 100vh;
                padding: 40px 20px;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
            }

            .form-card {
                background: white;
                border-radius: 20px;
                padding: 40px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: hidden;
            }

            .form-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #2193b0 0%, #6dd5ed 100%);
            }

            h1 {
                font-size: 28px;
                font-weight: 700;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 10px;
            }

            .subtitle {
                color: #718096;
                font-size: 14px;
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            label {
                display: block;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 8px;
                font-size: 14px;
            }

            input[type="text"],
            textarea,
            select {
                width: 100%;
                padding: 14px 16px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-family: 'Inter', sans-serif;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            input[type="text"]:focus,
            textarea:focus,
            select:focus {
                outline: none;
                border-color: #2193b0;
                box-shadow: 0 0 0 3px rgba(33, 147, 176, 0.1);
            }

            textarea {
                min-height: 200px;
                resize: vertical;
            }

            .button-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .btn {
                flex: 1;
                padding: 14px 24px;
                border: none;
                border-radius: 12px;
                font-weight: 600;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .btn-primary {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(33, 147, 176, 0.3);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 25px rgba(33, 147, 176, 0.5);
            }

            .btn-secondary {
                background: #f7fafc;
                color: #2d3748;
                border: 2px solid #e2e8f0;
            }

            .btn-secondary:hover {
                background: #edf2f7;
                transform: translateY(-2px);
            }

            .alert {
                padding: 14px 18px;
                border-radius: 12px;
                margin-bottom: 25px;
                font-size: 14px;
                font-weight: 500;
            }

            .alert-error {
                background: #fee;
                color: #c53030;
                border-left: 4px solid #f56565;
            }

            .char-count {
                text-align: right;
                font-size: 12px;
                color: #718096;
                margin-top: 5px;
            }

            @media (max-width: 768px) {
                .form-card {
                    padding: 25px;
                }

                .button-group {
                    flex-direction: column;
                }

                h1 {
                    font-size: 24px;
                }
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .form-card {
                animation: fadeIn 0.5s ease;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="form-card">
                <h1>📰 Create News</h1>
                <p class="subtitle">${club.clubName}</p>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        ⚠️ ${error}
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/leader/create-news">
                    <input type="hidden" name="clubId" value="${club.clubID}">

                    <div class="form-group">
                        <label for="title">News Title *</label>
                        <input type="text" 
                               id="title" 
                               name="title" 
                               placeholder="Enter news title"
                               maxlength="200"
                               required>
                        <div class="char-count" id="titleCount">0/200</div>
                    </div>

                    <div class="form-group">
                        <label for="content">Content *</label>
                        <textarea id="content" 
                                  name="content" 
                                  placeholder="Write your news content here..."
                                  required></textarea>
                        <div class="char-count" id="contentCount">0 characters</div>
                    </div>

                    <div class="form-group">
                        <label for="status">Status *</label>
                        <select id="status" name="status" required>
                            <option value="">Select status</option>
                            <option value="Draft">Draft</option>
                            <option value="Published">Published</option>
                        </select>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            ✓ Create News
                        </button>
                        <a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}" 
                           class="btn btn-secondary">
                            ✗ Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Character counter for title
            const titleInput = document.getElementById('title');
            const titleCount = document.getElementById('titleCount');

            titleInput.addEventListener('input', function () {
                titleCount.textContent = this.value.length + '/200';
            });

            // Character counter for content
            const contentInput = document.getElementById('content');
            const contentCount = document.getElementById('contentCount');

            contentInput.addEventListener('input', function () {
                contentCount.textContent = this.value.length + ' characters';
            });
        </script>
    </body>
</html>