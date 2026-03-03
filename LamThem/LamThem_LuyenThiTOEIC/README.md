# JulianToeic Lab – TOEIC Part 5 Preparation System

An interactive and modern web application designed to help learners effectively prepare for the TOEIC exam. Built with Java Servlets, JSP, and a fully responsive user interface, JulianToeic Lab delivers a complete ecosystem—from user management and realistic exam simulation to competitive performance leaderboards.

This project was developed as a practical exercise to reinforce knowledge of MVC architecture, session management, and database interaction in a real-world web environment.

---

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847464920_634a254b7f8e7f7262162eac02e815aa.jpg" 
       alt="JulianToeic Lab Cover" 
       width="100%">
</p>

---

## 🌟 Project Overview

JulianToeic Lab provides a smooth and professional learning experience with a clear separation between two roles: **Admin** and **User**.

* The **Admin** has full control over the exam repository and user accounts through an intuitive dashboard.
* The **User** can access the exam library, experience a realistic Computer-Based Testing (CBT) interface, and track progress through an automated scoring system and leaderboard rankings.

### 🧩 Technical Stack

* **Backend:** Java Servlets, JSP (Jakarta EE 10)
* **Frontend:** HTML5, CSS3, Vanilla JavaScript, Bootstrap 5, FontAwesome
* **Database:** MySQL (via JDBC)
* **Architecture:** MVC (Model–View–Controller)

---

## 🚀 Key Features

### 1️⃣ Authentication & Authorization System

A secure authentication flow with a bright, modern glassmorphism-inspired interface.

* **Register:** Real-time duplicate username validation.
* **Login:** Secure credential verification with session tracking.
* **Role-Based Access:** Automatic redirect based on `USER` / `ADMIN`.

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847348718_5361fd9cdd4b571c27af20ab8a0b7657.jpg" width="100%">
</p>

*Modern login interface with a striking gradient effect.*

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847348722_4461fcea521a87978f7a056698f1b0d6.jpg" width="100%">
</p>

*Clean and user-friendly registration interface.*

---

### 2️⃣ User Dashboard – Exam Library

* Interactive exam cards with hover effects.
* Modal popup for starting exams or viewing leaderboard.
* Dynamic avatar generation via external API.

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847464920_634a254b7f8e7f7262162eac02e815aa.jpg" width="100%">
</p>

*Personalized exam library with flexible options.*

---

### 3️⃣ Realistic CBT Exam Experience

* Split-screen layout for Parts 6 & 7.
* Full-width layout for Part 5.
* Auto-next question (0.4s delay).
* Real-time 20-minute countdown timer.
* Auto-submit when time expires.

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847464916_b45b10f862200b43dc31ec2132a957b1.jpg" width="100%">
</p>

*Focused exam workspace with intelligent column layout.*

---

### 4️⃣ Instant Auto-Scoring & Performance Review

* Instant score calculation.
* Two-column centered result layout.
* Color-coded answer feedback:

  * Correct → Dark green (`#d1e7dd`)
  * Incorrect → Red (`#f8d7da`)
* Silent background submission using Fetch API.

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847348719_c8b903d0e36a7bbea20680d01a5ce961.jpg" width="100%">
</p>

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847464922_d7600a1f6a149857b0f99640442a5b3c.jpg" width="100%">
</p>

*Detailed score report with intuitive color-coded analysis.*

---

### 5️⃣ Leaderboard System

* Top 50 rankings per exam.
* Weighted ranking:

  * Higher score ranks first.
  * If tied → shorter time ranks higher.
* Medal highlights for Top 3 (🥇🥈🥉).

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847464919_b8638c9703385c44b67a12c31cd5b61a.jpg" width="100%">
</p>

*Leaderboard honoring the highest achievers.*

---

### 6️⃣ Admin Dashboard

Organized with Nav-Tabs for clean management.

#### 📌 Exam Management

* Upload exams (JSON format)
* Edit or delete exams
* View metadata

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847464921_7b9318a3a2d3059d378ff4949ad18a09.jpg" width="100%">
</p>

*Exam repository control.*

#### 👤 User Management

* Create new users
* Update roles (`ADMIN` / `USER`)
* Remove accounts

<p align="center">
  <img src="./src/main/webapp/assets/images/z7583847464923_2999cb6854c584644c775828f16b572d.jpg" width="100%">
</p>

*User account and role management.*

---

## 📚 Learning Outcomes

* Java Servlet lifecycle mastery
* JSP & JSTL dynamic rendering
* Secure session management with `HttpSession`
* Responsive UI with CSS Box Model
* Asynchronous communication via Fetch API

---

## 👨‍💻 Author

**JulianNguyen – Trongdepzai**

A passionate developer aspiring to become a full-stack engineer, focused on building practical, user-centered educational technology solutions while continuously expanding expertise across both frontend and backend development.

---