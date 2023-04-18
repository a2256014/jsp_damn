<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.regex.*" %>
<%@ page import="java.io.*, java.util.regex.*" %>

<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<body>
<%
    final String fileRegex="(application|octet-stream)";
    final Pattern filePattern = Pattern.compile(fileRegex, Pattern.CASE_INSENSITIVE);
    final Matcher fileMatcher = filePattern.matcher("application/octet-stream");
    out.println(fileMatcher.find());
%>
</body>
</html>