<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.*"%>
<%
    PrintWriter script = response.getWriter();
    
    int boardID = Integer.parseInt(request.getParameter("BoardId"));
    String fileName = request.getParameter("fName"); //���� ���ϸ�
    String extension = fileName.substring(fileName.lastIndexOf("."));
    String encryptedFile = AESUtil.encrypt(fileName.substring(0, fileName.lastIndexOf(".")),boardID) + extension;

    String fileDir = "/upload"; //���� ������ �����ϴ� ���丮
    String filePath = request.getRealPath(fileDir) + "/"; //������ �����ϴ� �������

    String filePath1 = filePath + fileName;
    String filePath2 = filePath + encryptedFile;

    File f1 = new File(filePath1); // ���� ��ü����
    File f2 = new File(filePath2);
    if( f1.exists()) f1.delete(); // ������ �����ϸ� ������ �����Ѵ�.
    if(f2.exists()) f2.delete();

    script.println("<script>");
    script.println("alert('���� �Ϸ� : "+fileName+"')");
    script.println("location.href = 'board.jsp'");
    script.println("</script>");
%>

