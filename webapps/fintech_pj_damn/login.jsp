<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>fintech_pj_damn</title>
</head>
<%
	String unlock = "true";
	if(session.getAttribute("unlock")!= null){
		unlock = (String) session.getAttribute("unlock");
	}
	if(unlock.equals("false")){
		long restTime = 0;
		if(session.getAttribute("locked") != null) restTime = (long) session.getAttribute("locked");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('" + restTime + "분 잠김');");
		script.println("</script>");
	}else if(session.getAttribute("attempts") != null && (int) session.getAttribute("attempts") > 0){
		int attemp = (int) session.getAttribute("attempts");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('" + attemp + "회 실패');");
		script.println("</script>");
	}
%>
<body>
	<div class="container-fluid" >
		<div class="row align-items-center">
			<div class="col"></div>
			<div class="col rounded-5"  style="height: 300px; background-color: rgba(255,0,0,0.1); margin-top: 50px; padding-top: 35px;">
				<div class="jumbotron" style="padding-top: 20px;">
					<form method="post" action="./login<%=level%>">
					<h3 style="text-align: center;">로그인 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userid" maxlength="200">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userpass" maxlength="200">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
