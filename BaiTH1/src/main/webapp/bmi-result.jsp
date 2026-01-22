<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kết quả BMI</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <div class="form-card">
        <div class="result-circle ${statusClass}">
            <span class="bmi-number">${bmi}</span>
            <span class="bmi-label">Chỉ số BMI</span>
        </div>

        <h2 class="status-text ${statusClass}">${statusText}</h2>
        <p class="advice-text">${advice}</p>

        <a href="BMI" class="btn-calculate" style="display: block; text-decoration: none; margin-top: 30px; background: rgba(255,255,255,0.1);">
            <i class="fas fa-redo"></i> Tính lại
        </a>
    </div>

</body>
</html>