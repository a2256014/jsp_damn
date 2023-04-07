<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("EUC-KR"); %>
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
<%
	String searchId = null;
	if (request.getParameter("id") != null) {
		searchId = (String) request.getParameter("id");
	}
%>
	<div class="container-fluid" >
		<div class="row align-items-center">
			<div class="col"></div>
			<div class="col rounded-5"  style="height: 300px; background-color: rgba(255,0,0,0.1); margin-top: 50px; padding-top: 35px;">
				<div class="jumbotron" style="padding-top: 20px;">
					<form method="post" name="search" action="user_searchAction<%=level%>.jsp" style="display: grid; justify-content: center; ">
					<h3 style="text-align: center;">유저 리스트</h3>
					<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="300"></td>
					<td><button type="submit" class="btn btn-success">검색</button></td>
				</form>
				</div>
				<%
					if(searchId != null){
						UserGetDao dao = new UserGetDao();
						ArrayList<UserVo> list = new ArrayList<>();
						
						list = dao.getUserList(searchId);
						for (int i = 0; i < list.size(); i++) {
				%>
					<td>아이디 = <%= list.get(i).getId() %></td>
				<%
					}
						}
				%>
			</div>
			<div class="col"></div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
