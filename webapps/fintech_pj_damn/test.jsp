<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.regex.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<body>
<%
    boolean fileAttack = false;

    final String fileRegex="(\\.php|\\.jsp|\\.java)";

    final Pattern filePattern = Pattern.compile(fileRegex, Pattern.CASE_INSENSITIVE);

    final Matcher fileMatcher = filePattern.matcher("webshell.jsp");

    out.println(fileMatcher.find());
%>
<%
    String path = request.getSession().getServletContext().getRealPath("/images");
    out.println(path);
    
    try (FileInputStream inputStream = new FileInputStream(path+"/webshell.jpg")) {
            byte[] buffer = new byte[3];
            int bytesRead = inputStream.read(buffer);

            if (bytesRead >= 3) {
                out.println(buffer[0]);
                out.println(buffer[1]);
                out.println(buffer[2]);
                if (buffer[0] == (byte) 0xFF && buffer[1] == (byte) 0xD8 && buffer[2] == (byte) 0xFF) {
                    out.println("File is a JPEG image.");
                } else {
                    out.println("File is not a JPEG image.");
                }
            } else {
                out.println("Unable to determine file type.");
            }
        } catch (IOException ex) {
            out.println("error");
        }
    
%>
</body>
</html>