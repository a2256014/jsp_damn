<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<title>fintech_pj_damn</title>
</head>
<body>
	<%
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		String id = (String) request.getParameter("userid");
		String curpass = request.getParameter("curpass");
		String prevpass = request.getParameter("prevpass");
	    
		UserGetDao dao = new UserGetDao();
		UserVo vo = null;

		if(userId == null){
			out.println("<script>");
			out.println("alert('�α��� ���ּ���')");
			out.println("location.href='login.jsp'");
			out.println("</script>");
		}else{
			if(!userId.equals(id)){
				out.println("<script>");
				out.println("alert('������ �����ϴ�.')");
				out.println("history.back()");
				out.println("</script>");
			}else{
				vo = dao.getUser(userId,curpass);
				if(vo == null){
					out.println("<script>");
					out.println("alert('�����й�ȣ Ʋ��')");
					out.println("history.back()");
					out.println("</script>");
				}else{
					UserPostDao pdao = new UserPostDao();
					if(pdao.setPass(id, prevpass)){
						out.println("<script>");
						out.println("alert('���� �Ϸ�')");
						out.println("location.href='login.jsp'");
						out.println("</script>");	
					}
					else{
						out.println("<script>");
						out.println("alert('����')");
						out.println("history.back()");
						out.println("</script>");
					}
				}			
			}
		}

	%>
</body>
</html>