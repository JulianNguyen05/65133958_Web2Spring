<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Làm bài thi - ${examTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* GIAO DIỆN CHUẨN TOEIC CBT */
        body { height: 100vh; overflow: hidden; display: flex; flex-direction: column; }
        
        /* 1. Header: Timer và nút điều hướng */
        .exam-header {
            height: 60px; background-color: #f0f2f5; border-bottom: 2px solid #ddd;
            display: flex; align-items: center; justify-content: space-between; padding: 0 20px;
        }
        .timer-box { font-weight: bold; color: #d9534f; font-size: 1.2rem; }

        /* 2. Main Content: Khu vực làm bài */
        .exam-container {
            flex: 1; display: flex; overflow: hidden; /* Quan trọng để chia cột */
        }

        /* Cột trái: Hiển thị đoạn văn (Part 6, 7) */
        .left-pane {
            width: 50%; border-right: 1px solid #ccc; padding: 20px;
            overflow-y: auto; background-color: #fff;
            display: none; /* Mặc định ẩn (cho Part 5) */
        }

        /* Cột phải: Hiển thị câu hỏi */
        .right-pane {
            width: 50%; padding: 20px; overflow-y: auto; background-color: #fafafa;
            flex: 1; /* Tự mở rộng nếu cột trái ẩn */
        }
        
        /* Style cho đoạn văn */
        .reading-passage { font-family: "Times New Roman", serif; font-size: 1.1rem; line-height: 1.6; white-space: pre-wrap; }

        /* Style cho câu hỏi */
        .question-box { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .option-label { display: block; margin: 10px 0; cursor: pointer; padding: 8px; border: 1px solid #eee; border-radius: 5px; }
        .option-label:hover { background-color: #e9ecef; }
        input[type="radio"] { margin-right: 10px; }

        /* Footer điều hướng câu hỏi */
        .exam-footer {
            height: 60px; background: #343a40; color: white;
            display: flex; align-items: center; justify-content: space-between; padding: 0 20px;
        }
    </style>
</head>
<body>

<div class="exam-header">
    <div><strong>TOEIC Reading Test</strong></div>
    <div class="timer-box">⏱ <span id="timeDisplay">75:00</span></div>
    <div><button class="btn btn-outline-primary btn-sm">Mark for Review</button></div>
</div>

<div class="exam-container">
    <div id="leftPane" class="left-pane">
        <div class="alert alert-info">Refer to the following text:</div>
        <div id="passageText" class="reading-passage">
            </div>
    </div>

    <div id="rightPane" class="right-pane">
        <div class="question-box">
            <h5 id="questionNumber">Question 101</h5>
            <p id="questionText" class="lead fw-bold">Loading...</p>
            <div id="optionsArea">
                </div>
        </div>
    </div>
</div>

<div class="exam-footer">
    <button class="btn btn-secondary" onclick="prevQuestion()">⬅ Back</button>
    <span id="progressText">Question 1 of 100</span>
    <button class="btn btn-primary" onclick="nextQuestion()">Next ➡</button>
</div>

<script type="application/json" id="examDataJson">
    ${examData}
</script>

<script>
    var rawData = document.getElementById("examDataJson").textContent; 
    var questions = []; // Mảng chứa toàn bộ câu hỏi sau khi làm phẳng
    var examTitle = "";

    try {
        var examObj = JSON.parse(rawData.trim());
        examTitle = examObj.examTitle;
        
        // Cập nhật tên đề thi lên giao diện (nếu bạn có ID này trên Header)
        // document.getElementById("examTitleDisplay").innerText = examTitle;

        // Vòng lặp 1: Đi vào từng Part (Ví dụ: Part 5, Part 6...)
        if (examObj.parts) {
            examObj.parts.forEach(function(part) {
                
                // Lấy đoạn văn chung của Part (Dành cho Part 6, 7 nếu có)
                var partPassage = part.passage || part.groupText || "";

                // Vòng lặp 2: Đi vào từng câu hỏi của Part đó
                if (part.questions) {
                    part.questions.forEach(function(q) {
                        
                        // Chuyển đổi Object options {A: "...", B: "..."} thành Mảng để dễ hiển thị
                        var optArray = [];
                        if (q.options) {
                            optArray.push({ key: 'A', value: q.options.A });
                            optArray.push({ key: 'B', value: q.options.B });
                            optArray.push({ key: 'C', value: q.options.C });
                            optArray.push({ key: 'D', value: q.options.D });
                        }

                        // Gom tất cả vào mảng chung
                        questions.push({
                            id: q.id,
                            partNumber: part.partNumber,
                            text: q.text,
                            options: optArray,
                            // Ưu tiên đoạn văn của câu hỏi, nếu không có thì lấy đoạn văn chung của Part
                            groupText: q.passage || q.groupText || partPassage, 
                            correctAnswer: q.correct_answer
                        });
                    });
                }
            });
        }
    } catch (e) {
        alert("Lỗi đọc dữ liệu JSON! Hãy kiểm tra Console.");
        console.error(e);
    }

    var currentIndex = 0;
    var userAnswers = {}; // Lưu đáp án người dùng: { 0: 'A', 1: 'C' }

    // Hàm hiển thị câu hỏi
    function renderQuestion() {
        if (!questions || questions.length === 0 || !questions[currentIndex]) {
            document.getElementById("questionText").innerText = "Chưa load được dữ liệu câu hỏi.";
            return; 
        }

        var q = questions[currentIndex];
        
        // Cập nhật UI
        document.getElementById("questionNumber").innerText = "Question " + q.id;
        document.getElementById("progressText").innerText = "Question " + (currentIndex + 1) + " of " + questions.length;
        
        var leftPane = document.getElementById("leftPane");
        var rightPane = document.getElementById("rightPane");
        var passageDiv = document.getElementById("passageText");

        // Xử lý chia đôi màn hình cho Part có đoạn văn
        if (q.groupText && q.groupText.trim() !== "") {
            leftPane.style.display = "block";
            rightPane.style.width = "50%";
            passageDiv.innerText = q.groupText;
        } else {
            leftPane.style.display = "none";
            rightPane.style.width = "100%";
        }

        document.getElementById("questionText").innerText = q.text;

        // Xử lý hiển thị đáp án (A, B, C, D) từ mảng mới
        var optionsHtml = "";
        q.options.forEach(function(opt) {
            var isChecked = userAnswers[currentIndex] === opt.key ? "checked" : "";
            
            // Dùng dấu cộng nối chuỗi để tránh xung đột với JSP
            optionsHtml += '<label class="option-label">' +
                               '<input type="radio" name="answer" value="' + opt.key + '" onclick="saveAnswer(\'' + opt.key + '\')" ' + isChecked + '> ' +
                               '<b>' + opt.key + '.</b> ' + opt.value +
                           '</label>';
        });
        document.getElementById("optionsArea").innerHTML = optionsHtml;
    }

    // Hàm lưu đáp án
    function saveAnswer(val) {
        userAnswers[currentIndex] = val;
    }

    // Điều hướng Next/Back
    function nextQuestion() {
        if (currentIndex < questions.length - 1) {
            currentIndex++;
            renderQuestion();
        } else {
            if(confirm("Bạn đã làm xong câu cuối. Bạn có muốn nộp bài không?")) {
                submitExam();
            }
        }
    }

    function prevQuestion() {
        if (currentIndex > 0) {
            currentIndex--;
            renderQuestion();
        }
    }
    
    function submitExam() {
        alert("Nộp bài thành công! Dữ liệu sẽ được gửi về server.");
        console.log("Đáp án đã chọn:", userAnswers);
    }

    // Chạy render lần đầu tiên
    renderQuestion();

    // Đồng hồ đếm ngược
    var timeLeft = 75 * 60; 
    setInterval(function() {
        if(timeLeft <= 0) return;
        timeLeft--;
        var m = Math.floor(timeLeft / 60);
        var s = timeLeft % 60;
        document.getElementById("timeDisplay").innerText = m + ":" + (s < 10 ? "0" : "") + s;
    }, 1000);

</script>

</body>
</html>