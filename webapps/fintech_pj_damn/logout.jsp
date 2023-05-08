<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	//세션이름이 "id"인것을 삭제함
	Enumeration<String> attributeNames = session.getAttributeNames();
    while (attributeNames.hasMoreElements()) {
        String attributeName = attributeNames.nextElement();
		if(!attributeName.equals("level")) session.removeAttribute(attributeName);
    }
	response.sendRedirect("/fintech_pj_damn");
%>

</body>
</html>