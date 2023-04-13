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
        String sessionId = session.getId();
		session.setAttribute("csrf", 1);
        String realSessionId = (String) request.getParameter("token");

        Cookie[] cookies = request.getCookies();
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("JSESSIONID")) {
                    cookie.setValue(realSessionId);
                    response.addCookie(cookie);
                    break;
                }
            }
        }

        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('당했지 이자식아 ㅋ')");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
	%>
</body>
</html>