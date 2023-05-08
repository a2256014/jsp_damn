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
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("history.back()");
        script.println("</script>");
    }

    UserVo vo = new UserVo();
    UserGetDao dao = new UserGetDao();
    Cookie[] cookielist = request.getCookies(); // 쿠키 배열 가져오기
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
        script.println("alert('비정상적인 접근입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }

    
%>
<body>
	<div class="container">
		<div class="jumbotron">
			<div class="container" style="text-align: center;  margin-top: 100px;">
				<div> 아이디 : <%=vo.getId()%> </div>
                <div> 이름 : <%=vo.getUserName()%> </div>
                <div> 이메일 : <%=vo.getEmail()%> </div>
                <div> 핸드폰 : <%=vo.getPhoneNum()%> </div>
                <div> 권한 : <%=vo.getPrivilege()%> </div>
			</div>
		</div>
	</div>
  </div>
</body>
</html>