<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rule Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Include TinyMCE for rich text editing -->
        <script src="https://cdn.jsdelivr.net/npm/tinymce@6/tinymce.min.js"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Arial', 'Helvetica', sans-serif;
                background: #f5f5f5;
                min-height: 100vh;
                padding: 20px;
                color: #000000;
            }

            .main-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .content-wrapper {
                background: #ffffff;
                color: #000000;
                overflow: hidden;
                border: 1px solid #333333;
            }

            /* Header Section */
            .page-header {
                background: #000000;
                padding: 40px 50px;
                color: #ffffff;
            }

            .page-header h1 {
                font-size: 28px;
                font-weight: 700;
                margin: 0;
            }

            .page-header p {
                margin: 10px 0 0 0;
                font-size: 16px;
                color: #cccccc;
            }

            /* Main Content */
            .content-body {
                padding: 50px;
            }

            /* Rule Content Section */
            .rule-section {
                margin-bottom: 40px;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 2px solid #333333;
            }

            .section-title {
                font-size: 20px;
                font-weight: 600;
                color: #000000;
                margin: 0;
            }

            .rule-content-display {
                background: #f8f8f8;
                padding: 35px;
                border: 1px solid #333333;
                border-left: 4px solid #000000;
                font-size: 16px;
                line-height: 1.8;
                color: #000000;
                min-height: 200px;
            }

            /* Metadata Section */
            .metadata-section {
                background: #f0f0f0;
                padding: 30px;
                margin-bottom: 30px;
                border: 1px solid #ddd;
            }

            .metadata-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 25px;
            }

            .metadata-item {
                background: #ffffff;
                padding: 20px;
                border: 1px solid #ddd;
                border-left: 4px solid #000000;
            }

            .metadata-label {
                font-size: 12px;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: #666666;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .metadata-value {
                font-size: 16px;
                color: #000000;
                font-weight: 500;
            }

            /* Action Buttons */
            .action-section {
                text-align: center;
                margin-top: 40px;
            }

            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
            }

            .btn-custom {
                padding: 14px 32px;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border: 2px solid;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-width: 140px;
                background: none;
            }

            .btn-primary-custom {
                background: #000000;
                color: #ffffff;
                border-color: #000000;
            }

            .btn-primary-custom:hover {
                background: #333333;
                border-color: #333333;
                color: #ffffff;
                transform: translateY(-2px);
            }

            .btn-danger-custom {
                background: #ffffff;
                color: #000000;
                border-color: #000000;
            }

            .btn-danger-custom:hover {
                background: #000000;
                color: #ffffff;
                border-color: #000000;
                transform: translateY(-2px);
            }

            /* Edit Mode Styles */
            .edit-mode {
                display: none;
            }

            .form-section {
                padding: 50px;
            }

            .form-group-custom {
                margin-bottom: 35px;
            }

            .form-label-custom {
                font-size: 14px;
                font-weight: 600;
                color: #000000;
                margin-bottom: 12px;
                display: block;
            }

            .tinymce-container {
                border: 2px solid #333333;
                overflow: hidden;
                transition: border-color 0.3s ease;
            }

            .tinymce-container:focus-within {
                border-color: #000000;
            }

            .form-actions {
                display: flex;
                gap: 20px;
                margin-top: 40px;
                padding-top: 30px;
                border-top: 2px solid #333333;
                justify-content: center;
            }

            .btn-save-custom {
                background: #000000;
                color: #ffffff;
                padding: 14px 32px;
                border: 2px solid #000000;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 140px;
            }

            .btn-save-custom:hover {
                background: #333333;
                border-color: #333333;
                transform: translateY(-2px);
            }

            .btn-cancel-custom {
                background: #ffffff;
                color: #000000;
                padding: 14px 32px;
                border: 2px solid #000000;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 140px;
            }

            .btn-cancel-custom:hover {
                background: #f0f0f0;
                color: #000000;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .content-body,
                .form-section {
                    padding: 30px 25px;
                }

                .page-header {
                    padding: 30px 25px;
                }

                .page-header h1 {
                    font-size: 24px;
                }

                .action-buttons {
                    flex-direction: column;
                    align-items: center;
                }

                .metadata-grid {
                    grid-template-columns: 1fr;
                }

                .form-actions {
                    flex-direction: column;
                }
            }

            @media (max-width: 480px) {
                .main-container {
                    padding: 10px;
                }

                .rule-content-display {
                    padding: 25px;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="content-wrapper">
                <!-- Header -->
                <div class="page-header">
                    <h1>Club Rules</h1>
                    <p>View and manage club regulations</p>
                </div>

                <!-- View Mode -->
                <div id="viewMode">
                    <div class="content-body">
                        <!-- Rule Content Section -->
                        <div class="rule-section">
                            <div class="section-header">
                                <h2 class="section-title">Rule Content</h2>
                            </div>
                            <div class="rule-content-display" id="ruleContentDisplay">
                                ${rule.ruleText}
                            </div>
                        </div>

                        <!-- Metadata Section -->
                        <div class="metadata-section">
                            <div class="metadata-grid">
                                <div class="metadata-item">
                                    <div class="metadata-label">Created Date</div>
                                    <div class="metadata-value">${rule.createdAt}</div>
                                </div>
                                <div class="metadata-item">
                                    <div class="metadata-label">Last Modified</div>
                                    <div class="metadata-value">Recently updated</div>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="action-section">
                            <div class="action-buttons">
                                <button class="btn-custom btn-primary-custom" onclick="enableEditMode()">
                                    Edit Rule
                                </button>
                                <a href="${pageContext.request.contextPath}/rule/delete?id=${rule.ruleID}" 
                                   class="btn-custom btn-danger-custom"
                                   onclick="return confirm('Are you sure you want to delete this rule? This action cannot be undone.');">
                                    Delete Rule
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Edit Mode -->
                <form id="editMode" class="edit-mode" method="post" 
                      action="${pageContext.request.contextPath}/rule/update">
                    <input type="hidden" name="id" value="${rule.ruleID}">
                    <input type="hidden" name="clubID" value="${rule.clubID}">

                    <div class="form-section">
                        <div class="form-group-custom">
                            <label class="form-label-custom" for="ruleText">Rule Content</label>
                            <div class="tinymce-container">
                                <textarea id="ruleText" name="ruleText">${rule.ruleText}</textarea>
                            </div>
                        </div>

                        <div class="metadata-section">
                            <div class="metadata-grid">
                                <div class="metadata-item">
                                    <div class="metadata-label">Created Date</div>
                                    <div class="metadata-value">${rule.createdAt}</div>
                                </div>
                                <div class="metadata-item">
                                    <div class="metadata-label">Editing</div>
                                    <div class="metadata-value">Current session</div>
                                </div>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn-save-custom">Save Changes</button>
                            <button type="button" class="btn-cancel-custom" onclick="cancelEdit()">Cancel</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Initialize TinyMCE
            let editorInstance = null;

            function initTinyMCE() {
                tinymce.init({
                    selector: '#ruleText',
                    height: 400,
                    menubar: false,
                    plugins: [
                        'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                        'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                        'insertdatetime', 'media', 'table', 'help', 'wordcount'
                    ],
                    toolbar: 'undo redo | blocks | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help',
                    content_style: 'body { font-family: Arial, Helvetica, sans-serif; font-size: 16px; line-height: 1.6; }',
                    branding: false,
                    resize: 'vertical',
                    setup: function (editor) {
                        editorInstance = editor;
                    }
                });
            }

            function enableEditMode() {
                document.getElementById('viewMode').style.display = 'none';
                document.getElementById('editMode').style.display = 'block';
                
                // Initialize TinyMCE when entering edit mode
                setTimeout(initTinyMCE, 100);
                
                // Smooth scroll to top
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }

            function cancelEdit() {
                // Clean up TinyMCE
                if (editorInstance) {
                    tinymce.remove('#ruleText');
                    editorInstance = null;
                }
                
                document.getElementById('editMode').style.display = 'none';
                document.getElementById('viewMode').style.display = 'block';
                
                // Smooth scroll to top
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }

            // Handle form submission
            document.getElementById('editMode').addEventListener('submit', function(e) {
                // Ensure TinyMCE content is saved to textarea
                if (editorInstance) {
                    editorInstance.save();
                }
            });

            // Smooth page load animation
            document.addEventListener('DOMContentLoaded', function() {
                const wrapper = document.querySelector('.content-wrapper');
                wrapper.style.opacity = '0';
                wrapper.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    wrapper.style.transition = 'all 0.8s ease';
                    wrapper.style.opacity = '1';
                    wrapper.style.transform = 'translateY(0)';
                }, 100);
            });

            // Confirmation for delete action
            function confirmDelete(event) {
                if (!confirm('Are you sure you want to delete this rule? This action cannot be undone.')) {
                    event.preventDefault();
                }
            }
        </script>
    </body>
</html>