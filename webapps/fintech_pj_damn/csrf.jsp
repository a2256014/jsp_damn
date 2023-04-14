<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="fintech_pj_damn.*" %>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<title>fintech_pj</title>
</head>
<script src="js/bootstrap.js"></script>
<%
    Cookie[] cookies = request.getCookies();
    String sessionId = null;
    if(cookies != null) {
        for(Cookie cookie : cookies) {
            if(cookie.getName().equals("JSESSIONID")) {
                sessionId = cookie.getValue();
                break;
            }
        }
    }

    csrfVo cv = new csrfVo();
    String csrfToken = cv.getUuid();

    session.setAttribute("csrfToken",csrfToken);
%>
<body>
	<div class="container">
		<div class="jumbotron">
			<div class="container" style="text-align: center;  margin-top: 100px; display: flex; flex-direction:column; justify-content: center; align-items: center;">
				<h1>CSRF</h1>
				<p>Ver.1 = 성공여부 반영</p>
                <p>Ver.2 = GET방식</p>
                <p>Ver.3 = POST방식</p>
                <p>Ver.4 = 토큰검증</p>
                <p>Ver.5 = 2차인증</p>
                <div style="height : 50px">
                <form method="get" name="csrf" action="csrfCheckAction.jsp">
                    <input type="hidden" name="check1" value="<%= userId%>"></input>
                    <input type="hidden" name="check2" value="<%= sessionId%>"></input>
                    <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                        <button type="submit" class="btn btn-warning">CSRF 시도 Ver.1</button>
                    </div>
                </form>
                </div>
                <div style="height : 50px;">
                <form method="get" name="csrf" action="/fintech_pj_damn/csrf" style="display: flex;  align-items: center;">
                    <input type="hidden" name="id" value="<%= userId%>"></input>
                    <select class="form-control" name="privilege" style="width : 140px;">
							<option value="Slave">노예</option>
							<option value="Human">사람</option>
                            <option value="Admin">관리자</option>
					</select>
                    <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                        <button type="submit" class="btn btn-warning">CSRF 시도 Ver.2</button>
                    </div>
                </form>
                </div>
                <div style="height : 50px;">
                <form method="post" name="csrf" action="/fintech_pj_damn/csrf" style="display: flex;  align-items: center;">
                    <input type="hidden" name="id" value="<%= userId%>"></input>
                    <select class="form-control" name="privilege" style="width : 140px;">
							<option value="Slave">노예</option>
							<option value="Human">사람</option>
                            <option value="Admin">관리자</option>
					</select>
                    <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                        <button type="submit" class="btn btn-warning">CSRF 시도 Ver.3</button>
                    </div>
                </form>
                </div>
                <div style="height : 50px;">
                <form method="get" name="csrf" action="/fintech_pj_damn/csrf2" style="display: flex;  align-items: center;">
                    <input type="hidden" name="id" value="<%= userId%>"></input>
                    <input type="hidden" name="csrfToken" value="<%= csrfToken%>"></input>
                    <select class="form-control" name="privilege" style="width : 140px;">
							<option value="Slave">노예</option>
							<option value="Human">사람</option>
                            <option value="Admin">관리자</option>
					</select>
                    <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                        <button type="submit" class="btn btn-warning">CSRF 시도 Ver.4</button>
                    </div>
                </form>
                </div>
                <div style="height : 50px;">
                <form method="post" name="csrf" action="/fintech_pj_damn/csrf2" style="display: flex;  align-items: center;">
                    <input type="hidden" name="id" value="<%= userId%>"></input>
                    <div class="form-group">
                        <label for="captcha" style="display: block">자동 CSRF 방지 </label>
                        <div class="captcha">
                            <div class="captcha_child">
                                <img id="captchaImg" src="captcha" alt="캡차 이미지"/>
                            </div>
                        </div>
                        <input type="text" class="form-control" placeholder="캡차 입력" name="captcha" maxlength="6">
                    </div>
						
                    <select class="form-control" name="privilege" style="width : 140px;">
							<option value="Slave">노예</option>
							<option value="Human">사람</option>
                            <option value="Admin">관리자</option>
					</select>
                    <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                        <button type="submit" class="btn btn-warning">CSRF 시도 Ver.5</button>
                    </div>
                    
                </form>
                </div>
			</div>
		</div>
	</div>
	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style="width: 100%; display: flex; justify-content: center; align-items: center;">
    <div class="carousel-inner" style="width: 50%; display: flex; justify-content: center; align-items: center;" id="name"></div>
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