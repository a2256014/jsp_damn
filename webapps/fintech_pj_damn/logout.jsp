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
	//�����̸��� "id"�ΰ��� ������
	response.sendRedirect("/fintech_pj_damn");
%>

</body>
</html>