<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<title>fintech_pj_damn</title>
</head>
<body>
	<%
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		String searchId = request.getParameter("searchText");

		if(userId == null){
			out.println("<script>");
			out.println("alert('로그인 해주세요')");
			out.println("location.href='login.jsp'");
			out.println("</script>");
		}else{
			out.println("<script>");
			out.println("location.href='user_list.jsp?id="+searchId+"'");
			out.println("</script>");
		}		
	%>
</body>
</html>