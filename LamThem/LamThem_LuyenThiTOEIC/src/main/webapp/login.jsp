<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - JulianToeic Lab</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        :root {
            --primary-bg: #0f2027;
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
            --neon-blue: #00E5FF;
            --neon-glow: 0 0 10px #00E5FF, 0 0 20px #00E5FF;
            --text-color: #ffffff;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(200deg, #0f2027, #203a43, #2c5364);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--text-color);
            overflow: hidden;
        }

        /* Hiệu ứng nền chuyển động */
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Các hạt bụi vũ trụ trang trí */
        .orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            z-index: -1;
            opacity: 0.6;
        }
        .orb-1 { width: 300px; height: 300px; background: #00E5FF; top: -50px; left: -50px; }
        .orb-2 { width: 250px; height: 250px; background: #7b4397; bottom: -50px; right: -50px; }

        .card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            padding: 50px 40px;
            border-radius: 20px;
            width: 100%;
            max-width: 380px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h2 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 5px;
            letter-spacing: 1px;
            text-shadow: 0 0 10px rgba(0, 229, 255, 0.5);
        }

        .card p {
            font-size: 13px;
            opacity: 0.7;
            margin-bottom: 30px;
            font-weight: 300;
        }

        /* Input Styles */
        .input-group {
            position: relative;
            margin-bottom: 25px;
            text-align: left;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--neon-blue);
            font-size: 18px;
            transition: 0.3s;
        }

        .input-group input {
            width: 100%;
            padding: 15px 15px 15px 45px;
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid transparent;
            border-radius: 50px; /* Bo tròn kiểu viên thuốc */
            color: #fff;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
            outline: none;
            transition: 0.3s;
        }

        .input-group input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .input-group input:focus {
            border-color: var(--neon-blue);
            box-shadow: 0 0 15px rgba(0, 229, 255, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }

        /* Button Style */
        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(90deg, #00E5FF, #0072ff);
            border: none;
            border-radius: 50px;
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 5px 15px rgba(0, 229, 255, 0.3);
            margin-top: 10px;
        }

        .btn:hover {
            background: linear-gradient(90deg, #0072ff, #00E5FF);
            box-shadow: 0 0 25px rgba(0, 229, 255, 0.6);
            transform: scale(1.02);
        }

        /* Link Style */
        .link {
            margin-top: 25px;
            font-size: 14px;
        }

        .link a {
            color: var(--neon-blue);
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .link a:hover {
            text-shadow: 0 0 10px var(--neon-blue);
            text-decoration: underline;
        }

        /* Thông báo */
        .msg {
            display: none;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 13px;
            animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        .success { background: rgba(46, 204, 113, 0.2); border: 1px solid #2ecc71; color: #2ecc71; }
        .error { background: rgba(231, 76, 60, 0.2); border: 1px solid #e74c3c; color: #e74c3c; }

    </style>
</head>
<body>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="card">
        <h2>JulianToeic Lab</h2>
        <p>Login to your account</p>

        <div id="sMsg" class="msg success"><i class="fas fa-check-circle"></i> Đăng ký thành công! Hãy đăng nhập.</div>
        <div id="eMsg" class="msg error"><i class="fas fa-exclamation-circle"></i> Sai tài khoản hoặc mật khẩu!</div>

        <form action="LoginServlet" method="POST">
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" name="username" placeholder="Username" required autocomplete="off">
            </div>

            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="Password" required>
            </div>

            <button type="submit" class="btn">Đăng Nhập</button>
        </form>

        <div class="link">
            Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a>
        </div>
    </div>

    <script>
        const p = new URLSearchParams(window.location.search);
        const s = document.getElementById('sMsg');
        const e = document.getElementById('eMsg');
        
        if (p.has('registerSuccess')) {
            s.style.display = 'block';
            setTimeout(() => { s.style.opacity = '0'; setTimeout(()=>s.style.display='none', 1000); }, 5000);
        }
        if (p.get('error') === 'invalid') {
            e.style.display = 'block';
            setTimeout(() => { e.style.opacity = '0'; setTimeout(()=>e.style.display='none', 1000); }, 5000);
        }
    </script>
</body>
</html>