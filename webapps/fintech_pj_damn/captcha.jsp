<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
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
    String auth_captcha = null;
    if(request.getParameter("captcha") != null){
        auth_captcha = request.getParameter("captcha");
    }
    String captcha = null;
    if(session.getAttribute("captcha") != null){
        captcha = (String)session.getAttribute("captcha");
    }

    if(auth_captcha!=null && auth_captcha.equals(captcha)){
        String Secret = "thisismySecretAuth!!";
        Secret = Base64.getEncoder().encodeToString(Secret.getBytes());
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'auth.jsp?auth="+ Secret +"'");
        script.println("</script>");
    }else if(auth_captcha!=null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('ƒ∏√≠ π¯»£ ∆≤∏≤.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
<body>
    <div class="container">
        <div class="jumbotron">
            <div class="container" style="text-align: center;  margin-top: 100px;">
                <div class="form-group">
                    <form method="post" name="captcha" action="/fintech_pj_damn/captcha.jsp" style="display: flex;  align-items: center; flex-direction:column;">
                        <label for="captcha" style="display: block">ƒ∏√≠ ¿Œ¡ı </label>
                            <div class="captcha" style="display:flex; justify-content:center;">
                                <div class="captcha_child">
                                    <img id="captchaImg" src="captcha" alt="ƒ∏¬˜ ¿ÃπÃ¡ˆ"/>
                                </div>
                            </div>
                        <input type="text" class="form-control" placeholder="ƒ∏¬˜ ¿‘∑¬" name="captcha" maxlength="6" style="width:300px">
                        <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                            <button type="submit" class="btn btn-warning">¿Œ¡ı«œ±‚</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<style>
.captcha{
    overflow: hidden;
}
.captcha_child{
    float: left;
}
.captcha_child_two{
    float: right;
}
</style>