<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
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
    if(request.getParameter("password") != null){
        String password = request.getParameter("password");
        
        UserVo vo = new UserVo();
        UserGetDao dao = new UserGetDao();
        vo = dao.getUser(userId);
        
        if(BCrypt.checkpw(password,vo.getPassWord())){
            Random random = new Random();
            int randomNumber = random.nextInt(900000) + 100000; // 100000~999999 사이의 난수 생성
            String plainText = Integer.toString(randomNumber); // 생성된 난수를 문자열로 변환
            String encodedText = Base64.getEncoder().encodeToString(plainText.getBytes()); // Base64 인코딩
            Cookie cookie = new Cookie("infoAuth", encodedText);
            cookie.setMaxAge(3600); // 쿠키 유효 기간 설정 (초 단위)
            cookie.setPath("/fintech_pj_damn"); // 쿠키가 적용되는 경로 설정
            response.addCookie(cookie); // 쿠키를 응답 객체에 추가

            session.setAttribute("isAuth", encodedText);

            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href='info.jsp?userId=" + userId + "'");
            script.println("</script>");
        }else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호가 틀렸습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
    }
    
%>
<body>
	<div class="container">
		<div class="jumbotron">
			<div class="container" style="text-align: center;  margin-top: 100px;">
                <h1>비밀번호 인증</h1>
                <form method="post" name="captcha" action="/fintech_pj_damn/infoCheck.jsp" style="display: flex;  align-items: center; flex-direction:column;">
                    <input type="password" class="form-control" placeholder="비밀번호 입력" name="password" maxlength="100" style="width:300px">
                    <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                        <button type="submit" class="btn btn-warning">확인</button>
                    </div>
                </form>
			</div>
		</div>
	</div>
  </div>
</body>
</html>