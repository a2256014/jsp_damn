<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<body>
	<%
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("history.back()");
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
		
		BoardDao dao = new BoardDao();
		BoardVo vo = new BoardVo();
		vo = dao.getBoardVo(boardID);
		int result = dao.delete(boardID);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패 했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 성공 했습니다.')");
			if(vo.getFName()==null){
				script.println("location.href = 'board.jsp'");
			}else{
				script.println("location.href = 'deleteFile.jsp?fName="+vo.getFName()+"'");
			}
			script.println("</script>");
		}				
				
	%>
</body>
</html>