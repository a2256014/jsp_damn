<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="fintech_pj_damn.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<body>
<%
		//���� ������ ���
 		String saveDirectory=application.getRealPath("/images");
 		
 		//���� �ִ� �뷮 (10M) - ���� �˾Ƽ� ���幫�Ը� ���ϵ� �ʹ� ������ �ʵ���
 		int maxPostSize= 1024*1024*10;
 		
 		//�ѱ� ����
 		String encoding="EUC-KR";

 		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

 		//����ڰ� ������ �ؽ�Ʈ ���� �� ������ '/storage'��  �����ϱ� (MultipartRequest�� �Ű������� ���缭 ������ ������ ������ �־��� ��)
 		MultipartRequest mr=new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
%>
	<%
		String userId = null;

		String boardTitle = mr.getParameter("boardTitle");
		String boardContent = mr.getParameter("boardContent");
		String fName = mr.getFilesystemName("fName");
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

		int boardID = 0;
		if (request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
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
				
				int result = dao.update(boardID, boardTitle, boardContent, fName);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�� ������ ���� �߽��ϴ�.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					String curF = vo.getFName();

					if(curF!=null && !curF.equals(fName)){
						script.println("<script>");
						script.println("location.href = 'deleteFile.jsp?fName="+curF+"'");
						script.println("</script>");
					}else{
						script.println("<script>");
						script.println("location.href = 'board.jsp'");
						script.println("</script>");
					}
				}
				
		}		
	%>
</body>
</html>