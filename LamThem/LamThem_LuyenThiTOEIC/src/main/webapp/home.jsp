<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thư viện đề thi - JulianToeic</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7fa; color: #2c3e50; }
        .navbar-custom { background: linear-gradient(135deg, #0f2027, #203a43, #2c5364); padding: 15px 0; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .navbar-brand { font-weight: 700; font-size: 1.5rem; letter-spacing: 1px; color: #00E5FF !important; }
        
        .hero-section { background: #fff; padding: 40px 0; border-bottom: 1px solid #eaeaea; margin-bottom: 40px; text-align: center; }
        .hero-title { font-weight: 700; color: #203a43; }

        .exam-card { border: none; border-radius: 16px; box-shadow: 0 8px 20px rgba(0,0,0,0.04); transition: all 0.3s ease; cursor: pointer; height: 100%; }
        .exam-card:hover { transform: translateY(-8px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); border-color: #0072ff; }
        .card-icon { width: 60px; height: 60px; background: #e0f2fe; color: #0072ff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 24px; margin-bottom: 15px; }
        .card-title { font-weight: 700; font-size: 1.2rem; color: #2c3e50; }
        
        .modal-content { border-radius: 20px; border: none; }
        .modal-header { border-bottom: none; padding: 25px 25px 0; }
        .modal-body { padding: 25px; }
        .btn-custom { border-radius: 12px; padding: 12px 20px; font-weight: 600; transition: 0.3s; }
        .btn-do-exam { background: linear-gradient(135deg, #00E5FF, #0072ff); color: white; border: none; }
        .btn-do-exam:hover { box-shadow: 0 8px 20px rgba(0, 114, 255, 0.3); transform: translateY(-2px); color: white; }
        .btn-leaderboard { background: #fff; border: 2px solid #ffa502; color: #ffa502; }
        .btn-leaderboard:hover { background: #ffa502; color: white; transform: translateY(-2px); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="#"><i class="fas fa-graduation-cap me-2"></i> JulianToeic Lab</a>
        <div class="d-flex align-items-center">
            <div class="text-white me-4">
                <img src="https://ui-avatars.com/api/?name=${sessionScope.sessionUser.username}&background=00E5FF&color=fff&rounded=true" width="35" class="me-2 shadow-sm">
                Xin chào, <strong class="fs-6">${not empty sessionScope.sessionUser.username ? sessionScope.sessionUser.username : 'Học viên'}</strong>
            </div>
            <c:if test="${sessionScope.sessionUser.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-outline-light btn-sm me-2 rounded-pill px-3"><i class="fas fa-cogs"></i> Quản trị</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-pill px-3"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>
</nav>

<div class="hero-section">
    <div class="container">
        <h2 class="hero-title">Thư viện Đề thi TOEIC</h2>
        <p class="text-muted">Luyện tập mỗi ngày để đạt điểm số tối đa. Chọn một đề thi bên dưới để bắt đầu!</p>
    </div>
</div>

<div class="container pb-5">
    <div class="row g-4">
        <c:if test="${empty listExams}">
            <div class="col-12 text-center py-5">
                <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" width="120" class="mb-3 opacity-50">
                <h4 class="text-muted">Chưa có đề thi nào trong hệ thống.</h4>
            </div>
        </c:if>

        <c:forEach items="${listExams}" var="o">
            <div class="col-md-4 col-lg-3">
                <div class="card exam-card h-100 p-3" onclick="openOptionModal(${o.examId}, '${o.title}', '${o.fileName}')">
                    <div class="card-body">
                        <div class="card-icon"><i class="fas fa-file-alt"></i></div>
                        <h5 class="card-title">${o.title}</h5>
                        <p class="card-text text-muted small mt-2 line-clamp-2">${o.description}</p>
                    </div>
                    <div class="card-footer bg-transparent border-0 pt-0">
                        <span class="badge bg-light text-secondary"><i class="far fa-clock me-1"></i> Mới cập nhật</span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="modal fade" id="optionModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header d-flex flex-column align-items-center pb-0">
        <div class="card-icon mb-2" style="background:#fff3cd; color:#ffc107;"><i class="fas fa-rocket"></i></div>
        <h5 class="modal-title fw-bold text-center" id="modalExamTitle">Tên Đề Thi</h5>
      </div>
      <div class="modal-body text-center pt-3">
        <p class="text-muted mb-4">Bạn đã sẵn sàng chinh phục bài thi này chưa?</p>
        <div class="d-grid gap-3">
            <a id="btnStartExam" href="#" class="btn btn-custom btn-do-exam fs-5"><i class="fas fa-pencil-alt me-2"></i> Bắt đầu làm bài</a>
            <a id="btnLeaderboard" href="#" class="btn btn-custom btn-leaderboard"><i class="fas fa-trophy me-2"></i> Xem bảng xếp hạng</a>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openOptionModal(id, title, fileName) {
        document.getElementById('modalExamTitle').innerText = title;
        document.getElementById('btnStartExam').href = "do-exam?id=" + id + "&file=" + fileName;
        document.getElementById('btnLeaderboard').href = "leaderboard?id=" + id;
        new bootstrap.Modal(document.getElementById('optionModal')).show();
    }
</script>
</body>
</html>