<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">⚙️ TOEIC Admin Dashboard</a>
        <div>
            <span class="text-white me-3">Xin chào, Admin <strong>${sessionScope.sessionUser.username}</strong></span>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm me-2">Trang User</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">Đăng xuất</a>
        </div>
    </div>
</nav>

<div class="container-fluid px-5">
    <c:if test="${not empty message || not empty sessionScope.message}">
        <div class="alert alert-${not empty msgType ? msgType : sessionScope.msgType} alert-dismissible fade show">
            ${not empty message ? message : sessionScope.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="message" scope="session"/>
        <c:remove var="msgType" scope="session"/>
    </c:if>

    <ul class="nav nav-tabs mb-4" id="adminTabs" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active fw-bold fs-5" id="exam-tab" data-bs-toggle="tab" data-bs-target="#exam-pane" type="button" role="tab">📚 Quản lý Đề Thi</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link fw-bold fs-5" id="user-tab" data-bs-toggle="tab" data-bs-target="#user-pane" type="button" role="tab">👥 Quản lý Người Dùng</button>
      </li>
    </ul>

    <div class="tab-content" id="adminTabsContent">
      
      <div class="tab-pane fade show active" id="exam-pane" role="tabpanel" aria-labelledby="exam-tab">
          <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-primary text-white"><h5 class="mb-0">Thêm đề thi mới</h5></div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/upload-exam" method="POST" enctype="multipart/form-data">
                            <div class="mb-3"><label class="form-label fw-bold">Tên đề thi</label>
                                <input type="text" name="title" class="form-control" required></div>
                            <div class="mb-3"><label class="form-label fw-bold">Mô tả ngắn</label>
                                <textarea name="description" class="form-control" rows="3" required></textarea></div>
                            <div class="mb-4"><label class="form-label fw-bold">File JSON</label>
                                <input type="file" name="examFile" class="form-control" accept=".json" required></div>
                            <div class="d-grid"><button type="submit" class="btn btn-success">💾 Tải lên</button></div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-white"><h5 class="mb-0">Danh sách đề thi</h5></div>
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr><th>ID</th><th>Tên đề</th><th>File JSON</th><th class="text-center">Hành động</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listExams}" var="o">
                                    <tr>
                                        <td>${o.examId}</td>
                                        <td><strong>${o.title}</strong><br><small class="text-muted">${o.description}</small></td>
                                        <td><span class="badge bg-secondary">${o.fileName}</span></td>
                                        <td class="text-center">
                                            <button class="btn btn-warning btn-sm" onclick="openEditExamModal(${o.examId}, '${o.title}', '${o.description}')">✏️</button>
                                            <a href="${pageContext.request.contextPath}/admin/delete-exam?id=${o.examId}" class="btn btn-danger btn-sm" onclick="return confirm('Xóa đề ${o.title}?');">🗑️</a>
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

      <div class="tab-pane fade" id="user-pane" role="tabpanel" aria-labelledby="user-tab">
          <div class="card shadow-sm">
              <div class="card-header bg-info text-dark d-flex justify-content-between align-items-center">
                  <h5 class="mb-0">Danh sách Tài khoản Hệ thống</h5>
                  <button class="btn btn-primary btn-sm fw-bold" data-bs-toggle="modal" data-bs-target="#addUserModal">+ Thêm User mới</button>
              </div>
              <div class="card-body p-0">
                  <table class="table table-hover mb-0">
                      <thead class="table-light">
                          <tr>
                              <th>ID</th>
                              <th>Tài khoản (Username)</th>
                              <th>Họ và Tên</th>
                              <th>Quyền (Role)</th>
                              <th class="text-center">Hành động</th>
                          </tr>
                      </thead>
                      <tbody>
                          <c:forEach items="${listUsers}" var="u">
                              <tr>
                                  <td>${u.userId}</td>
                                  <td><strong>${u.username}</strong></td>
                                  <td>${u.fullName}</td>
                                  <td>
                                      <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-success'}">${u.role}</span>
                                  </td>
                                  <td class="text-center">
                                      <button class="btn btn-warning btn-sm" onclick="openEditUserModal(${u.userId}, '${u.fullName}', '${u.role}')">✏️ Sửa</button>
                                      <a href="${pageContext.request.contextPath}/admin/delete-user?id=${u.userId}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa user [${u.username}] không?');">🗑️ Xóa</a>
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

<div class="modal fade" id="editExamModal" tabindex="-1">
  <div class="modal-dialog"><div class="modal-content">
      <form action="${pageContext.request.contextPath}/admin/edit-exam" method="POST">
          <div class="modal-header bg-warning"><h5 class="modal-title">Sửa Đề Thi</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
          <div class="modal-body">
            <input type="hidden" name="examId" id="editExamId">
            <div class="mb-3"><label>Tên đề</label><input type="text" name="title" id="editExamTitle" class="form-control" required></div>
            <div class="mb-3"><label>Mô tả</label><textarea name="description" id="editExamDesc" class="form-control" rows="3" required></textarea></div>
          </div>
          <div class="modal-footer"><button type="submit" class="btn btn-primary">Lưu</button></div>
      </form>
  </div></div>
</div>

<div class="modal fade" id="addUserModal" tabindex="-1">
  <div class="modal-dialog"><div class="modal-content">
      <form action="${pageContext.request.contextPath}/admin/add-user" method="POST">
          <div class="modal-header bg-primary text-white"><h5 class="modal-title">Thêm Tài Khoản Mới</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
          <div class="modal-body">
            <div class="mb-3"><label>Tên đăng nhập (Username)</label><input type="text" name="username" class="form-control" required></div>
            <div class="mb-3"><label>Mật khẩu</label><input type="password" name="password" class="form-control" required></div>
            <div class="mb-3"><label>Họ và Tên</label><input type="text" name="fullName" class="form-control" required></div>
            <div class="mb-3">
                <label>Quyền (Role)</label>
                <select name="role" class="form-select">
                    <option value="USER">USER</option>
                    <option value="ADMIN">ADMIN</option>
                </select>
            </div>
          </div>
          <div class="modal-footer"><button type="submit" class="btn btn-success">Tạo tài khoản</button></div>
      </form>
  </div></div>
</div>

<div class="modal fade" id="editUserModal" tabindex="-1">
  <div class="modal-dialog"><div class="modal-content">
      <form action="${pageContext.request.contextPath}/admin/edit-user" method="POST">
          <div class="modal-header bg-warning"><h5 class="modal-title">Cập nhật thông tin User</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
          <div class="modal-body">
            <input type="hidden" name="userId" id="editUserId">
            <div class="mb-3"><label>Họ và Tên</label><input type="text" name="fullName" id="editUserFullName" class="form-control" required></div>
            <div class="mb-3">
                <label>Quyền (Role)</label>
                <select name="role" id="editUserRole" class="form-select">
                    <option value="USER">USER</option>
                    <option value="ADMIN">ADMIN</option>
                </select>
            </div>
          </div>
          <div class="modal-footer"><button type="submit" class="btn btn-primary">Lưu thay đổi</button></div>
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

    // Giữ nguyên trạng thái Tab sau khi reload trang (Tránh việc submit form User xong lại nhảy về tab Exam)
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