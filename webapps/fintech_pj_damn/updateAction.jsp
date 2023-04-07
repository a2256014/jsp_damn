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
		//실제 물리적 경로
 		String saveDirectory=application.getRealPath("/images");
 		
 		//저장 최대 용량 (10M) - 각자 알아서 저장무게를 정하되 너무 무겁지 않도록
 		int maxPostSize= 1024*1024*10;
 		
 		//한글 조합
 		String encoding="EUC-KR";

 		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

 		//사용자가 전송한 텍스트 정보 및 파일을 '/storage'에  저장하기 (MultipartRequest의 매개변수에 맞춰서 위에서 지정한 변수를 넣어준 것)
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
			script.println("alert('로그인을 하세요.')");
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
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		
		if (boardTitle == null || boardContent == null
				|| boardTitle == "" || boardContent == ""){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
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
					script.println("alert('글 수정에 실패 했습니다.')");
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