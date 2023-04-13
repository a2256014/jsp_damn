<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.PrintWriter" %>

<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<body>
	<%
		String userId = request.getParameter("check1");			
		String sessionId = request.getParameter("check2");

        String accessToken = (String) session.getAttribute("privilege");
        String realSessionId = (String) session.getId();
        out.println(userId + " " +  sessionId + " " + accessToken);

        if(accessToken.equals("ADMIN")){
            Cookie[] cookies = request.getCookies();
            
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("JSESSIONID")) {
                        cookie.setValue(sessionId);
                        response.addCookie(cookie);
                        break;
                    }
                }
            }

            PrintWriter script = response.getWriter();
			script.println("<script>");
            script.println("location.href = 'csrfAction.jsp?token="+ realSessionId +"'");
			script.println("</script>");
        }else{
            PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('너 관리자 아닌데?')");
			script.println("history.back()");
			script.println("</script>");
        }


	%>
</body>
</html>