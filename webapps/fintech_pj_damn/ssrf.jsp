<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<title>fintech_pj</title>
</head>
"
<script src="js/bootstrap.js"></script>
<%!
    private boolean isBlocked(String url) {
        // 차단할 스키마와 호스트 목록
        String[] blockedSchemes = { "file", "ftp", "sftp" };
        String[] blockedHosts = { "localhost", "127.0.0.1", "192.168.100.150" };
        
        try {
            URI uri = new URI(url);
            
            // 스키마와 호스트가 차단 목록에 포함되어 있는지 체크
            String scheme = uri.getScheme();
            String host = uri.getHost();
            
            for(String blockedScheme : blockedSchemes) {
                if(blockedScheme.equalsIgnoreCase(scheme)) {
                    return true;
                }
            }
            
            for(String blockedHost : blockedHosts) {
                if(blockedHost.equalsIgnoreCase(host)) {
                    return true;
                }
            }
        } catch (URISyntaxException e) {
            // 유효하지 않은 URL일 경우 처리할 내용
            System.out.println("Invalid URL.");
            return true;
        }
        
        // 허용할 URL일 경우
        return false;
    }
%>

<%
    String base64ImageData = "";
    String DefaultUrl = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png";
    if(request.getParameter("url")!=null){
        DefaultUrl = request.getParameter("url");
    }
    if(isBlocked(DefaultUrl)) {
        out.println("<script>");
        out.println("alert('허용되지 않는 URL 입니다.')");
        out.println("history.back()");
        out.println("</script>");
    } else {
        String imageUrl = DefaultUrl;
        URL url = new URL(imageUrl);
        InputStream is = url.openStream();
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int length;

        while ((length = is.read(buffer)) != -1) {
            os.write(buffer, 0, length);
        }
        base64ImageData = Base64.getEncoder().encodeToString(os.toByteArray());
    }
%>

<body>
<div class="container">
	<div class="jumbotron">
        
		<div class="container" style="text-align: center;  margin-top: 100px; display: flex; flex-direction:column; justify-content: center; align-items: center;">
            <h2>SSRF 공간</h2>    
            <form method="get" name="ssrf" action="/fintech_pj_damn/ssrf.jsp" style="display: flex;  align-items: center;">
                <input type="text" class="form-control" placeholder="url 입력" name="url" maxlength="100" style="width: 500px">
                <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                    <button type="submit" class="btn btn-warning">사진 받아오기</button>
                </div>
            </form>
        
            <img src="data:image/jpeg;base64,<%=base64ImageData%>"/>
            <div>받아온 URL = <%=DefaultUrl%></div>
        </div>
    </div>
</div>
</body>
</html>
