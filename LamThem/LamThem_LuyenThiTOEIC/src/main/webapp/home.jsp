<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Luyện thi TOEIC - Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .exam-card { cursor: pointer; transition: transform 0.2s; }
        .exam-card:hover { transform: scale(1.05); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">📚 TOEIC System</a>
        
        <div class="d-flex align-items-center">
            <span class="text-white me-3">
                Xin chào, <strong>${not empty sessionScope.sessionUser.username ? sessionScope.sessionUser.username : 'Học viên'}</strong>!
            </span>
            
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm fw-bold">
                🚪 Đăng xuất
            </a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center mb-4">Thư viện đề thi</h2>
    
    <div class="row">
        <c:if test="${empty listExams}">
            <div class="alert alert-warning text-center">Chưa có đề thi nào trong hệ thống.</div>
        </c:if>

        <c:forEach items="${listExams}" var="o">
            <div class="col-md-4 mb-4">
                <div class="card exam-card" onclick="openOptionModal(${o.examId}, '${o.title}', '${o.fileName}')">
                    <div class="card-body">
                        <h5 class="card-title text-primary">${o.title}</h5>
                        <p class="card-text text-muted">${o.description}</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="modal fade" id="optionModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalExamTitle">Chọn thao tác</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <div class="d-grid gap-2 col-8 mx-auto">
            <a id="btnStartExam" href="#" class="btn btn-success btn-lg">📝 Làm bài thi</a>
            <a id="btnLeaderboard" href="#" class="btn btn-warning btn-lg text-white">🏆 Bảng xếp hạng</a>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openOptionModal(id, title, fileName) {
        document.getElementById('modalExamTitle').innerText = title;
        
        // Truyền cả ID và fileName sang trang làm bài
        // Trang do-exam sẽ dùng fileName để đọc file JSON trong thư mục assets
        document.getElementById('btnStartExam').href = "do-exam?id=" + id + "&file=" + fileName;
        document.getElementById('btnLeaderboard').href = "leaderboard?id=" + id;
        
        var myModal = new bootstrap.Modal(document.getElementById('optionModal'));
        myModal.show();
    }
</script>

</body>
</html>