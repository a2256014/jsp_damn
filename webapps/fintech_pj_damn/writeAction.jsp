<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<body>
<%
	String level = null;
	if(session.getAttribute("level") != null){
		level = (String) session.getAttribute("level");
	}
	if(level == null || level.equals("")) level = "1";
	BoardDao dao = new BoardDao();
%>
<%
    String saveDirectory = application.getRealPath("/upload");
    int maxPostSize = 1024 * 1024 * 10;
    String encoding = "EUC-KR";
    DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
    MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
    Enumeration<?> files = mr.getFileNames();

    while (files.hasMoreElements() && level.equals("max")) {
        String fileName = (String) files.nextElement();
        File uploadedFile = mr.getFile(fileName);

        // ���ϸ� ��ȣȭ
        String originalFileName = uploadedFile.getName();
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String nameWithoutExtension = originalFileName.substring(0, originalFileName.lastIndexOf("."));
		String encryptedFileName = AESUtil.encrypt(nameWithoutExtension,dao.getAllNext()) + extension;
		
        // ���� ����
        File savedFile = new File(saveDirectory, encryptedFileName);
        try (FileInputStream in = new FileInputStream(uploadedFile);
             FileOutputStream out1 = new FileOutputStream(savedFile)) {

            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out1.write(buffer, 0, length);
            }
            in.close();
            out1.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

		File f = new File(saveDirectory + "/" + originalFileName); // ���� ��ü����
    	if( f.exists()) f.delete(); // ������ �����ϸ� ������ �����Ѵ�.
    }
%>

	<%
		String userId = null;
		
		String boardTitle = mr.getParameter("boardTitle");
		String boardContent = mr.getParameter("boardContent");
		String fName = mr.getFilesystemName("fName");
		String contentType = mr.getContentType("fName");
		
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�α����� �ϼ���.')");
			script.println("location.href = 'login.jsp'");
			script.println("history.back()");
			script.println("</script>");
		} else {
			if (boardTitle == null || boardContent == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�Է��� �ȵ� ������ �ֽ��ϴ�.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					int result = dao.write(boardTitle, userId, boardContent, fName, contentType, level);
					if(result == 0){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('�����������Ѥ�;')");
						script.println("history.back()");
						script.println("</script>");
					}
					else if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('�۾��⿡ ���� �߽��ϴ�.')");
						script.println("history.back()");
						script.println("</script>");
					}else if (result == -2) {

						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'deleteFile.jsp?fName="+fName+"'");
						script.println("alert('�̻��Ѱ� ���ε� ������ �Ѥ�;')");
						script.println("history.back()");
						script.println("</script>"); 
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'board.jsp'");
						script.println("</script>");
					}
				}
		}		
	%>
</body>
</html>