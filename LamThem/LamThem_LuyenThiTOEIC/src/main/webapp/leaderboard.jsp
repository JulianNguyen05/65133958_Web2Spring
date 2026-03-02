<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng Xếp Hạng - JulianToeic Lab</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7fa; color: #2c3e50; }
        .hero-banner { background: linear-gradient(135deg, #00E5FF, #0072ff); color: white; padding: 50px 0 80px; text-align: center; border-radius: 0 0 40px 40px; margin-bottom: -50px; }
        .card { border-radius: 20px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.08); overflow: hidden; }
        .table { margin-bottom: 0; vertical-align: middle; }
        .table thead th { background: #f8fafc; border-bottom: 2px solid #edf2f7; color: #718096; font-weight: 600; text-transform: uppercase; font-size: 13px; padding: 18px 15px; }
        .table tbody td { padding: 15px; border-bottom: 1px solid #edf2f7; font-size: 15px; }
        
        /* Hiệu ứng huy chương Top 3 */
        .rank-badge { width: 35px; height: 35px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; font-weight: bold; }
        .rank-1 { background: #fff3cd; color: #b78103; box-shadow: 0 4px 10px rgba(255, 193, 7, 0.3); font-size: 18px; }
        .rank-2 { background: #e2e8f0; color: #4a5568; box-shadow: 0 4px 10px rgba(160, 174, 192, 0.3); font-size: 17px; }
        .rank-3 { background: #fed7d7; color: #c53030; box-shadow: 0 4px 10px rgba(229, 62, 62, 0.3); font-size: 16px; }
        .rank-other { background: transparent; color: #a0aec0; }
        
        .score-text { color: #0072ff; font-weight: 700; font-size: 18px; }
    </style>
</head>
<body>

<div class="hero-banner">
    <div class="container">
        <i class="fas fa-trophy fa-3x mb-3 text-warning" style="filter: drop-shadow(0 0 10px rgba(255,255,255,0.5));"></i>
        <h1 class="fw-bold">Bảng Xếp Hạng Thành Tích</h1>
        <p class="opacity-75">Vinh danh Top 50 học viên có điểm số cao nhất và thời gian nhanh nhất.</p>
    </div>
</div>

<div class="container position-relative mb-5">
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th width="10%">Hạng</th>
                            <th class="text-start">Học viên</th>
                            <th>Điểm số</th>
                            <th>Thời gian</th>
                            <th>Ngày thi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${leaderboard}" var="r" varStatus="st">
                            <tr>
                                <td>
                                    <div class="rank-badge mx-auto ${st.index == 0 ? 'rank-1' : (st.index == 1 ? 'rank-2' : (st.index == 2 ? 'rank-3' : 'rank-other'))}">
                                        ${st.index == 0 ? '🥇' : (st.index == 1 ? '🥈' : (st.index == 2 ? '🥉' : st.index + 1))}
                                    </div>
                                </td>
                                <td class="text-start">
                                    <div class="d-flex align-items-center">
                                        <img src="https://ui-avatars.com/api/?name=${not empty r.fullName ? r.fullName : r.username}&background=random&color=fff&rounded=true" width="36" class="me-3 shadow-sm">
                                        <strong class="text-dark">${not empty r.fullName ? r.fullName : r.username}</strong>
                                    </div>
                                </td>
                                <td class="score-text">${r.score} <small class="text-muted fs-6 fw-normal">pt</small></td>
                                <td class="text-muted fw-medium"><i class="fas fa-stopwatch me-1 opacity-50"></i> ${r.formattedTime}</td>
                                <td class="text-muted small">${r.completedAt}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty leaderboard}">
                            <tr><td colspan=\"5\" class="text-center py-5 text-muted"><img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" width="80" class="mb-3 opacity-25"><br>Chưa có ai hoàn thành đề thi này.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <div class="text-center mt-5">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-4 rounded-pill fw-bold"><i class="fas fa-arrow-left me-2"></i> Quay lại thư viện đề</a>
    </div>
</div>

</body>
</html>