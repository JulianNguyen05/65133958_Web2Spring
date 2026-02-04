<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
	    <h1>Hello, Expression Language!</h1>
	    <h2>Welcome to JSP with Julian</h2>
	    <%=new Date().toString()%>
	    <%=2+5%>
	    <br/>
	    <%="<b>Today I learn JSP</b>" %>
	</center>
</body>
</html>