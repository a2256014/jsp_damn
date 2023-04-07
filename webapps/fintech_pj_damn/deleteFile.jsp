<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.*"%>
<%
    PrintWriter script = response.getWriter();
    
    String fileName = request.getParameter("fName"); //지울 파일명
    String fileDir = "/images"; //지울 파일이 존재하는 디렉토리
    String filePath = request.getRealPath(fileDir) + "/"; //파일이 존재하는 실제경로

    filePath += fileName;

    File f = new File(filePath); // 파일 객체생성
    if( f.exists()) f.delete(); // 파일이 존재하면 파일을 삭제한다.

    script.println("<script>");
    script.println("location.href = 'board.jsp'");
    script.println("</script>");
%>

