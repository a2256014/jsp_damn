<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<body>
<%
    String level = null;
	if(session.getAttribute("level") != null){
		level = (String) session.getAttribute("level");
	}
	if(level == null || level.equals("")) level = "1";
    
    String userId = null;
    if (session.getAttribute("userId") != null) {
        userId = (String) session.getAttribute("userId");
    }
	CommentDao dao = new CommentDao();
%>
	<%
		String boardId = request.getParameter("boardId");
        String userID = request.getParameter("userId");
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        String isSecret = request.getParameter("password");

        CommentVo cv = dao.getComment(commentId, isSecret);
        String owner = cv.getuserID();
        out.println("댓글 주인" + owner);
        out.println("글 주인" + userID);
        out.println("요청 주인" + userId);
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("history.back()");
			script.println("</script>");
		} else {
            if(userId.equals(userID) || userId.equals(owner)){
                int result = dao.deleteComment(commentId, userId, isSecret);
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('비밀번호 틀림')");
                    script.println("history.back()");
                    script.println("</script>");
                }
                if(result == 0){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('예상치 못한 오류')");
                    script.println("history.back()");
                    script.println("</script>");
                }
                if(result == 1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('댓글이 삭제되었습니다.')");
                    script.println("location.href='view.jsp?boardID=" + boardId + "'");
                    script.println("</script>");
                }
            }else{
                PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('주인만 지울 수 있습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
            }
				
		}		
	%>
</body>
</html>