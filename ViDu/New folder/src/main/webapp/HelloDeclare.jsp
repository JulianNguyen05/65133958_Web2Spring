<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%! int x=10; int y; int z=0; %>
	<% y=200; z=x+y;
		out.append("Result is: ");
		out.append(String.valueOf(z));
    %>
    
    <hr>
    <h2>Xuất kiểu Expression</h2>
    <%= "Result by Expression is: " %>
    <%= z %>
</body>
</html>