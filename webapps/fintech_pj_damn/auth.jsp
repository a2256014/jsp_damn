<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
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
<%
    String auth = null;
    if(request.getParameter("auth") != null){
        auth = request.getParameter("auth");
    }

    if(auth == null || !auth.equals("dGhpc2lzbXlTZWNyZXRBdXRoISE=")){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('인증 후 들어와 주세요.')");
        script.println("location.href = 'captcha.jsp'");
        script.println("</script>");
    }
    
%>
<body>
    <div class="container">
        <div class="jumbotron">
            <div class="container" style="text-align: center;  margin-top: 100px;">
                <h1>인증을 성공하였습니다!</h1>
            </div>
        </div>
    </div>
</body>
</html>