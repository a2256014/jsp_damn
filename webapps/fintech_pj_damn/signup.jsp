<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>fintech_pj</title>
</head>
<jsp:include page="header.jsp" />
<body>
	<div class="container-fluid" >
		<div class="row align-items-center">
			<div class="col"></div>
			<div class="col rounded-5"  style="height: 400px; background-color: rgba(255,0,0,0.1); margin-top: 50px; padding-top: 35px;">
				<div class="jumbotron" style="padding-top: 20px;">
					<form method="post" action="signupAction.jsp">
					<h3 style="text-align: center;">ȸ������ ȭ��</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="���̵�" name="userid" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="��й�ȣ" name="userpass" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="�̸�" name="username" maxlength="20">
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="�̸���" name="useremail" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="�ڵ��� ��ȣ" name="userphoneNum" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="ȸ������">
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
