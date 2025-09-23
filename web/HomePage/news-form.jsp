<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.News" %>
<%@ page import="java.time.LocalDate" %>
<%
    News news = (News) request.getAttribute("news");
    boolean isEdit = news != null;
    String pageTitle = isEdit ? "Edit News" : "Add New News";
    String formAction = isEdit ? "update" : "create";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= pageTitle %> - Student Club</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f4f9;
            color: #1e293b;
            line-height: 1.7;
            font-size: 16px;
        }

        header {
            background: linear-gradient(90deg, #1e3a8a, #60a5fa);
            color: #ffffff;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        header h1 {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 1.2px;
        }

        nav a {
            color: #ffffff;
            text-decoration: none;
            margin: 0 15px;
            font-weight: 500;
            font-size: 16px;
            position: relative;
            transition: color 0.3s ease;
        }

        nav a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -4px;
            left: 0;
            background-color: #facc15;
            transition: width 0.3s ease;
        }

        nav a:hover::after {
            width: 100%;
        }

        nav a:hover {
            color: #facc15;
        }

        section {
            padding: 40px;
            margin: 20px auto;
            width: 90%;
            max-width: 800px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 28px;
            color: #1e3a8a;
            margin-bottom: 20px;
            border-left: 6px solid #60a5fa;
            padding-left: 12px;
            font-weight: 600;
        }

        .form-container {
            max-width: 700px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 16px;
            font-weight: 500;
            color: #1e3a8a;
            margin-bottom: 8px;
        }

        input[type="text"],
        input[type="date"],
        input[type="url"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            font-size: 15px;
            border: 2px solid #bfdbfe;
            border-radius: 8px;
            background: #f8fafc;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            font-family: 'Poppins', sans-serif;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="url"]:focus,
        textarea:focus,
        select:focus {
            border-color: #60a5fa;
            box-shadow: 0 0 8px rgba(96, 165, 250, 0.3);
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 150px;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        button[type="submit"],
        .btn-cancel {
            padding: 12px 24px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            flex: 1;
        }

        button[type="submit"] {
            background: linear-gradient(90deg, #1e3a8a, #60a5fa);
            color: #ffffff;
        }

        button[type="submit"]:hover {
            background: linear-gradient(90deg, #2563eb, #93c5fd);
            transform: translateY(-2px);
        }

        .btn-cancel {
            background: #f8fafc;
            color: #64748b;
            border: 2px solid #bfdbfe;
        }

        .btn-cancel:hover {
            background: #f1f5f9;
            color: #475569;
        }

        .image-preview {
            margin-top: 10px;
            text-align: center;
        }

        .image-preview img {
            max-width: 200px;
            max-height: 150px;
            border-radius: 8px;
            border: 2px solid #bfdbfe;
        }

        .required {
            color: #dc2626;
        }

        footer {
            background: #1e3a8a;
            color: #ffffff;
            text-align: center;
            padding: 25px;
            font-size: 15px;
            margin-top: 30px;
        }

        footer a {
            color: #93c5fd;
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        footer a:hover {
            color: #facc15;
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                padding: 15px 20px;
            }

            header h1 {
                font-size: 24px;
                margin-bottom: 10px;
            }

            nav a {
                margin: 0 8px;
                font-size: 14px;
            }

            section {
                padding: 20px;
                width: 95%;
            }

            h2 {
                font-size: 24px;
            }

            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Student Club</h1>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="news">News</a>
            <a href="club-registration?action=new">Register Club</a>
            <a href="users">Members</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
            <a href="login.jsp">Login</a>
        </nav>
    </header>

    <section>
        <h2><%= pageTitle %></h2>

        <div class="form-container">
            <form method="post" action="news" id="newsForm">
                <input type="hidden" name="action" value="<%= formAction %>">
                <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= news.getId() %>">
                <% } %>

                <div class="form-group">
                    <label for="title">Title <span class="required">*</span></label>
                    <input type="text" id="title" name="title" 
                           value="<%= isEdit ? news.getTitle() : "" %>" 
                           required placeholder="Enter news title">
                </div>

                <div class="form-group">
                    <label for="publishDate">Publish Date <span class="required">*</span></label>
                    <input type="date" id="publishDate" name="publishDate" 
                           value="<%= isEdit ? news.getPublishDate() : LocalDate.now() %>" 
                           required>
                </div>

                <div class="form-group">
                    <label for="imageUrl">Image URL (Optional)</label>
                    <input type="url" id="imageUrl" name="imageUrl" 
                           value="<%= isEdit && news.getImageUrl() != null ? news.getImageUrl() : "" %>" 
                           placeholder="https://example.com/image.jpg">
                    <% if (isEdit && news.getImageUrl() != null && !news.getImageUrl().isEmpty()) { %>
                        <div class="image-preview">
                            <img src="<%= news.getImageUrl() %>" alt="Current image" 
                                 onerror="this.style.display='none'">
                        </div>
                    <% } %>
                </div>

                <div class="form-group">
                    <label for="content">Content <span class="required">*</span></label>
                    <textarea id="content" name="content" required 
                              placeholder="Enter news content..."><%= isEdit ? news.getContent() : "" %></textarea>
                </div>

                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status">
                        <option value="published" <%= isEdit && "published".equals(news.getStatus()) ? "selected" : "" %>>Published</option>
                        <option value="draft" <%= isEdit && "draft".equals(news.getStatus()) ? "selected" : "" %>>Draft</option>
                    </select>
                </div>

                <div class="button-group">
                    <button type="submit">
                        <%= isEdit ? "📝 Update News" : "📰 Publish News" %>
                    </button>
                    <a href="news" class="btn-cancel">❌ Cancel</a>
                </div>
            </form>
        </div>
    </section>

    <footer>
        © 2025 Student Club | Contact: info@studentclub.edu
    </footer>

    <script>
        // Image preview functionality
        document.getElementById('imageUrl').addEventListener('input', function() {
            const preview = document.querySelector('.image-preview');
            const img = preview ? preview.querySelector('img') : null;
            const imageUrl = this.value.trim();
            
            if (imageUrl) {
                if (!preview) {
                    const previewDiv = document.createElement('div');
                    previewDiv.className = 'image-preview';
                    previewDiv.innerHTML = '<img src="" alt="Image preview" onerror="this.style.display=\'none\'">';
                    this.parentNode.appendChild(previewDiv);
                }
                
                const newImg = document.querySelector('.image-preview img');
                newImg.src = imageUrl;
                newImg.style.display = 'block';
            } else if (preview) {
                preview.remove();
            }
        });

        // Form validation
        document.getElementById('newsForm').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            const publishDate = document.getElementById('publishDate').value;
            
            if (!title) {
                e.preventDefault();
                alert('Please enter a title');
                document.getElementById('title').focus();
                return;
            }
            
            if (!content) {
                e.preventDefault();
                alert('Please enter content');
                document.getElementById('content').focus();
                return;
            }
            
            if (!publishDate) {
                e.preventDefault();
                alert('Please select a publish date');
                document.getElementById('publishDate').focus();
                return;
            }
        });

        // Set min date to today
        document.getElementById('publishDate').min = new Date().toISOString().split('T')[0];
    </script>
</body>
</html>