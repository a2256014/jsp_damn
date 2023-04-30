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
		String Bcomment = request.getParameter("Bcomment");
        String isCheck = request.getParameter("isCheck");
        int boardID = Integer.parseInt(request.getParameter("boardID"));
        
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�α����� �ϼ���.')");
			script.println("location.href = 'login.jsp'");
			script.println("history.back()");
			script.println("</script>");
		} else {
			if (Bcomment.equals("")) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�Է��� �ȵ� ������ �ֽ��ϴ�.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
                    String isSecret = null;
                    if(isCheck!=null && isCheck.equals("on")){
                        isSecret = request.getParameter("isSecret");
                    }
                    int result = dao.addComment(boardID, userId, Bcomment, isSecret);

                    if(result == 0){
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('����ġ ���� ����')");
                        script.println("history.back()");
                        script.println("</script>");
                    }
                    if(result == 1){
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('����� �ۼ��Ǿ����ϴ�.')");
                        script.println("location.href='view.jsp?boardID=" + boardID + "'");
                        script.println("</script>");
                    }
				}
		}		
	%>
</body>
</html>