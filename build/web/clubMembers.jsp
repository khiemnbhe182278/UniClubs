<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Member" %>
<%
    List<Member> members = (List<Member>) request.getAttribute("members");
%>
<html>
    <head>
        <title>Club Members Management</title>
        <style>
            body {
                font-family: Arial;
                background: #f5f6fa;
                margin: 30px;
            }
            h2 {
                color: #333;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                background: #fff;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background: #007bff;
                color: #fff;
            }
            tr:nth-child(even) {
                background: #f9f9f9;
            }
            .btn {
                border: none;
                padding: 6px 10px;
                border-radius: 5px;
                color: #fff;
                cursor: pointer;
            }
            .approve {
                background: #28a745;
            }
            .reject {
                background: #dc3545;
            }
            .pending {
                color: #ff9800;
                font-weight: bold;
            }
            .approved {
                color: #28a745;
                font-weight: bold;
            }
            .rejected {
                color: #dc3545;
                font-weight: bold;
            }
        </style>
    </head>
    <body>

        <h2>Club Members List</h2>

        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Joined At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (members != null && !members.isEmpty()) {
           for (Member m : members) { %>
                <tr>
                    <td><%= m.getMemberID() %></td>
                    <td><%= m.getUserName() %></td>
                    <td><%= m.getEmail() %></td>
                    <td class="<%= m.getJoinStatus().toLowerCase() %>">
                        <%= m.getJoinStatus() %>
                    </td>
                    <td><%= m.getJoinedAt() %></td>
                    <td>
                        <% if ("Pending".equalsIgnoreCase(m.getJoinStatus())) { %>
                        <form method="post" action="<%= request.getContextPath() %>/club/members" style="display:inline;">
                            <input type="hidden" name="memberId" value="<%= m.getMemberID() %>">
                            <input type="hidden" name="action" value="approve">
                            <button type="submit" class="btn approve">Approve</button>
                        </form>
                        <form method="post" action="<%= request.getContextPath() %>/club/members" style="display:inline;">
                            <input type="hidden" name="memberId" value="<%= m.getMemberID() %>">
                            <input type="hidden" name="action" value="reject">
                            <button type="submit" class="btn reject">Reject</button>
                        </form>
                        <% } else { %>
                        <em>No actions</em>
                        <% } %>
                    </td>
                </tr>
                <% } } else { %>
                <tr><td colspan="6">No members found.</td></tr>
                <% } %>
            </tbody>
        </table>

    </body>
</html>
