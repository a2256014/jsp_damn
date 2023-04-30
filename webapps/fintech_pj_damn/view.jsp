<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.util.ArrayList" %>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
			script.println("alert('��ȿ���� �ʴ� ���Դϴ�.')");
			script.println("location.href = 'board.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		BoardVo vo = new BoardDao().getBoardVo(boardID);
		CommentDao dao = new CommentDao();
    	ArrayList<CommentVo> comments = dao.getComments(boardID);
	%>
	<div class="container">
		<div class="row" style="margin-top: 50px;">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">�Խ��� �ۺ���</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">������</td>
						<td colspan="2"><%= vo.getBoardTitle() %></td>
					</tr>
					<tr>
						<td>�ۼ���</td>
						<td colspan="2"><%= vo.getUserID() %></td>
					</tr>
					<tr>
						<td>�ۼ�����</td>
						<td colspan="2"><%= vo.getBoardDate().substring(0, 11) + vo.getBoardDate().substring(11, 13) + "��" + vo.getBoardDate().substring(14, 16) + "�� " %></td>
					</tr>
					<tr>
						<td>����</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= vo.getBoardContent() %></td>
					</tr>
					<% if(vo.getFName() != null) { %>
					<tr>
						<td>����</td>
						<td colspan="2" style="min-height: 200px; text-align: left;">
							<%= vo.getFName()%>
							<button type="button" onclick="location.href='fileDownload.jsp?fName=<%= vo.getFName()%>&BoardId=<%=boardID%>'" class="btn btn-primary me-2">���� �ٿ�ε�</button>
						</td>
					</tr>
					<%} else {%>
					<tr>
						<td>����</td>
						<td colspan="2" style="min-height: 200px; text-align: left;">
							���� ����
						</td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<div style="display:flex; justify-content : flex-end;">
			<div>
				<button type="button" onclick="location.href='board.jsp'" class="btn btn-primary me-2">���</button>
			</div>
			<%
				if (userId != null && userId.equals(vo.getUserID())) {
			%>
					<div>
						<button type="button" onclick="location.href='update.jsp?boardID=<%= boardID %>'" class="btn btn-primary me-2">����</button>
					</div>
					<div>
						<button type="button" onclick="alert('������ �����Ͻðڽ��ϱ�?'); location.href='deleteAction.jsp?boardID=<%= boardID %>'" class="btn btn-primary me-2">����</button>
					</div>
			<%
				}
			%>	
			</div>
		</div>
	</div>
	<div class="container">
	<table class="table" style="margin-top : 20px;">
		<thead>
			<tr class="table-primary">
				<th scope="col">�ۼ���</th>
				<th scope="col">�ۼ���</th>
				<th scope="col">����</th>
				<th scope="col">���</th>
			</tr>
		</thead>
		<tbody>
			<% for (CommentVo comment : comments) { %>
				<%
					// ��б� ó��
					String isSecret = null;
					if(comment.getisSecret() != null){
						isSecret = comment.getisSecret();
					}
					boolean isAuthorized = false; // ��й�ȣ ���� ����
					boolean isAuthor = comment.getuserID().equals(userId); // �ۼ��� ����
					boolean isboardAuthor = vo.getUserID().equals(userId);
					if (isSecret != null) {
						String password = request.getParameter("password_" + comment.getCommentID());
						if (password != null && password.equals(isSecret)) {
							// ��й�ȣ�� ��ġ�ϸ� ���� ������ ǥ���Ѵ�
							isAuthorized = true;
						}
					} else {
						// �Ϲ� ����̸� ���� ������ ǥ���Ѵ�
						isAuthorized = true;
					}
				%>
				<tr class="table-info">
					<td><%= comment.getuserID() %></td>
					<td><%= comment.getCommentDate() %></td>
					<td style="word-break: break-all;">
						<% if (isAuthorized || isAuthor || isboardAuthor) { %>
							<%= comment.getComment() %>
							<%if(isSecret!=null){%>
								<i class="fas fa-lock"></i>
							<%}%>
						<% } else { %>
							<form method="post" action="view.jsp?boardID=<%=boardID%>">
								<input type="hidden" name="commentId" value="<%= comment.getCommentID() %>">
								<input type="hidden" name="action" value="show">
								<div class="input-group">
									<input type="password" class="form-control" name="password_<%= comment.getCommentID() %>" placeholder="��й�ȣ�� �Է��ϼ���" aria-label="��й�ȣ �Է�">
									<button class="btn btn-primary" type="submit">Ȯ��</button>
								</div>
							</form>
						<% } %>
					</td>
					<td>

      <% if (isSecret!=null && (!isboardAuthor)) { %>
        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#passwordModal<%= comment.getCommentID() %>">
          ����
        </button>
        <!-- Password Modal -->
        <div class="modal fade" id="passwordModal<%= comment.getCommentID() %>" tabindex="-1" aria-labelledby="passwordModalLabel<%= comment.getCommentID() %>" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="passwordModalLabel<%= comment.getCommentID() %>">��д�� ����</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <form method="post" action="commentDeleteAction.jsp">
                <input type="hidden" name="boardId" value="<%= boardID %>">
				<input type="hidden" name="userId" value="<%= vo.getUserID() %>">
                <input type="hidden" name="commentId" value="<%= comment.getCommentID() %>">
                <div class="modal-body">
                  <div class="mb-3">
                    <label for="password_<%= comment.getCommentID() %>" class="form-label">��й�ȣ</label>
                    <input type="password" class="form-control" id="password_<%= comment.getCommentID() %>" name="password" required>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="submit" class="btn btn-primary">����</button>
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">���</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      <% } else { %>
			<form method="post" action="commentDeleteAction.jsp">
			<input type="hidden" name="boardId" value="<%= boardID %>">
			<input type="hidden" name="userId" value="<%= vo.getUserID() %>">
			<input type="hidden" name="commentId" value="<%= comment.getCommentID() %>">
			<button type="submit" class="btn btn-danger">����</button>
			</form>
      <% } %>
				</tr>
			<% } %>
		</tbody>
	</table>
	</div>
	<div class="container">
		<div class="card" style="margin-top : 20px">
		<form method="post" action="commentWriteAction.jsp">
			<div class="card-body"><textarea class="form-control" name="Bcomment" placeholder="��� ����" row="1"></textarea></div>
			<div class="card-footer" style="display: flex; justify-content: space-between;">
				<div style="display: flex; flex-direction: column;">
					<div class="form-check form-switch">
						<input class="form-check-input" type="checkbox" name="isCheck" id="flexSwitchCheckDefault">
						<label class="form-check-label" for="flexSwitchCheckDefault">��д��</label>
					</div>
					<div class="password" style="display: none">
						<input type="password" name="isSecret" class="form-control" placeholder="��й�ȣ�� �Է��ϼ���">
					</div>
					<input type="hidden" name="boardID" value="<%=boardID%>">
				</div>
				<input type="submit" class="btn btn-primary pull-right" value="��۾���">
			</div>
		</form>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			$('#flexSwitchCheckDefault').change(function() {
			if (this.checked) {
				$('.password').show();
			} else {
				$('.password').hide();
			}
			});
		});
		window.addEventListener('load', function() {
			var checkbox = document.getElementById('flexSwitchCheckDefault');
			checkbox.checked = false;
		  });
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>