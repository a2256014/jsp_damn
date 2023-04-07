<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	session.removeAttribute("userId");
	//세션이름이 "id"인것을 삭제함
	response.sendRedirect("/fintech_pj_damn");
%>

</body>
</html>