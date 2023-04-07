<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="fintech_pj_damn.*" %>
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
		
	%>
	<div class="container">
		<div class="row" style="margin-top: 50px;">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글제목</td>
						<td colspan="2"><%= vo.getBoardTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= vo.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= vo.getBoardDate().substring(0, 11) + vo.getBoardDate().substring(11, 13) + "시" + vo.getBoardDate().substring(14, 16) + "분 " %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= vo.getBoardContent() %></td>
					</tr>
					<% if(vo.getFName() != null) { %>
					<tr>
						<td>파일</td>
						<td colspan="2" style="min-height: 200px; text-align: left;">
							<%= vo.getFName()%>
							<button type="button" onclick="location.href='fileDownload<%=level%>.jsp?fName=<%= vo.getFName()%>'" class="btn btn-primary me-2">파일 다운로드</button>
						</td>
					</tr>
					<%} else {%>
					<tr>
						<td>파일</td>
						<td colspan="2" style="min-height: 200px; text-align: left;">
							파일 없음
						</td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<div style="display:flex; justify-content : flex-end;">
			<div>
				<button type="button" onclick="location.href='board.jsp'" class="btn btn-primary me-2">목록</button>
			</div>
			<%
				if (userId != null && userId.equals(vo.getUserID())) {
			%>
					<div>
						<button type="button" onclick="location.href='update<%=level%>.jsp?boardID=<%= boardID %>'" class="btn btn-primary me-2">수정</button>
					</div>
					<div>
						<button type="button" onclick="alert('정말로 삭제하시겠습니까?'); location.href='deleteAction.jsp?boardID=<%= boardID %>'" class="btn btn-primary me-2">삭제</button>
					</div>
			<%
				}
			%>	
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>