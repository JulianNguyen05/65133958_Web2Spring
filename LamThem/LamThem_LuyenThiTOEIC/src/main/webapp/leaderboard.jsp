<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng Xếp Hạng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .top-1 { background-color: #fff3cd; font-weight: bold; } /* Vàng */
        .top-2 { background-color: #e2e3e5; font-weight: bold; } /* Bạc */
        .top-3 { background-color: #f8d7da; font-weight: bold; } /* Đồng */
    </style>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="text-center mb-4">
        <h2 class="fw-bold text-primary">🏆 BẢNG XẾP HẠNG THÀNH TÍCH 🏆</h2>
        <p class="text-muted">Top 50 học viên có số điểm cao nhất và thời gian làm bài nhanh nhất.</p>
    </div>

    <div class="card shadow-lg border-0">
        <div class="card-body p-0">
            <table class="table table-hover mb-0 text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Hạng</th>
                        <th class="text-start">Học viên</th>
                        <th>Điểm số</th>
                        <th>Thời gian</th>
                        <th>Ngày thi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${leaderboard}" var="r" varStatus="st">
                        <tr class="${st.index == 0 ? 'top-1' : (st.index == 1 ? 'top-2' : (st.index == 2 ? 'top-3' : ''))}">
                            <td>
                                <c:choose>
                                    <c:when test="${st.index == 0}">🥇 1</c:when>
                                    <c:when test="${st.index == 1}">🥈 2</c:when>
                                    <c:when test="${st.index == 2}">🥉 3</c:when>
                                    <c:otherwise>${st.index + 1}</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-start">
                                <strong>${not empty r.fullName ? r.fullName : r.username}</strong>
                            </td>
                            <td class="text-danger fw-bold fs-5">${r.score}</td>
                            <td>⏳ ${r.formattedTime}</td>
                            <td class="text-muted small">${r.completedAt}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty leaderboard}">
                        <tr>
                            <td colspan="5" class="text-center py-4 text-secondary">
                                Chưa có ai hoàn thành đề thi này. Hãy là người đầu tiên!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary px-4">⬅ Quay lại Thư viện đề</a>
    </div>
</div>

</body>
</html>