# JulianToeic Lab – TOEIC Part 5 Preparation System

An interactive and modern web application designed to help learners effectively prepare for the TOEIC exam. Built with Java Servlets, JSP, and a fully responsive user interface, JulianToeic Lab delivers a complete ecosystem—from user management and realistic exam simulation to competitive performance leaderboards.

This project was developed as a practical exercise to reinforce knowledge of MVC architecture, session management, and database interaction in a real-world web environment.

---

![JulianToeic Lab Cover](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847464920_634a254b7f8e7f7262162eac02e815aa.jpg" alt="Demo Img1" width="300"/>

</div>)

---

## 🌟 Project Overview

JulianToeic Lab provides a smooth and professional learning experience with a clear separation between two roles: **Admin** and **User**.

* The **Admin** has full control over the exam repository and user accounts through an intuitive dashboard.
* The **User** can access the exam library, experience a realistic Computer-Based Testing (CBT) interface, and track progress through an automated scoring system and leaderboard rankings.

### 🧩 Technical Stack

* **Backend:** Java Servlets, JSP (Jakarta EE 10) – Handles business logic and request routing.
* **Frontend:** HTML5, CSS3, Vanilla JavaScript, Bootstrap 5, FontAwesome – Modern EdTech-style interface.
* **Database:** MySQL (via JDBC) – Stores user data, exam metadata (JSON file references), and test results.
* **Architecture:** MVC (Model–View–Controller) – Ensures a clear separation between UI, control flow, and data processing.

---

## 🚀 Key Features

### 1️⃣ Authentication & Authorization System

A secure authentication flow with a bright, modern glassmorphism-inspired interface.

* **Register:** Allows users to create new accounts with real-time duplicate username validation.
* **Login:** Secure credential verification with session tracking.
* **Role-Based Access:** Automatically detects `USER` and `ADMIN` roles, redirects users to the appropriate dashboard, and dynamically shows/hides administrative features.

![Login Interface](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847348718_5361fd9cdd4b571c27af20ab8a0b7657.jpg" alt="Demo Img1" width="300"/>

</div>)
*Modern login interface with a striking gradient effect.*

![Register Interface](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847348722_4461fcea521a87978f7a056698f1b0d6.jpg" alt="Demo Img1" width="300"/>

</div>)
*Clean and user-friendly registration interface.*

---

### 2️⃣ User Dashboard – Exam Library

A central learning hub where users can explore and begin practice tests.

* **Exam List:** Exams are displayed as interactive cards with smooth hover effects, including detailed titles and descriptions.
* **Interactive Modal:** Clicking on an exam opens a modal window where users can start the test or view its leaderboard.
* **Personalization:** The navigation bar dynamically generates user avatars based on usernames via an integrated API.

![User Home Interface](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847464920_634a254b7f8e7f7262162eac02e815aa.jpg" alt="Demo Img1" width="300"/>

</div>)
*Personalized exam library with flexible options.*

---

### 3️⃣ Realistic CBT Exam Experience

The core of the application delivers an optimized and immersive testing environment.

* **Dynamic Layout:**

  * For reading sections (Parts 6 & 7): split-screen layout with passage on the left and questions on the right.
  * For Part 5: full-width question display for better focus.

* **Auto-Next Feature:** Automatically transitions to the next question 0.4 seconds after answer selection, with double-click prevention.

* **Countdown Timer:** Displays a real-time 20-minute timer. When time runs out, the system alerts the user and automatically submits the test.

* **Optimized Readability:** Larger font sizes and well-balanced spacing to reduce eye strain during extended practice sessions.

![Exam Interface](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847464916_b45b10f862200b43dc31ec2132a957b1.jpg" alt="Demo Img1" width="300"/>

</div>)
*Focused exam workspace with intelligent column layout.*

---

### 4️⃣ Instant Auto-Scoring & Performance Review

Using a localized SPA-style approach, the application evaluates and displays results instantly without page reload.

* **Instant Scoring:** Calculates total correct answers and completion time.

* **Review Screen Layout:** Two-column header grid to center the score and navigation controls.

* **Color-Coded Feedback:**

  * Correct answers highlighted in dark green (`#d1e7dd`)
  * Incorrect selections marked in red (`#f8d7da`)
  * Clear visual comparison for efficient review and improvement

* **Background Data Sync:** Uses the Fetch API to silently submit score and time data to the server (Servlet).

![Result Review Screen](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847348719_c8b903d0e36a7bbea20680d01a5ce961.jpg" alt="Demo Img1" width="300"/> <img src="./src/main/webapp/assets/images/z7583847464922_d7600a1f6a149857b0f99640442a5b3c.jpg" alt="Demo Img1" width="300"/>

</div>)
*Detailed score report with intuitive color-coded analysis.*

---

### 5️⃣ Leaderboard System

Encourages motivation through healthy competition.

* **Top 50 Rankings:** Displays the top 50 performances for each exam.

* **Weighted Ranking Algorithm:**

  * Higher scores rank first.
  * In case of a tie, shorter completion time ranks higher.

* **Top 3 Highlights:** The leading three users are emphasized with medal icons (🥇🥈🥉) and gold, silver, and bronze-themed backgrounds.

![Leaderboard Interface](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847464919_b8638c9703385c44b67a12c31cd5b61a.jpg" alt="Demo Img1" width="300"/>

</div>)
*Leaderboard honoring the highest achievers.*

---

### 6️⃣ Admin Dashboard

A dedicated management area for system administration, organized with Nav-Tabs to maintain a clean and structured layout.

#### 📌 Exam Management

* Upload new exams in structured JSON format
* View detailed exam information (ID, name, file reference)
* Edit descriptions or delete exams via modern rounded modal dialogs

#### 👤 User Management

* Display all registered accounts
* Create new users
* Update user roles (`ADMIN` or `USER`)
* Remove unnecessary or inactive accounts

#### 🔄 State Retention

After performing edit or delete operations, JavaScript preserves the active tab using URL hash anchors, enhancing the overall user experience.

![Admin Dashboard – Exam Management](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847464921_7b9318a3a2d3059d378ff4949ad18a09.jpg" alt="Demo Img1" width="300"/>

</div>)
*Exam management and TOEIC test repository control.*

![Admin Dashboard – User Management](<div style="display: flex; gap: 10px;"> <img src="./src/main/webapp/assets/images/z7583847464923_2999cb6854c584644c775828f16b572d.jpg" alt="Demo Img1" width="300"/>

</div>)
*User account control and role management.*

---

## 📚 Learning Outcomes

* Mastering the **Java Servlet lifecycle** and Request/Response handling
* Effectively using **JSP and JSTL** for dynamic content rendering
* Implementing secure session management with **HttpSession**
* Applying the **CSS Box Model** and responsive design principles
* Implementing asynchronous communication using the **JavaScript Fetch API**

---

## 👨‍💻 Author

**JulianNguyen – Trongdepzai**

A passionate developer aspiring to become a full-stack engineer.
