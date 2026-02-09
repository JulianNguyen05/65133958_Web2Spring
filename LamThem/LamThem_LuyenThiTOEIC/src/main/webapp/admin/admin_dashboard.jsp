<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    toeic.model.User user = (toeic.model.User) session.getAttribute("sessionUser");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - JulianToeic</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        :root {
            --primary-bg: #0f2027;
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
            --neon-blue: #00E5FF;
            --neon-purple: #bd34fe;
            --text-color: #ffffff;
            --success: #2ecc71;
        }

        body {
            margin: 0; padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(200deg, #0f2027, #203a43, #2c5364);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            min-height: 100vh;
            color: var(--text-color);
        }

        @keyframes gradientBG { 0% { background-position: 0% 50%; } 50% { background-position: 100% 50%; } 100% { background-position: 0% 50%; } }

        /* Navbar Glass */
        .navbar {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--glass-border);
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo { font-size: 24px; font-weight: 600; color: var(--neon-blue); letter-spacing: 1px; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .logout-btn {
            color: #ff4757; text-decoration: none; font-weight: 600;
            border: 1px solid #ff4757; padding: 8px 20px; border-radius: 30px;
            transition: 0.3s;
        }
        .logout-btn:hover { background: #ff4757; color: white; box-shadow: 0 0 15px rgba(255, 71, 87, 0.5); }

        /* Container chính */
        .container { padding: 50px; max-width: 1200px; margin: 0 auto; }

        /* Grid Layout */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }

        /* Card Glass Style */
        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 30px;
            transition: 0.3s;
            position: relative;
            overflow: hidden;
        }
        .glass-card:hover { transform: translateY(-5px); box-shadow: 0 10px 30px rgba(0,0,0,0.3); border-color: var(--neon-blue); }

        .glass-card h3 { margin-top: 0; color: var(--neon-blue); font-size: 20px; }
        .glass-card p { opacity: 0.7; font-size: 14px; margin-bottom: 25px; }

        /* Icon lớn trang trí trong card */
        .card-icon {
            position: absolute; bottom: -20px; right: -20px;
            font-size: 100px; opacity: 0.05; color: white;
        }

        /* Upload Zone Style */
        .upload-area {
            border: 2px dashed rgba(255,255,255,0.2);
            border-radius: 15px;
            padding: 40px 20px;
            text-align: center;
            cursor: pointer;
            transition: 0.3s;
            margin-bottom: 20px;
        }
        .upload-area:hover { border-color: var(--neon-blue); background: rgba(0, 229, 255, 0.05); }
        .upload-area i { font-size: 40px; color: var(--neon-blue); margin-bottom: 10px; }
        
        /* Custom File Input */
        input[type="file"] { display: none; }
        
        .btn-action {
            width: 100%; padding: 12px;
            background: linear-gradient(90deg, #00E5FF, #0072ff);
            border: none; border-radius: 10px; color: white; font-weight: 600; cursor: pointer;
            transition: 0.3s;
        }
        .btn-action:hover { box-shadow: 0 0 20px rgba(0, 229, 255, 0.4); }

        /* Thống kê số liệu */
        .stat-number { font-size: 48px; font-weight: 600; color: white; margin: 10px 0; }
        .stat-label { color: var(--success); font-size: 14px; }

    </style>
</head>
<body>

    <nav class="navbar">
        <div class="logo"><i class="fas fa-rocket"></i> JulianLab Admin</div>
        <div class="user-info">
            <span>Xin chào, <b><%= user.getFullName() %></b></span>
            <a href="login.jsp" class="logout-btn">Đăng xuất</a>
        </div>
    </nav>

    <div class="container">
        <h2 style="margin-bottom: 30px; font-weight: 300;">Tổng quan hệ thống</h2>
        
        <div class="dashboard-grid">
            
            <div class="glass-card" style="grid-column: span 2;">
                <h3><i class="fas fa-cloud-upload-alt"></i> Nạp Ngân Hàng Đề Thi</h3>
                <p>Upload file JSON chứa danh sách câu hỏi để cập nhật vào Database.</p>
                <i class="fas fa-database card-icon"></i>

                <form action="UploadQuestionServlet" method="post" enctype="multipart/form-data">
                    <label for="fileInput" class="upload-area">
                        <i class="fas fa-file-code"></i>
                        <div id="fileName">Nhấn để chọn file JSON...</div>
                    </label>
                    <input type="file" id="fileInput" name="file" accept=".json" required onchange="updateFileName(this)">
                    
                    <button type="submit" class="btn-action">
                        <i class="fas fa-bolt"></i> BẮT ĐẦU NẠP DỮ LIỆU
                    </button>
                </form>
            </div>

            <div class="glass-card">
                <h3>Thành viên</h3>
                <div class="stat-number">1,254</div>
                <div class="stat-label"><i class="fas fa-arrow-up"></i> +12 hôm nay</div>
                <i class="fas fa-users card-icon"></i>
            </div>

            <div class="glass-card">
                <h3>Câu hỏi trong kho</h3>
                <div class="stat-number">500</div>
                <div class="stat-label" style="color: var(--neon-blue);">Sẵn sàng thi</div>
                <i class="fas fa-layer-group card-icon"></i>
            </div>

        </div>
    </div>

    <script>
        // Hàm hiển thị tên file khi chọn
        function updateFileName(input) {
            const fileNameDiv = document.getElementById('fileName');
            if (input.files && input.files.length > 0) {
                fileNameDiv.innerHTML = "Đã chọn: <b style='color: #00E5FF'>" + input.files[0].name + "</b>";
                fileNameDiv.parentElement.style.borderColor = "#00E5FF";
            }
        }
    </script>

</body>
</html>