<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String user = request.getParameter("username");
    String pass = request.getParameter("password");

    if (user == null) user = "";
    if (pass == null) pass = "";

    if ("ABC".equals(user) && "MNK".equals(pass)) {
        response.sendRedirect("UserProfile.html");
        
    } else {
        response.sendRedirect("Login.html");
    }
%>