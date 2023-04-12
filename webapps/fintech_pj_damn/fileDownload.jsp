<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="fintech_pj_damn.*" %>
<% request.setCharacterEncoding("EUC-KR"); %>

<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<%
	String level = null;
	if(session.getAttribute("level") != null){
		level = (String) session.getAttribute("level");
	}
	if(level == null || level.equals("")) level = "1";
%>
<body>
	<%
		String path = request.getSession().getServletContext().getRealPath("/images");
		String SfName = request.getParameter("fName");
		String CfName = new String(SfName.getBytes("utf-8"), "8859_1");
		File file = new File(path + "/" + SfName);
	try{
		if(level.equals("1")){
			FileInputStream in = new FileInputStream(path + "/" + SfName);

			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=" + CfName);

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
		}else if(level.equals("2")){
			boolean Attack = false;
			out.println(SfName);
			final String regex="(\\.\\.|\\|\\/)";
			final Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
			final Matcher matcher = pattern.matcher(SfName);
			if(matcher.find()){
				Attack = true;
			}
			if(!Attack){
				FileInputStream in = new FileInputStream(path + "/" + SfName);

				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition", "attachment; filename=" + CfName);

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
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이상한 거 다운받지 마ㅡㅡ;')");
				script.println("history.back()");
				script.println("</script>");
			}
			
		}else if(level.equals("3")){
			FileInputStream in = new FileInputStream(path + "/" + SfName);

			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=" + CfName);

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
		}else if(level.equals("max")){
			FileInputStream in = new FileInputStream(path + "/" + SfName);

			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=" + CfName);

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
		}
	}catch(Exception e){
		PrintWriter script = response.getWriter();
		e.printStackTrace();
		script.println("<script>");
		script.println("alert('이상한 거 다운받지 마ㅡㅡ;')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>