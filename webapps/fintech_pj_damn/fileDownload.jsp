<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="fintech_pj_damn.*" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>fintech_pj</title>
</head>
<body>
	<%
		String path = request.getSession().getServletContext().getRealPath("/images");
		String fName = request.getParameter("fName");
		File file = new File(path + "/" + fName);
		FileInputStream in = new FileInputStream(path + "/" + fName);

		fName = new String(fName.getBytes("utf-8"), "8859_1");

		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=" + fName);

		out.clear();					
		out = pageContext.pushBody();
	    
	    OutputStream os = response.getOutputStream();
	    
	    int length;
	    byte[] b = new byte[(int)file.length()];

	    while ((length = in.read(b)) > 0) {
	    	os.write(b,0,length);
	    }
	    
	    os.flush();
	    
	    os.close();
	    in.close();
	%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>