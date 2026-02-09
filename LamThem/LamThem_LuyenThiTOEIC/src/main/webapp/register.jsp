<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - JulianToeic Lab</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Sử dụng lại style của Login để đồng bộ */
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        :root {
            --primary-bg: #0f2027;
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
            --neon-blue: #00E5FF;
            --text-color: #ffffff;
        }

        body {
            margin: 0; padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(200deg, #0f2027, #203a43, #2c5364);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            height: 100vh; display: flex; justify-content: center; align-items: center;
            color: var(--text-color); overflow: hidden;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; } 50% { background-position: 100% 50%; } 100% { background-position: 0% 50%; }
        }

        .orb { position: absolute; border-radius: 50%; filter: blur(80px); z-index: -1; opacity: 0.6; }
        .orb-1 { width: 300px; height: 300px; background: #00E5FF; top: -50px; left: -50px; }
        .orb-2 { width: 250px; height: 250px; background: #7b4397; bottom: -50px; right: -50px; }

        .card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px); -webkit-backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            padding: 50px 40px; border-radius: 20px;
            width: 100%; max-width: 380px; text-align: center;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            transition: transform 0.3s;
        }
        .card:hover { transform: translateY(-5px); }

        .card h2 { font-size: 28px; font-weight: 600; margin-bottom: 5px; letter-spacing: 1px; text-shadow: 0 0 10px rgba(0, 229, 255, 0.5); }
        .card p { font-size: 13px; opacity: 0.7; margin-bottom: 30px; font-weight: 300; }

        .input-group { position: relative; margin-bottom: 25px; text-align: left; }
        .input-group i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--neon-blue); font-size: 18px; }
        .input-group input {
            width: 100%; padding: 15px 15px 15px 45px;
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid transparent; border-radius: 50px;
            color: #fff; font-size: 15px; font-family: 'Poppins', sans-serif;
            box-sizing: border-box; outline: none; transition: 0.3s;
        }
        .input-group input::placeholder { color: rgba(255, 255, 255, 0.5); }
        .input-group input:focus { border-color: var(--neon-blue); box-shadow: 0 0 15px rgba(0, 229, 255, 0.3); background: rgba(255, 255, 255, 0.15); }

        .btn {
            width: 100%; padding: 15px; background: linear-gradient(90deg, #00E5FF, #0072ff);
            border: none; border-radius: 50px; color: #fff;
            font-size: 16px; font-weight: 600; text-transform: uppercase;
            cursor: pointer; transition: 0.3s; box-shadow: 0 5px 15px rgba(0, 229, 255, 0.3); margin-top: 10px;
        }
        .btn:hover { background: linear-gradient(90deg, #0072ff, #00E5FF); box-shadow: 0 0 25px rgba(0, 229, 255, 0.6); transform: scale(1.02); }

        .link { margin-top: 25px; font-size: 14px; }
        .link a { color: var(--neon-blue); text-decoration: none; font-weight: 600; transition: 0.3s; }
        .link a:hover { text-shadow: 0 0 10px var(--neon-blue); text-decoration: underline; }

        .msg { display: none; padding: 12px; border-radius: 10px; margin-bottom: 20px; font-size: 13px; animation: fadeIn 0.5s ease; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
        .error { background: rgba(231, 76, 60, 0.2); border: 1px solid #e74c3c; color: #e74c3c; }

    </style>
</head>
<body>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="card">
        <h2>JulianToeic Lab</h2>
        <p>Create new account</p>

        <div id="errMsg" class="msg error"><i class="fas fa-exclamation-triangle"></i> <span id="errText">Lỗi!</span></div>

        <form action="RegisterServlet" method="POST">
            <div class="input-group">
                <i class="fas fa-id-card"></i>
                <input type="text" name="fullName" placeholder="Full Name" required autocomplete="off">
            </div>

            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" name="username" placeholder="Username" required autocomplete="off">
            </div>

            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="Password" required>
            </div>

            <button type="submit" class="btn">Đăng Ký</button>
        </form>

        <div class="link">
            Đã có tài khoản? <a href="login.jsp">Đăng nhập</a>
        </div>
    </div>

    <script>
        const p = new URLSearchParams(window.location.search);
        const errDiv = document.getElementById('errMsg');
        const errTxt = document.getElementById('errText');
        const errType = p.get('error');

        if (errType) {
            errDiv.style.display = 'block';
            if (errType === 'admin') errTxt.innerText = 'Không thể dùng tên "admin"!';
            else if (errType === 'failed') errTxt.innerText = 'Tên đăng nhập đã tồn tại!';
            
            setTimeout(() => { errDiv.style.opacity = '0'; setTimeout(()=>errDiv.style.display='none', 1000); }, 5000);
        }
    </script>
</body>
</html>