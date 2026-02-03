<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tính Tổng Hai Số</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h4 class="mb-0">MÁY TÍNH CỘNG (JSP)</h4>
                    </div>
                    <div class="card-body">

                        <%
                            // Khai báo biến để lưu giá trị người dùng nhập (để hiện lại vào ô input)
                            String valA = request.getParameter("a");
                            String valB = request.getParameter("b");
                            
                            String ketQua = "";

                            if (valA != null && valB != null) {
                                try {
                                    int a = Integer.parseInt(valA);
                                    int b = Integer.parseInt(valB);
                                    int tong = a + b;

                                    ketQua = "<div class='alert alert-success text-center'>" +
                                                 "Kết quả: <b>" + a + " + " + b + " = " + tong + "</b>" +
                                                 "</div>";
                                } catch (NumberFormatException e) {
                                    ketQua = "<div class='alert alert-danger text-center'>Vui lòng nhập số nguyên hợp lệ!</div>";
                                }
                            }
                            
                            if (valA == null) valA = "";
                            if (valB == null) valB = "";
                        %>

                        <%= ketQua %>

                        <form action="sum.jsp" method="post">
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Số A:</label>
                                <input type="number" class="form-control" name="a" value="<%= valA %>" placeholder="Nhập số thứ nhất" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Số B:</label>
                                <input type="number" class="form-control" name="b" value="<%= valB %>" placeholder="Nhập số thứ hai" required>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">TÍNH TỔNG</button>
                            </div>
                            
                            <div class="text-center mt-3">
                                <a href="sum.jsp" class="text-decoration-none text-secondary">Làm mới</a>
                            </div>

                        </form>
                    </div>
                </div>
                
            </div>
        </div>
    </div>

</body>
</html>