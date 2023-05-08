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
            int randomNumber = random.nextInt(900000) + 100000; // 100000~999999 ������ ���� ����
            String plainText = Integer.toString(randomNumber); // ������ ������ ���ڿ��� ��ȯ
            String encodedText = Base64.getEncoder().encodeToString(plainText.getBytes()); // Base64 ���ڵ�
            Cookie cookie = new Cookie("infoAuth", encodedText);
            cookie.setMaxAge(3600); // ��Ű ��ȿ �Ⱓ ���� (�� ����)
            cookie.setPath("/fintech_pj_damn"); // ��Ű�� ����Ǵ� ��� ����
            response.addCookie(cookie); // ��Ű�� ���� ��ü�� �߰�

            session.setAttribute("isAuth", encodedText);

            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href='info.jsp?userId=" + userId + "'");
            script.println("</script>");
        }else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('��й�ȣ�� Ʋ�Ƚ��ϴ�.')");
            script.println("history.back()");
            script.println("</script>");
        }
    }
    
%>
<body>
	<div class="container">
		<div class="jumbotron">
			<div class="container" style="text-align: center;  margin-top: 100px;">
                <h1>��й�ȣ ����</h1>
                <form method="post" name="captcha" action="/fintech_pj_damn/infoCheck.jsp" style="display: flex;  align-items: center; flex-direction:column;">
                    <input type="password" class="form-control" placeholder="��й�ȣ �Է�" name="password" maxlength="100" style="width:300px">
                    <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                        <button type="submit" class="btn btn-warning">Ȯ��</button>
                    </div>
                </form>
			</div>
		</div>
	</div>
  </div>
</body>
</html>