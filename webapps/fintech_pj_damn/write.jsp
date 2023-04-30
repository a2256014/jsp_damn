<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>fintech_pj</title>
</head>

<body>
	<div class="container">
		<div class="row" style="margin-top: 50px;">
			<form method="post" action="writeAction.jsp" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">�Խ��� �۾��� ���</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="�� ����" name="boardTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="�� ����" name="boardContent" maxlength="2048" style="height: 350px"></textarea></td>						
					</tr>
					<tr>
						<td>
							<input type="file" class="form-control" name="fName">
						</td>
					</tr>
				</tbody>
				
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="�۾���">
			</form>						
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>