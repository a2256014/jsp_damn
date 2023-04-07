<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
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
<body>
	<div class="container-fluid" >
		<div class="row align-items-center">
			<div class="col"></div>
			<div class="col rounded-5"  style="height: 300px; background-color: rgba(255,0,0,0.1); margin-top: 50px; padding-top: 35px;">
				<div class="jumbotron" style="padding-top: 20px;">
					<form method="post" action="changePassAction<%=level%>.jsp">
						<h3 style="text-align: center;">비밀번호 변경</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="현재비밀번호" name="curpass" maxlength="20">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="변경할비밀번호" name="prevpass" maxlength="20">
						</div>
						<input type="hidden" value=<%= userId%> name="userid">
						<input type="submit" class="btn btn-primary form-control" value="변경">
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