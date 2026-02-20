<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Quản lý đề thi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">⚙️ TOEIC Admin Dashboard</a>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm">Xem trang User</a>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            
            <c:if test="${not empty message}">
                <div class="alert alert-${msgType} alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Thêm đề thi mới (Upload JSON)</h5>
                </div>
                <div class="card-body">
                    <form action="upload-exam" method="POST" enctype="multipart/form-data">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên đề thi</label>
                            <input type="text" name="title" class="form-control" placeholder="VD: ETS 2026 - Test 02" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả ngắn</label>
                            <textarea name="description" class="form-control" rows="3" placeholder="Mô tả nội dung đề thi..." required></textarea>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold">Chọn file JSON dữ liệu</label>
                            <input type="file" name="examFile" class="form-control" accept=".json" required>
                            <div class="form-text text-danger">Chỉ chấp nhận file có đuôi .json được cấu trúc đúng chuẩn.</div>
                        </div>
                        
                        <div class="d-grid">
                            <button type="submit" class="btn btn-success btn-lg">💾 Tải lên và Lưu trữ</button>
                        </div>
                        
                    </form>
                </div>
            </div>
            
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>