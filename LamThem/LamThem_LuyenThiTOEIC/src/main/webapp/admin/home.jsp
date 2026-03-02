<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - JulianToeic Lab</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* CSS Dùng chung cho toàn hệ thống */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7fa; /* Màu nền xám xanh siêu nhạt, dịu mắt */
            color: #2c3e50;
        }

        /* Navbar hiện đại với dải màu Gradient */
        .navbar-custom {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364); /* Tone màu giống trang Login */
            padding: 15px 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .navbar-brand { font-weight: 700; font-size: 1.5rem; letter-spacing: 1px; color: #00E5FF !important; }
        
        /* Hiệu ứng Thẻ (Card) */
        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.04);
            transition: all 0.3s ease;
            overflow: hidden;
            margin-bottom: 25px;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.1);
        }
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #f0f0f0;
            padding: 20px 25px;
            font-weight: 600;
        }
        
        /* Cải tiến các tab Bootstrap */
        .nav-tabs { border-bottom: none; margin-bottom: 20px; gap: 10px; }
        .nav-tabs .nav-link {
            border: none;
            color: #6c757d;
            font-weight: 600;
            border-radius: 50px;
            padding: 10px 25px;
            transition: 0.3s;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .nav-tabs .nav-link:hover { color: #00E5FF; background: #203a43; }
        .nav-tabs .nav-link.active {
            color: #fff;
            background: linear-gradient(90deg, #00E5FF, #0072ff);
            box-shadow: 0 5px 15px rgba(0, 229, 255, 0.3);
        }

        /* Bảng dữ liệu hiện đại */
        .table { vertical-align: middle; margin-bottom: 0; }
        .table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #edf2f9;
            color: #6e84a3;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            padding: 15px;
        }
        .table tbody td { padding: 15px; border-bottom: 1px solid #edf2f9; }
        
        /* Nút bấm */
        .btn { border-radius: 8px; font-weight: 500; transition: 0.3s; padding: 8px 20px; }
        .btn-success { background: #2ecc71; border: none; }
        .btn-success:hover { background: #27ae60; transform: translateY(-2px); box-shadow: 0 5px 10px rgba(46,204,113,0.3); }
        .btn-primary { background: linear-gradient(90deg, #00E5FF, #0072ff); border: none; }
        .btn-primary:hover { opacity: 0.9; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0, 229, 255, 0.3); }
        .btn-danger { background: #ff4757; border: none; }
        .btn-warning { background: #ffa502; border: none; color: white; }
        
        /* Input & Form */
        .form-control, .form-select { border-radius: 10px; padding: 12px 15px; border: 1px solid #e1e5eb; background-color: #f8f9fa; }
        .form-control:focus, .form-select:focus { border-color: #00E5FF; box-shadow: 0 0 0 0.2rem rgba(0, 229, 255, 0.25); background-color: #fff; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid px-5">
        <a class="navbar-brand" href="#"><i class="fas fa-graduation-cap me-2"></i> JulianToeic Lab</a>
        <div class="d-flex align-items-center">
            <div class="text-white me-4">
                <img src="https://ui-avatars.com/api/?name=${sessionScope.sessionUser.username}&background=00E5FF&color=fff&rounded=true" alt="avatar" width="35" class="me-2 shadow-sm">
                Xin chào, <strong class="fs-6">${sessionScope.sessionUser.username}</strong>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm me-2 rounded-pill px-3"><i class="fas fa-eye"></i> Xem giao diện User</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-pill px-3"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>
</nav>

<div class="container-fluid px-5 mt-4">
    <c:if test="${not empty message || not empty sessionScope.message}">
        <div class="alert alert-${not empty msgType ? msgType : sessionScope.msgType} alert-dismissible fade show border-0 shadow-sm rounded-4 text-center fw-bold">
            <i class="fas fa-info-circle me-2"></i> ${not empty message ? message : sessionScope.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="message" scope="session"/>
        <c:remove var="msgType" scope="session"/>
    </c:if>

    <ul class="nav nav-tabs justify-content-center" id="adminTabs" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="exam-tab" data-bs-toggle="tab" data-bs-target="#exam-pane" type="button" role="tab">
            <i class="fas fa-book-open me-2"></i> Quản lý Đề Thi
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="user-tab" data-bs-toggle="tab" data-bs-target="#user-pane" type="button" role="tab">
            <i class="fas fa-users me-2"></i> Quản lý Người Dùng
        </button>
      </li>
    </ul>

    <div class="tab-content mt-4" id="adminTabsContent">
      
      <div class="tab-pane fade show active" id="exam-pane" role="tabpanel">
          <div class="row">
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-header border-0 pb-0 pt-4 bg-transparent text-primary fs-5"><i class="fas fa-plus-circle me-2"></i> Thêm đề thi mới</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/upload-exam" method="POST" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold small">Tên đề thi</label>
                                <input type="text" name="title" class="form-control" placeholder="Nhập tên đề..." required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold small">Mô tả ngắn</label>
                                <textarea name="description" class="form-control" rows="3" placeholder="Mô tả nội dung..." required></textarea>
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-muted fw-bold small">File dữ liệu (JSON)</label>
                                <input type="file" name="examFile" class="form-control" accept=".json" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 py-2"><i class="fas fa-cloud-upload-alt me-2"></i> Tải lên hệ thống</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-8">
                <div class="card h-100">
                    <div class="card-header border-0 pb-0 pt-4 bg-transparent text-primary fs-5"><i class="fas fa-list me-2"></i> Danh sách đề thi</div>
                    <div class="card-body px-0 pb-0">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th class="ps-4">ID</th>
                                        <th>Thông tin đề thi</th>
                                        <th>File JSON</th>
                                        <th class="text-center pe-4">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listExams}" var="o">
                                        <tr>
                                            <td class="ps-4 fw-bold text-muted">#${o.examId}</td>
                                            <td>
                                                <div class="fw-bold text-dark fs-6">${o.title}</div>
                                                <div class="text-muted small mt-1">${o.description}</div>
                                            </td>
                                            <td><span class="badge bg-light text-dark border"><i class="fas fa-file-code me-1 text-primary"></i> ${o.fileName}</span></td>
                                            <td class="text-center pe-4">
                                                <button class="btn btn-warning btn-sm text-white rounded-circle me-1" title="Sửa" onclick="openEditExamModal(${o.examId}, '${o.title}', '${o.description}')"><i class="fas fa-pen"></i></button>
                                                <a href="${pageContext.request.contextPath}/admin/delete-exam?id=${o.examId}" class="btn btn-danger btn-sm rounded-circle" title="Xóa" onclick="return confirm('Xóa đề ${o.title}?');"><i class="fas fa-trash"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
          </div>
      </div>

      <div class="tab-pane fade" id="user-pane" role="tabpanel">
          <div class="card">
              <div class="card-header border-0 pt-4 bg-transparent d-flex justify-content-between align-items-center">
                  <div class="text-primary fs-5 fw-bold"><i class="fas fa-users-cog me-2"></i> Quản lý Tài khoản</div>
                  <button class="btn btn-primary btn-sm rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#addUserModal"><i class="fas fa-user-plus me-1"></i> Thêm User</button>
              </div>
              <div class="card-body px-0 pb-0">
                  <div class="table-responsive">
                      <table class="table table-hover">
                          <thead>
                              <tr>
                                  <th class="ps-4">Học viên</th>
                                  <th>Tài khoản</th>
                                  <th>Phân quyền</th>
                                  <th class="text-center pe-4">Thao tác</th>
                              </tr>
                          </thead>
                          <tbody>
                              <c:forEach items="${listUsers}" var="u">
                                  <tr>
                                      <td class="ps-4">
                                          <div class="d-flex align-items-center">
                                              <img src="https://ui-avatars.com/api/?name=${u.fullName}&background=random&color=fff&rounded=true" width="40" class="me-3">
                                              <div>
                                                  <div class="fw-bold text-dark">${u.fullName}</div>
                                                  <div class="text-muted small">ID: #${u.userId}</div>
                                              </div>
                                          </div>
                                      </td>
                                      <td class="fw-bold text-secondary">@${u.username}</td>
                                      <td>
                                          <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-success'} rounded-pill px-3 py-2"><i class="fas ${u.role == 'ADMIN' ? 'fa-shield-alt' : 'fa-user'} me-1"></i> ${u.role}</span>
                                      </td>
                                      <td class="text-center pe-4">
                                          <button class="btn btn-warning btn-sm text-white rounded-circle me-1" onclick="openEditUserModal(${u.userId}, '${u.fullName}', '${u.role}')"><i class="fas fa-pen"></i></button>
                                          <a href="${pageContext.request.contextPath}/admin/delete-user?id=${u.userId}" class="btn btn-danger btn-sm rounded-circle" onclick="return confirm('Bạn có chắc chắn muốn xóa user [${u.username}] không?');"><i class="fas fa-trash"></i></a>
                                      </td>
                                  </tr>
                              </c:forEach>
                          </tbody>
                      </table>
                  </div>
              </div>
          </div>
      </div>

    </div>
</div>

<style>
    .modal-content { border-radius: 16px; border: none; box-shadow: 0 15px 35px rgba(0,0,0,0.2); }
    .modal-header { border-bottom: 1px solid #f0f0f0; padding: 20px 25px; }
    .modal-footer { border-top: none; padding: 15px 25px 25px; }
</style>

<div class="modal fade" id="editExamModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered"><div class="modal-content">
      <form action="${pageContext.request.contextPath}/admin/edit-exam" method="POST">
          <div class="modal-header">
              <h5 class="modal-title fw-bold text-primary"><i class="fas fa-edit me-2"></i> Cập nhật Đề Thi</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body px-4">
            <input type="hidden" name="examId" id="editExamId">
            <div class="mb-3"><label class="text-muted fw-bold small">Tên đề</label><input type="text" name="title" id="editExamTitle" class="form-control" required></div>
            <div class="mb-3"><label class="text-muted fw-bold small">Mô tả</label><textarea name="description" id="editExamDesc" class="form-control" rows="3" required></textarea></div>
          </div>
          <div class="modal-footer"><button type="submit" class="btn btn-primary w-100 py-2">Lưu thay đổi</button></div>
      </form>
  </div></div>
</div>

<div class="modal fade" id="addUserModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered"><div class="modal-content">
      <form action="${pageContext.request.contextPath}/admin/add-user" method="POST">
          <div class="modal-header">
              <h5 class="modal-title fw-bold text-primary"><i class="fas fa-user-plus me-2"></i> Thêm Tài Khoản</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body px-4">
            <div class="mb-3"><label class="text-muted fw-bold small">Username</label><input type="text" name="username" class="form-control" required></div>
            <div class="mb-3"><label class="text-muted fw-bold small">Mật khẩu</label><input type="password" name="password" class="form-control" required></div>
            <div class="mb-3"><label class="text-muted fw-bold small">Họ và Tên</label><input type="text" name="fullName" class="form-control" required></div>
            <div class="mb-3">
                <label class="text-muted fw-bold small">Phân quyền</label>
                <select name="role" class="form-select">
                    <option value="USER">USER (Học viên)</option>
                    <option value="ADMIN">ADMIN (Quản trị)</option>
                </select>
            </div>
          </div>
          <div class="modal-footer"><button type="submit" class="btn btn-primary w-100 py-2">Tạo tài khoản</button></div>
      </form>
  </div></div>
</div>

<div class="modal fade" id="editUserModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered"><div class="modal-content">
      <form action="${pageContext.request.contextPath}/admin/edit-user" method="POST">
          <div class="modal-header">
              <h5 class="modal-title fw-bold text-primary"><i class="fas fa-user-edit me-2"></i> Cập nhật Học viên</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body px-4">
            <input type="hidden" name="userId" id="editUserId">
            <div class="mb-3"><label class="text-muted fw-bold small">Họ và Tên</label><input type="text" name="fullName" id="editUserFullName" class="form-control" required></div>
            <div class="mb-3">
                <label class="text-muted fw-bold small">Phân quyền</label>
                <select name="role" id="editUserRole" class="form-select">
                    <option value="USER">USER</option>
                    <option value="ADMIN">ADMIN</option>
                </select>
            </div>
          </div>
          <div class="modal-footer"><button type="submit" class="btn btn-primary w-100 py-2">Lưu thay đổi</button></div>
      </form>
  </div></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openEditExamModal(id, title, desc) {
        document.getElementById('editExamId').value = id;
        document.getElementById('editExamTitle').value = title;
        document.getElementById('editExamDesc').value = desc;
        new bootstrap.Modal(document.getElementById('editExamModal')).show();
    }

    function openEditUserModal(id, fullName, role) {
        document.getElementById('editUserId').value = id;
        document.getElementById('editUserFullName').value = fullName;
        document.getElementById('editUserRole').value = role;
        new bootstrap.Modal(document.getElementById('editUserModal')).show();
    }

    // Logic giữ Tab khi tải lại trang
    document.addEventListener("DOMContentLoaded", function() {
        var hash = window.location.hash;
        if (hash) {
            var tab = new bootstrap.Tab(document.querySelector(hash + '-tab'));
            tab.show();
        }
        var tabs = document.querySelectorAll('button[data-bs-toggle="tab"]');
        tabs.forEach(function(tab) {
            tab.addEventListener('shown.bs.tab', function (e) {
                var target = e.target.getAttribute("data-bs-target");
                window.location.hash = target.replace("-pane", "");
            });
        });
    });
</script>
</body>
</html>