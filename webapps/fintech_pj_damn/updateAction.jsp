<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
		if(level.equals("")) level = "1";

		int boardID = 0;
		if (request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
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
		String encryptedFileName = AESUtil.encrypt(nameWithoutExtension,boardID) + extension;
		
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
		String content_Type = mr.getContentType("fName");
//		String ext = fName.substring(fName.lastIndexOf(".") + 1);

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
		}
		if (boardID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��ȿ���� �ʴ� ���Դϴ�.')");
			script.println("location.href = 'board.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		
		if (boardTitle == null || boardContent == null
				|| boardTitle == "" || boardContent == ""){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�Է��� �ȵ� ������ �ֽ��ϴ�.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BoardDao dao = new BoardDao();
				BoardVo vo = new BoardVo();
				vo = dao.getBoardVo(boardID);
				
				int result = dao.update(boardID, boardTitle, boardContent, fName, content_Type, level);
				if(result == 0){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�����������Ѥ�;')");
					script.println("history.back()");
					script.println("</script>");
				} else if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�� ������ ���� �߽��ϴ�.')");
					script.println("history.back()");
					script.println("</script>");
				} else if (result == -2){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�̻��Ѱ� ���ε� ������ �Ѥ�;')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					String curF = vo.getFName();

					if(curF!=null && !curF.equals(fName)){
						script.println("<script>");
						script.println("location.href = 'deleteFile.jsp?fName="+curF+"&BoardId="+boardID+"'");
						script.println("alert('�� ����1�� ���� �߽��ϴ�.')");
						script.println("</script>");
					}else{
						script.println("<script>");
						script.println("alert('�� ����2�� ���� �߽��ϴ�.')");
						script.println("location.href = 'board.jsp'");
						script.println("</script>");
					}
				}
				
		}		
	%>
</body>
</html>