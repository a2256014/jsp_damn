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
<title>fintech_pj</title>
</head>
<body>
	<%
		String userid = request.getParameter("userid");
		String userpass = request.getParameter("userpass");
		String username = request.getParameter("username");
		String useremail = request.getParameter("useremail");
		String userphoneNum = request.getParameter("userphoneNum");
		
		UserPostDao dao = new UserPostDao();
		UserVo vo = null;

		vo = dao.getUser(userid,userpass,username,useremail,userphoneNum);

		if(vo == null){
			out.println("<script>");
			out.println("alert('아이디 중복')");
			out.println("history.back()");
			out.println("</script>");
		}else{
			out.println("<script>");
			out.println("alert('생성 완료')");
			out.println("location.href='login.jsp'");
			out.println("</script>");
		}
	%>
</body>
</html>