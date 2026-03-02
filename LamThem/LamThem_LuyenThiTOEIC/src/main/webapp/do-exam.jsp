<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Làm bài thi - ${examTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* GIAO DIỆN CHUẨN TOEIC CBT */
        body { height: 100vh; overflow: hidden; display: flex; flex-direction: column; background-color: #f8f9fa; }
        
        /* Header */
        .exam-header {
            height: 60px; background-color: #ffffff; border-bottom: 2px solid #ddd;
            display: flex; align-items: center; justify-content: space-between; padding: 0 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .timer-box { font-weight: bold; color: #d9534f; font-size: 1.2rem; }

        /* Main Content */
        .exam-container { flex: 1; display: flex; overflow: hidden; }

        .left-pane { width: 50%; border-right: 1px solid #ccc; padding: 25px; overflow-y: auto; background-color: #fff; display: none; }
        .right-pane { width: 50%; padding: 25px; overflow-y: auto; background-color: #fafafa; flex: 1; }
        
        .reading-passage { font-family: "Times New Roman", serif; font-size: 1.15rem; line-height: 1.6; white-space: pre-wrap; color: #333; }

        /* Nút đáp án */
        .question-box { background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: 1px solid #eaeaea; }
        .option-label { 
            display: block; margin: 12px 0; cursor: pointer; padding: 15px; font-size: 1.1rem;
            border: 2px solid #eee; border-radius: 8px; transition: all 0.2s ease-in-out;
            background-color: #fff;
        }
        .option-label:hover { background-color: #f1f3f5; border-color: #ced4da; }
        
        /* Hiệu ứng khi được chọn */
        .option-label.selected { background-color: #d1e7dd; border-color: #198754; color: #0f5132; font-weight: 500; }

        /* Footer */
        .exam-footer {
            height: 60px; background: #343a40; color: white;
            display: flex; align-items: center; justify-content: center; padding: 0 20px;
        }
    </style>
</head>
<body>

<div class="exam-header" id="examHeader">
    <div><strong class="fs-5 text-primary">TOEIC Reading Test</strong></div>
    <div class="timer-box">⏱ <span id="timeDisplay">20:00</span></div>
    <div>
        <button class="btn btn-danger btn-sm px-3 fw-bold" onclick="forceSubmit()">Kết thúc bài thi</button>
    </div>
</div>

<div class="exam-container" id="examContainer">
    <div id="leftPane" class="left-pane">
        <div class="alert alert-info fw-bold">Refer to the following text:</div>
        <div id="passageText" class="reading-passage"></div>
    </div>

    <div id="rightPane" class="right-pane">
        <div class="question-box">
            <h5 id="questionNumber" class="text-primary fw-bold mb-3">Question 101</h5>
            <p id="questionText" class="lead fw-bold mb-4">Loading...</p>
            <div id="optionsArea"></div>
        </div>
    </div>
</div>

<div class="exam-footer" id="examFooter">
    <span id="progressText" class="fs-5 fw-bold">Question 1 of 100</span>
</div>


<div id="reviewScreen" class="container mt-4" style="display: none; height: 100vh; overflow-y: auto; padding-bottom: 50px;">
    <div class="card shadow-lg border-0">
        <div class="card-header bg-success text-white text-center py-4">
            <h2 class="mb-0">🎉 Hoàn thành bài thi!</h2>
        </div>
        <div class="card-body p-4">
            <h3 class="text-center mb-4">Điểm số: <span id="finalScore" class="text-danger fs-1 fw-bold">0</span> / <span id="totalQuestions" class="fs-2">0</span></h3>
            
            <div class="text-center mb-5">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg px-5 rounded-pill shadow-sm">🏠 Về thư viện đề thi</a>
            </div>

            <hr class="mb-4">
            <h4 class="mb-4 text-secondary"><i class="bi bi-card-checklist"></i> Chi tiết đáp án:</h4>
            
            <div id="reviewContent"></div> 
        </div>
    </div>
</div>


<script type="application/json" id="examDataJson">
    ${examData}
</script>

<script>
    // --- PHẦN 1: ĐỌC VÀ CHUẨN BỊ DỮ LIỆU ---
    var rawData = document.getElementById("examDataJson").textContent;
    var questions = []; 
    var examTitle = "";

    try {
        var examObj = JSON.parse(rawData.trim());
        examTitle = examObj.examTitle;
        if (examObj.parts) {
            examObj.parts.forEach(function(part) {
                var partPassage = part.passage || part.groupText || "";
                if (part.questions) {
                    part.questions.forEach(function(q) {
                        var optArray = [];
                        if (q.options) {
                            optArray.push({ key: 'A', value: q.options.A });
                            optArray.push({ key: 'B', value: q.options.B });
                            optArray.push({ key: 'C', value: q.options.C });
                            optArray.push({ key: 'D', value: q.options.D });
                        }
                        questions.push({
                            id: q.id,
                            partNumber: part.partNumber,
                            text: q.text,
                            options: optArray,
                            groupText: q.passage || q.groupText || partPassage, 
                            correctAnswer: q.correct_answer
                        });
                    });
                }
            });
        }
    } catch (e) {
        alert("Lỗi đọc dữ liệu JSON!");
        console.error(e);
    }

    var currentIndex = 0;
    var userAnswers = {}; 
    var isTransitioning = false; // Khóa chống click đúp

    // --- PHẦN 2: HIỂN THỊ CÂU HỎI ---
    function renderQuestion() {
        if (!questions || questions.length === 0 || !questions[currentIndex]) return;
        var q = questions[currentIndex];
        
        document.getElementById("questionNumber").innerText = "Question " + q.id;
        document.getElementById("progressText").innerText = "Question " + (currentIndex + 1) + " of " + questions.length;
        
        var leftPane = document.getElementById("leftPane");
        var rightPane = document.getElementById("rightPane");
        var passageDiv = document.getElementById("passageText");

        // Xử lý chia đôi màn hình
        if (q.groupText && q.groupText.trim() !== "") {
            leftPane.style.display = "block";
            rightPane.style.width = "50%";
            passageDiv.innerText = q.groupText;
        } else {
            leftPane.style.display = "none";
            rightPane.style.width = "100%";
        }

        document.getElementById("questionText").innerText = q.text;

        // In danh sách đáp án dạng nút bấm
        var optionsHtml = "";
        q.options.forEach(function(opt) {
            optionsHtml += '<div class="option-label" id="label_' + opt.key + '" onclick="saveAnswer(\'' + opt.key + '\')">' +
                               '<b>' + opt.key + '.</b> ' + opt.value +
                           '</div>';
        });
        document.getElementById("optionsArea").innerHTML = optionsHtml;
    }

    // --- PHẦN 3: XỬ LÝ CHỌN ĐÁP ÁN & AUTO-NEXT ---
    function saveAnswer(val) {
        if (isTransitioning) return; // Đang trượt câu thì cấm bấm
        isTransitioning = true; 
        
        userAnswers[currentIndex] = val;
        document.getElementById('label_' + val).classList.add('selected');

        setTimeout(function() {
            if (currentIndex < questions.length - 1) {
                currentIndex++;
                renderQuestion();
            } else {
                if(confirm("Bạn đã hoàn thành câu cuối cùng! Nộp bài nhé?")) {
                    submitExam();
                }
            }
            isTransitioning = false; 
        }, 400); // Trễ 0.4s để tạo cảm giác phản hồi
    }

    // --- PHẦN 4: CHẤM ĐIỂM VÀ SHOW KẾT QUẢ ---
    function forceSubmit() {
        if(confirm("Bạn có chắc chắn muốn kết thúc bài thi ngay bây giờ?")) {
            submitExam();
        }
    }
    
    function submitExam() {
        clearInterval(timerInterval); // Dừng đồng hồ

        var correctCount = 0;
        var reviewHtml = "";

        // Duyệt qua toàn bộ mảng câu hỏi để chấm điểm
        questions.forEach(function(q, index) {
            var uAns = userAnswers[index];
            var cAns = q.correctAnswer;
            var isCorrect = (uAns === cAns);

            if (isCorrect) correctCount++;

            // Thẻ bọc câu hỏi: Xanh mờ nếu đúng, Đỏ mờ nếu sai
            var bgClass = isCorrect ? "bg-success bg-opacity-10 border-success" : "bg-danger bg-opacity-10 border-danger";
            
            reviewHtml += '<div class="card mb-4 shadow-sm ' + bgClass + '">';
            reviewHtml += '<div class="card-body">';
            reviewHtml += '<h5 class="fw-bold">Câu ' + q.id + ': ' + q.text + '</h5>';
            
            // In lại 4 đáp án để đối chiếu
            q.options.forEach(function(opt) {
                var optStyle = "color: #555; padding: 5px 0;"; 
                var icon = "";

                if (opt.key === cAns) {
                    optStyle = "color: #198754; font-weight: bold; padding: 5px 0;"; // Đáp án đúng tô xanh lục
                    icon = " ✅";
                } else if (opt.key === uAns && !isCorrect) {
                    optStyle = "color: #dc3545; font-weight: bold; text-decoration: line-through; padding: 5px 0;"; // Chọn sai gạch bỏ đỏ
                    icon = " ❌ (Bạn chọn)";
                }

                reviewHtml += '<div style="' + optStyle + '"><b>' + opt.key + '.</b> ' + opt.value + icon + '</div>';
            });

            if (!uAns) {
                reviewHtml += '<div class="text-danger mt-3 fw-bold"><i class="bi bi-exclamation-triangle"></i> Bạn chưa chọn đáp án cho câu này.</div>';
            }

            reviewHtml += '</div></div>';
        });

        // Đổ dữ liệu vào UI Kết quả
        document.getElementById("reviewContent").innerHTML = reviewHtml;
        document.getElementById("finalScore").innerText = correctCount;
        document.getElementById("totalQuestions").innerText = questions.length;
        
     	// Lưu điểm về Server
        var examId = new URLSearchParams(window.location.search).get("id"); // Lấy ID trên thanh URL
        var totalTime = 20 * 60; // Tổng thời gian 20 phút
        var timeSpent = totalTime - timeLeft; // Số giây đã tiêu tốn

        var formData = new URLSearchParams();
        formData.append("examId", examId);
        formData.append("score", correctCount);
        formData.append("timeSpent", timeSpent);

        // Gửi ngầm dữ liệu về SaveResultServlet
        fetch('save-result', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString()
        }).then(response => console.log("Lưu điểm thành công!"))
          .catch(error => console.error("Lỗi:", error));

        // Hoán đổi giao diện
        document.getElementById("examHeader").style.display = "none";
        document.getElementById("examContainer").style.display = "none";
        document.getElementById("examFooter").style.display = "none";
        
        var reviewScreen = document.getElementById("reviewScreen");
        reviewScreen.style.display = "block";
        window.scrollTo(0, 0); // Cuộn lên đầu trang
    }

    // --- PHẦN 5: ĐỒNG HỒ ĐẾM NGƯỢC ---
    renderQuestion(); // Chạy ngay lần đầu tiên
    
    var timeLeft = 20 * 60; 
    var timerInterval = setInterval(function() {
        if(timeLeft <= 0) {
            clearInterval(timerInterval);
            alert("Hết giờ làm bài! Hệ thống tự động nộp bài.");
            submitExam();
            return;
        }
        timeLeft--;
        var m = Math.floor(timeLeft / 60);
        var s = timeLeft % 60;
        document.getElementById("timeDisplay").innerText = m + ":" + (s < 10 ? "0" : "") + s;
    }, 1000);

</script>

</body>
</html>