<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - JulianToeic Lab</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Tái sử dụng CSS của file login.jsp ở trên */
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7fa; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-wrapper { background: #ffffff; padding: 50px 40px; border-radius: 24px; box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05); width: 100%; max-width: 400px; text-align: center; }
        .logo-icon { font-size: 40px; margin-bottom: 15px; background: linear-gradient(135deg, #00E5FF, #0072ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        h2 { font-weight: 700; color: #2c3e50; margin-bottom: 5px; }
        p { color: #8392a5; font-size: 14px; margin-bottom: 30px; }
        .input-group { position: relative; margin-bottom: 20px; }
        .input-group i { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: #a0aec0; }
        .input-group input { width: 100%; padding: 15px 15px 15px 50px; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; font-family: 'Poppins', sans-serif; font-size: 14px; color: #2d3748; outline: none; transition: 0.3s; box-sizing: border-box; }
        .input-group input:focus { border-color: #0072ff; background: #fff; box-shadow: 0 0 0 4px rgba(0, 114, 255, 0.1); }
        .btn-login { width: 100%; padding: 15px; border: none; border-radius: 12px; background: linear-gradient(135deg, #00E5FF, #0072ff); color: #fff; font-size: 16px; font-weight: 600; cursor: pointer; transition: 0.3s; box-shadow: 0 8px 20px rgba(0, 114, 255, 0.2); margin-top: 10px; }
        .btn-login:hover { transform: translateY(-2px); box-shadow: 0 12px 25px rgba(0, 114, 255, 0.3); }
        .link { margin-top: 25px; font-size: 14px; color: #718096; }
        .link a { color: #0072ff; text-decoration: none; font-weight: 600; }
        .link a:hover { text-decoration: underline; }
        .msg { padding: 12px; border-radius: 10px; margin-bottom: 20px; font-size: 13px; display: none; }
        .error { background: #f8d7da; color: #842029; }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <div class="logo-icon"><i class="fas fa-user-plus"></i></div>
        <h2>Tạo tài khoản mới</h2>
        <p>Tham gia JulianToeic Lab ngay hôm nay</p>

        <div id="errMsg" class="msg error"><i class="fas fa-exclamation-triangle"></i> <span id="errText">Lỗi!</span></div>

        <form action="RegisterServlet" method="POST">
            <div class="input-group">
                <input type="text" name="fullName" placeholder="Họ và Tên" required autocomplete="off">
                <i class="fas fa-id-card"></i>
            </div>
            <div class="input-group">
                <input type="text" name="username" placeholder="Tên đăng nhập" required autocomplete="off">
                <i class="fas fa-user"></i>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Mật khẩu" required>
                <i class="fas fa-lock"></i>
            </div>
            <button type="submit" class="btn-login">Đăng Ký</button>
        </form>

        <div class="link">Đã có tài khoản? <a href="login.jsp">Đăng nhập</a></div>
    </div>

    <script>
        const p = new URLSearchParams(window.location.search);
        const errType = p.get('error');
        if (errType) {
            document.getElementById('errMsg').style.display = 'block';
            if (errType === 'admin') document.getElementById('errText').innerText = 'Không thể dùng tên "admin"!';
            else if (errType === 'failed') document.getElementById('errText').innerText = 'Tên đăng nhập đã tồn tại!';
        }
    </script>
</body>
</html>