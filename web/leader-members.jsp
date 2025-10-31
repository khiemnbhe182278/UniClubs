<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/header.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4 text-center text-primary">Manage Club Members</h2>

    <!-- Pending Members -->
    <div class="card mb-4 shadow">
        <div class="card-header bg-warning text-dark fw-bold">
            Pending Members
        </div>
        <div class="card-body">
            <c:if test="${empty pendingMembers}">
                <p>No pending members.</p>
            </c:if>
            <c:if test="${not empty pendingMembers}">
                <table class="table table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Joined At</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${pendingMembers}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${m.userName}</td>
                                <td>${m.email}</td>
                                <td>${m.joinedAt}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/leader/members" method="post" class="d-inline">
                                        <input type="hidden" name="memberId" value="${m.memberID}">
                                        <input type="hidden" name="clubId" value="${clubId}">
                                        <button type="submit" name="action" value="approve" class="btn btn-success btn-sm">
                                            Approve
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/leader/members" method="post" class="d-inline">
                                        <input type="hidden" name="memberId" value="${m.memberID}">
                                        <input type="hidden" name="clubId" value="${clubId}">
                                        <button type="submit" name="action" value="reject" class="btn btn-danger btn-sm">
                                            Reject
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

    <!-- Approved Members -->
    <div class="card shadow">
        <div class="card-header bg-success text-white fw-bold">
            Approved Members
        </div>
        <div class="card-body">
            <c:if test="${empty approvedMembers}">
                <p>No approved members yet.</p>
            </c:if>
            <c:if test="${not empty approvedMembers}">
                <table class="table table-striped align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Joined At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${approvedMembers}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${m.userName}</td>
                                <td>${m.email}</td>
                                <td>${m.joinedAt}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
