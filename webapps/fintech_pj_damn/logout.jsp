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
	//�����̸��� "id"�ΰ��� ������
	session.removeAttribute("userId");
	session.removeAttribute("privilege");
	response.sendRedirect("/fintech_pj_damn");
%>

</body>
</html>