<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.util.ArrayList" %>
<%@include file="header.jsp"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>fintech_pj</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<% 
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		String Rlevel = level;
		if(level.equals("")){
			Rlevel = "1";
		}
	%>
	<div class="container">
		<div class="row" style="margin-top: 50px;">
			<form method="post" name="order" action="orderAction.jsp" style="display: flex; justify-content: right; ">
				<table style="width: 80%;">
					<tr><td>
						<select class="form-control" name="orderField">
							<option value="boardId">��ȣ</option>
							<option value="boardTitle">����</option>
							<option value="userID">�ۼ���</option>
						</select>
						</td>
						<td>
						<select class="form-control" name="orderType">
							<option value="asc">��������</option>
							<option value="desc">��������</option>
						</select>
						</td>
						<input type=hidden value=<%=level%> name="level">
						<td><button type="submit" class="btn btn-success">����</button></td>
					</tr>
				</table>
			</form>
			<form method="post" name="search" action="searchAction.jsp" style="display: flex; justify-content: right; ">
				<table style="width: 100%;">
					<tr >
						<td>��¥</td>
						<td>
							<input type="date" class="form-control" name="fromdate">
						</td>
						<td><h1>~</h1></td>
						<td>
							<input type="date" class="form-control" name="todate">
						</td>
						<td></td>
						<td><select class="form-control" name="searchField">
								<option value="boardTitle">����</option>
								<option value="userID">�ۼ���</option>
						</select></td>
						<td><input type="text" class="form-control" style="width:400px"
							placeholder="�˻��� �Է�" name="searchText" maxlength="300"></td>
						<input type=hidden value=<%=level%> name="level">
						<td><button type="submit" class="btn btn-success">�˻�</button></td>
					</tr>
				</table>
			</form>

				<%	
					
					BoardDao dao = new BoardDao();
					if (request.getParameter("searchField") == null && request.getParameter("orderField") == null) { 
				%>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">��ȣ</th>
							<th style="background-color: #eeeeee; text-align: center;">����</th>
							<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
							<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
						</tr>
					</thead>
				<tbody>				
					<%
						ArrayList<BoardVo> list = dao.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getBoardID() %></td>
						<td><a href="view.jsp?boardID=<%= list.get(i).getBoardID() %>"><%= list.get(i).getBoardTitle() %></a></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBoardDate().substring(0, 11) + list.get(i).getBoardDate().substring(11, 13) + "��" + list.get(i).getBoardDate().substring(14, 16) + "�� " %></td>
					</tr>
					<%		
						}
					%>
				</tbody>
				</table>
				<% 
						if (pageNumber != 1) {
					%>
						<div class="text-start">
							<button type="button" onclick="location.href='board.jsp?pageNumber=<%=pageNumber + 1%>'" class="btn btn-primary me-2">����</button>
						</div>
					<%
						} if (dao.nextPage(pageNumber + 1)) {
					%>
						<div class="text-start">
							<button type="button" onclick="location.href='board.jsp?pageNumber=<%=pageNumber + 1%>'" class="btn btn-primary me-2">����</button>
						</div>
					<%
						}
					%>
				<%
					} else if(request.getParameter("searchField") != null && request.getParameter("orderField") == null) {		
				%>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">��ȣ</th>
							<th style="background-color: #eeeeee; text-align: center;">����</th>
							<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
							<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
						</tr>
					</thead>
				<tbody>				
					<%
						String fromDate = request.getParameter("fromdate");
						String toDate = request.getParameter("todate");
						String searchField = request.getParameter("searchField");
						String searchText = request.getParameter("searchText");
						ArrayList<BoardVo> vo_list = new ArrayList<>();

						vo_list = dao.search(fromDate, toDate, searchField, searchText, Rlevel);
						for (int i = 0; i < vo_list.size(); i++) {
							String day = vo_list.get(i).getBoardDate();
							if(day == null){
								day = "0000-00-00 00:00:00";
							}
					%>
					<tr>
						<td><%= vo_list.get(i).getBoardID() %></td>
						<td><a href="view.jsp?boardID=<%= vo_list.get(i).getBoardID() %>"><%= vo_list.get(i).getBoardTitle() %></a></a></td>
						<td><%= vo_list.get(i).getUserID() %></td>
						<td><%= day.substring(0, 11) + day.substring(11, 13) + "��" + day.substring(14, 16) + "�� " %></td>
					</tr>
					<%		
						}
					%>
				</tbody>
				</table>
				<%
					} else {
				%>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">��ȣ</th>
							<th style="background-color: #eeeeee; text-align: center;">����</th>
							<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
							<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
						</tr>
					</thead>
				<tbody>	
				<%
					String orderField = request.getParameter("orderField");
					String orderType = request.getParameter("orderType");
					ArrayList<BoardVo> order_list = new ArrayList<>();
					order_list = dao.getOrder(orderField, orderType, Rlevel);
					
					for (int i = 0; i < order_list.size(); i++) {
						BoardVo vo = new BoardVo();
						vo = order_list.get(i);
				%>
					<tr>
						<td><%= vo.getBoardID() %></td>
						<td><a href="view.jsp?boardID=<%= vo.getBoardID() %>"><%= vo.getBoardTitle() %></a></td>
						<td><%= vo.getUserID() %></td>
						<td><%= vo.getBoardDate().substring(0, 11) + vo.getBoardDate().substring(11, 13) + "��" + vo.getBoardDate().substring(14, 16) + "�� " %></td>
					</tr>
				<%
					}
				%>
				</tbody>
				</table>
				<%
					}
				%>
			<div class="text-end">
				<button type="button" onclick="location.href='write.jsp'" class="btn btn-primary me-2">�۾���</button>
			</div>
		</div>
	</div>
	
	<script src="js/bootstrap.js"></script>
</body>
</html>
