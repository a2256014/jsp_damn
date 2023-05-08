<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ page import="fintech_pj_damn.*" %>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<title>fintech_pj</title>
</head>
<script src="js/bootstrap.js"></script>
"
<%
    if (userId == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('�α����� �ϼ���.')");
        script.println("location.href = 'login.jsp'");
        script.println("history.back()");
        script.println("</script>");
    }

    UserVo vo = new UserVo();
    UserGetDao dao = new UserGetDao();
    Cookie[] cookielist = request.getCookies(); // ��Ű �迭 ��������
    String isAuth = null;

    if (cookielist != null) {
        for (Cookie cookie : cookielist) {
            if (cookie.getName().equals("infoAuth")) { 
                String cookieValue = cookie.getValue();
                isAuth = cookieValue;
            }
        }
    }

    String userIdInfo = null;
    if(request.getParameter("userId") != null){
        userIdInfo = request.getParameter("userId");
    }

    String sIsAuth = null;
    if(session.getAttribute("isAuth") != null){
        sIsAuth = (String)session.getAttribute("isAuth");
    }

    if(sIsAuth != null && sIsAuth.equals(isAuth)){
        vo = dao.getUser(userIdInfo);
    }else{
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('���������� �����Դϴ�.')");
        script.println("history.back()");
        script.println("</script>");
    }

    
%>
<body>
	<div class="container">
		<div class="jumbotron">
			<div class="container" style="text-align: center;  margin-top: 100px;">
				<div> ���̵� : <%=vo.getId()%> </div>
                <div> �̸� : <%=vo.getUserName()%> </div>
                <div> �̸��� : <%=vo.getEmail()%> </div>
                <div> �ڵ��� : <%=vo.getPhoneNum()%> </div>
                <div> ���� : <%=vo.getPrivilege()%> </div>
			</div>
		</div>
	</div>
  </div>
</body>
</html>