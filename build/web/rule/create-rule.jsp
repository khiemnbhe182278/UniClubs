<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Rule</title>
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
                color: #000000;
                line-height: 1.6;
                padding: 20px;
            }

            .container {
                max-width: 800px;
                margin: 60px auto;
                background-color: #ffffff;
                border: 1px solid #000000;
            }

            .header {
                padding: 30px 40px;
                border-bottom: 1px solid #000000;
                background: #000000;
                color: #ffffff;
            }

            .header h2 {
                font-size: 18px;
                font-weight: 500;
                letter-spacing: 0.5px;
                text-transform: uppercase;
            }

            .content {
                padding: 40px;
            }

            .form-group {
                margin-bottom: 32px;
            }

            .form-group:last-of-type {
                margin-bottom: 0;
            }

            .label {
                font-size: 11px;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #666666;
                margin-bottom: 8px;
                font-weight: 500;
                display: block;
            }

            .form-input,
            .form-textarea {
                width: 100%;
                padding: 12px;
                font-size: 15px;
                border: 1px solid #000000;
                background-color: #ffffff;
                color: #000000;
                font-family: inherit;
                transition: all 0.2s ease;
            }

            .form-input:focus,
            .form-textarea:focus {
                outline: none;
                background-color: #f8f8f8;
                border-color: #333333;
            }

            .form-textarea {
                min-height: 300px;
                resize: vertical;
            }

            .tinymce-container {
                border: 1px solid #000000;
                overflow: hidden;
                transition: border-color 0.3s ease;
            }

            .tinymce-container:focus-within {
                border-color: #333333;
            }

            .form-input[readonly] {
                background-color: #f0f0f0;
                color: #666666;
                cursor: not-allowed;
            }

            .actions {
                padding: 30px 40px;
                border-top: 1px solid #000000;
                display: flex;
                gap: 12px;
            }

            .btn {
                padding: 12px 28px;
                font-size: 13px;
                font-weight: 500;
                text-decoration: none;
                border: 1px solid #000000;
                background-color: #ffffff;
                color: #000000;
                cursor: pointer;
                transition: all 0.2s ease;
                letter-spacing: 0.3px;
                text-transform: uppercase;
            }

            .btn:hover {
                background-color: #000000;
                color: #ffffff;
                transform: translateY(-1px);
            }

            .btn-submit {
                background-color: #000000;
                color: #ffffff;
            }

            .btn-submit:hover {
                background-color: #333333;
                transform: translateY(-1px);
            }

            .btn-submit:disabled {
                background-color: #cccccc;
                border-color: #cccccc;
                cursor: not-allowed;
                transform: none;
            }

            .btn-cancel {
                background-color: #ffffff;
                color: #000000;
            }

            .helper-text {
                font-size: 12px;
                color: #666666;
                margin-top: 6px;
            }

            @media (max-width: 768px) {
                .container {
                    margin: 20px auto;
                }

                .header, .content, .actions {
                    padding: 24px;
                }

                .actions {
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h2>Create New Rule</h2>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/rule/create" onsubmit="return validateForm()">
                <input type="hidden" name="clubID" value="${clubID}">

                <div class="content">
                    <div class="form-group">
                        <label class="label" for="ruleText">Rule Text *</label>
                        <div class="tinymce-container">
                            <textarea class="form-textarea" 
                                      id="ruleText" 
                                      name="ruleText" 
                                      placeholder="Enter the rule description..."></textarea>
                        </div>
                        <p class="helper-text">* Required field - Use the editor to format your rule text</p>
                    </div>
                </div>

                <div class="actions">
                    <button type="submit" class="btn btn-submit">Create Rule</button>
                    <a href="${pageContext.request.contextPath}/rules?clubID=${clubID}" class="btn btn-cancel">
                        Cancel
                    </a>
                </div>
            </form>
        </div>

        <script>
            // Initialize TinyMCE
            let editorInstance = null;

            function initTinyMCE() {
                tinymce.init({
                    selector: '#ruleText',
                    height: 300,
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
                        
                        // Auto-focus when editor is ready
                        editor.on('init', function () {
                            editor.focus();
                        });
                    },
                    skin: 'oxide',
                    content_css: 'default'
                });
            }

            function validateForm() {
                // Ensure TinyMCE content is saved to textarea
                if (editorInstance) {
                    editorInstance.save();
                }

                const ruleText = document.getElementById('ruleText').value.trim();

                if (ruleText === '' || ruleText === '<p></p>' || ruleText === '<p><br></p>') {
                    alert('Please enter the rule text.');
                    // Focus on TinyMCE editor instead of hidden textarea
                    if (editorInstance) {
                        editorInstance.focus();
                    }
                    return false;
                }

                // Remove HTML tags for length validation
                const textContent = ruleText.replace(/<[^>]*>/g, '').trim();
                if (textContent.length < 5) {
                    alert('Rule text must be at least 5 characters long.');
                    // Focus on TinyMCE editor instead of hidden textarea
                    if (editorInstance) {
                        editorInstance.focus();
                    }
                    return false;
                }

                return true;
            }

            // Initialize TinyMCE when page loads
            window.onload = function () {
                setTimeout(initTinyMCE, 100);
            };

            // Handle form submission
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.querySelector('form');
                form.addEventListener('submit', function(e) {
                    // Ensure TinyMCE content is saved to textarea before validations
                    if (editorInstance) {
                        editorInstance.save();
                    }
                });

                // Smooth page load animation
                const container = document.querySelector('.container');
                container.style.opacity = '0';
                container.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    container.style.transition = 'all 0.8s ease';
                    container.style.opacity = '1';
                    container.style.transform = 'translateY(0)';
                }, 100);
            });
        </script>
    </body>
</html>