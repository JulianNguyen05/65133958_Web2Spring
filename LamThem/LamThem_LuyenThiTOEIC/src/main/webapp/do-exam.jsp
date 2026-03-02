<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Làm bài thi - ${examTitle}</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* GIAO DIỆN CHUẨN TOEIC CBT - MODERN EDTECH */
        body { font-family: 'Poppins', sans-serif; height: 100vh; overflow: hidden; display: flex; flex-direction: column; background-color: #f4f7fa; }
        
        /* Header */
        .exam-header {
            height: 70px; background-color: #ffffff; border-bottom: 1px solid #eaeaea;
            display: flex; align-items: center; justify-content: space-between; padding: 0 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03); z-index: 10;
        }
        .timer-box { font-weight: 700; color: #ff4757; font-size: 1.4rem; background: #ffeaa7; padding: 5px 15px; border-radius: 50px; box-shadow: inset 0 2px 4px rgba(0,0,0,0.1); }

        /* Main Content */
        .exam-container { flex: 1; display: flex; overflow: hidden; }

        .left-pane { width: 50%; border-right: 1px solid #eaeaea; padding: 40px; overflow-y: auto; background-color: #fff; display: none; }
        .right-pane { width: 50%; padding: 40px; overflow-y: auto; background-color: #f8fafc; flex: 1; display: flex; justify-content: center; }
        
        .reading-passage { font-family: 'Times New Roman', serif; font-size: 1.2rem; line-height: 1.8; white-space: pre-wrap; color: #2d3748; }

        /* Nút đáp án lúc làm bài */
        .question-box { background: #fff; padding: 35px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 1px solid #f0f0f0; width: 100%; max-width: 800px; height: fit-content; }
        
        /* LÀM TO TEXT CÂU HỎI LÚC THI */
        #questionText {
            font-size: 1.5rem !important; /* To hơn rõ rệt */
            color: #1e293b;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .option-label { 
            display: block; margin: 15px 0; cursor: pointer; padding: 18px 25px; font-size: 1.15rem;
            border: 2px solid #edf2f7; border-radius: 12px; transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            background-color: #fff; color: #4a5568; font-weight: 500;
        }
        .option-label:hover { background-color: #f8fafc; border-color: #cbd5e0; transform: translateX(5px); }
        .option-label.selected { background-color: #ebf8ff; border-color: #00E5FF; color: #0072ff; box-shadow: 0 4px 15px rgba(0, 229, 255, 0.2); transform: translateX(5px); }

        /* Footer */
        .exam-footer {
            height: 60px; background: #fff; color: #718096; border-top: 1px solid #eaeaea;
            display: flex; align-items: center; justify-content: center; padding: 0 20px; box-shadow: 0 -4px 15px rgba(0,0,0,0.02);
        }
        .btn-danger { background: #ff4757; border: none; border-radius: 50px; padding: 8px 20px; box-shadow: 0 4px 10px rgba(255, 71, 87, 0.3); transition: 0.3s; }
        .btn-danger:hover { background: #ff6b81; transform: translateY(-2px); }

        /* ==================================================
           CSS CHO MÀN HÌNH XEM LẠI (REVIEW SCREEN)
           ================================================== */
        #reviewScreen {
            display: none; height: 100vh; overflow-y: auto; padding-bottom: 80px; background-color: #f4f7fa;
        }
        .review-wrapper {
            max-width: 850px; /* Thu hẹp giao diện chấm điểm vào giữa */
            margin: 40px auto; 
            padding: 0 15px;
        }
        .review-card {
            background: #fff; border-radius: 16px; border: 1px solid #e2e8f0; overflow: hidden; margin-bottom: 25px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02); transition: 0.3s;
        }
        .review-card:hover { box-shadow: 0 12px 25px rgba(0,0,0,0.08); }
        .review-q-header {
            padding: 15px 25px; font-weight: 700; font-size: 1.1rem; display: flex; align-items: center;
            border-bottom: 1px solid #edf2f7;
        }
        .review-q-content { padding: 25px; }
        .review-passage-box { background: #f8fafc; padding: 15px; border-radius: 10px; margin-bottom: 20px; font-family: 'Times New Roman', serif; font-size: 1.1rem; color: #4a5568; border-left: 4px solid #cbd5e0; }
        
        .review-option {
            padding: 12px 20px; margin-bottom: 10px; border-radius: 10px; font-size: 1.05rem;
            background: #f8fafc; border: 1px solid transparent; color: #4a5568; display: flex; justify-content: space-between;
        }
        .review-option.correct { background: #d1e7dd; border-color: #badbcc; color: #0f5132; font-weight: 600; }
        .review-option.wrong { background: #f8d7da; border-color: #f5c2c7; color: #842029; text-decoration: line-through; opacity: 0.9; }
    	
    	.btn-return-home {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #00E5FF, #0072ff);
            color: #ffffff !important;
            font-weight: 600;
            font-size: 1.15rem;
            padding: 14px 45px;
            border-radius: 50px;
            text-decoration: none;
            box-shadow: 0 8px 20px rgba(0, 114, 255, 0.25);
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
            margin-top: 10px;
        }
        .btn-return-home:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 25px rgba(0, 114, 255, 0.4);
            color: #ffffff;
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
        <div class="alert alert-info fw-bold"><i class="fas fa-book-open me-2"></i> Refer to the following text:</div>
        <div id="passageText" class="reading-passage"></div>
    </div>

    <div id="rightPane" class="right-pane">
        <div class="question-box">
            <h5 id="questionNumber" class="text-primary fw-bold mb-3"><i class="fas fa-question-circle me-1"></i> Question 101</h5>
            <p id="questionText" class="fw-bold mb-4">Loading...</p>
            <div id="optionsArea"></div>
        </div>
    </div>
</div>

<div class="exam-footer" id="examFooter">
    <span id="progressText" class="fs-5 fw-bold">Question 1 of 100</span>
</div>

<div id="reviewScreen">
    <div class="review-wrapper">
        <div class="card shadow-lg border-0 mb-5" style="border-radius: 20px; overflow: hidden;">
            <div class="card-header bg-success text-white text-center py-4 border-0">
                <i class="fas fa-award fa-3x mb-2"></i>
                <h2 class="mb-0 fw-bold">Hoàn thành bài thi!</h2>
            </div>
            
            <div class="card-body p-5">
                <div class="row align-items-center">
                    
                    <div class="col-md-6 text-center border-end">
                        <h3 class="mb-3 text-secondary">Điểm số của bạn</h3>
                        <h1 class="display-3 mb-0">
                            <span id="finalScore" class="text-danger fw-bold">0</span> 
                            <span class="text-muted fs-3">/ <span id="totalQuestions">0</span></span>
                        </h1>
                    </div>
                    
                    <div class="col-md-6 text-center mt-4 mt-md-0">
                        <a href="${pageContext.request.contextPath}/home" class="btn-return-home">
                            <i class="fas fa-home me-2"></i> Trở về Thư viện đề
                        </a>
                    </div>
                    
                </div>
                </div>
        </div>

        <h4 class="mb-4 text-secondary fw-bold text-center"><i class="fas fa-list-check me-2"></i> CHI TIẾT ĐÁP ÁN</h4>
        
        <div id="reviewContent"></div> 
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
    var isTransitioning = false; 

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
        if (isTransitioning) return;
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
        }, 400);
    }

    // --- PHẦN 4: CHẤM ĐIỂM VÀ SHOW KẾT QUẢ ---
    function forceSubmit() {
        if(confirm("Bạn có chắc chắn muốn kết thúc bài thi ngay bây giờ?")) {
            submitExam();
        }
    }
    
    function submitExam() {
        clearInterval(timerInterval);

        var correctCount = 0;
        var reviewHtml = "";
        
        // Duyệt qua toàn bộ mảng câu hỏi để chấm điểm theo UI mới
        questions.forEach(function(q, index) {
            var uAns = userAnswers[index];
            var cAns = q.correctAnswer;
            var isCorrect = (uAns === cAns);

            if (isCorrect) correctCount++;

            var headerClass = isCorrect ? "bg-success bg-opacity-10 text-success border-success" : "bg-danger bg-opacity-10 text-danger border-danger";
            var iconStatus = isCorrect ? '<i class="fas fa-check-circle me-2"></i>' : '<i class="fas fa-times-circle me-2"></i>';
            var cardBorder = isCorrect ? "border-success" : "border-danger";
            
            reviewHtml += '<div class="review-card ' + cardBorder + '">';
            reviewHtml += '<div class="review-q-header ' + headerClass + '">' + iconStatus + 'Question ' + q.id + '</div>';
            reviewHtml += '<div class="review-q-content">';
            
            // In lại đoạn văn (nếu có) để dễ đối chiếu
            if (q.groupText && q.groupText.trim() !== "") {
                reviewHtml += '<div class="review-passage-box">' + q.groupText + '</div>';
            }

            reviewHtml += '<h5 class="fw-bold mb-4" style="line-height: 1.5; color: #1e293b;">' + q.text + '</h5>';
            
            // In 4 đáp án dạng ô rõ ràng
            q.options.forEach(function(opt) {
                var optClass = "review-option";
                var iconHtml = "";

                if (opt.key === cAns) {
                    optClass += " correct"; // Đáp án đúng
                    iconHtml = '<span><i class="fas fa-check me-1"></i> Đúng</span>';
                } else if (opt.key === uAns && !isCorrect) {
                    optClass += " wrong"; // Chọn sai
                    iconHtml = '<span><i class="fas fa-times me-1"></i> Bạn chọn</span>';
                }

                reviewHtml += '<div class="' + optClass + '"><span><b>' + opt.key + '.</b> ' + opt.value + '</span>' + iconHtml + '</div>';
            });

            if (!uAns) {
                reviewHtml += '<div class="alert alert-warning mt-3 mb-0 py-2 fw-bold border-warning text-dark"><i class="fas fa-exclamation-triangle me-2"></i> Bạn chưa chọn đáp án. (Đáp án đúng là: ' + cAns + ')</div>';
            }

            reviewHtml += '</div></div>';
        });

        // Đổ dữ liệu vào UI Kết quả
        document.getElementById("reviewContent").innerHTML = reviewHtml;
        document.getElementById("finalScore").innerText = correctCount;
        document.getElementById("totalQuestions").innerText = questions.length;
        
        // Lưu điểm về Server
        var examId = new URLSearchParams(window.location.search).get("id"); 
        var totalTime = 20 * 60; 
        var timeSpent = totalTime - timeLeft;

        var formData = new URLSearchParams();
        formData.append("examId", examId);
        formData.append("score", correctCount);
        formData.append("timeSpent", timeSpent);

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
        window.scrollTo(0, 0); 
    }

    // --- PHẦN 5: ĐỒNG HỒ ĐẾM NGƯỢC ---
    renderQuestion(); 
    
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