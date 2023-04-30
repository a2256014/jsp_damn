<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.*"%>
<%
    PrintWriter script = response.getWriter();
    
    int boardID = Integer.parseInt(request.getParameter("BoardId"));
    String fileName = request.getParameter("fName"); //지울 파일명
    String extension = fileName.substring(fileName.lastIndexOf("."));
    String encryptedFile = AESUtil.encrypt(fileName.substring(0, fileName.lastIndexOf(".")),boardID) + extension;

    String fileDir = "/upload"; //지울 파일이 존재하는 디렉토리
    String filePath = request.getRealPath(fileDir) + "/"; //파일이 존재하는 실제경로

    String filePath1 = filePath + fileName;
    String filePath2 = filePath + encryptedFile;

    File f1 = new File(filePath1); // 파일 객체생성
    File f2 = new File(filePath2);
    if( f1.exists()) f1.delete(); // 파일이 존재하면 파일을 삭제한다.
    if(f2.exists()) f2.delete();

    script.println("<script>");
    script.println("alert('삭제 완료 : "+fileName+"')");
    script.println("location.href = 'board.jsp'");
    script.println("</script>");
%>

