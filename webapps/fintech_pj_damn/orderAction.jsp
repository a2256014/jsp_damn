<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width", initial-scale"="1">
<title>fintech_pj_damn</title>
</head>
<body>
	<%
		String orderField = request.getParameter("orderField");
		String orderType = request.getParameter("orderType");
		String level = request.getParameter("level");
		
		out.println("<script>");
		out.println("location.href='board.jsp?orderField="+ orderField +"&orderType=" + orderType +"&level=" + level + "'");
		out.println("</script>");
	%>
</body>
</html>