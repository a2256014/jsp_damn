<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
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
	<% 
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int boardID = 0;
		if (request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if (boardID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		BoardVo vo = new BoardDao().getBoardVo(boardID);
		if (!userId.equals(vo.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	<div class="container">
		<div class="row" style="margin-top: 50px;">
			<form method="post" action="updateAction.jsp?boardID=<%= boardID %>" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="boardTitle" maxlength="50" value="<%= vo.getBoardTitle() %>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="boardContent" maxlength="2048" style="height: 350px"><%= vo.getBoardContent() %></textarea></td>						
					</tr>
					<tr>
						<td>
							<input type="file" class="form-control" name="fName">
						</td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>						
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>