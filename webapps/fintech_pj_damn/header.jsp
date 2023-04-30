<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/fintech_pj_damn/js/popper.min.js" charset="UTF-8"></script>
<script src="/fintech_pj_damn/js/bootstrap.bundle.js"></script>
<script src="/fintech_pj_damn/js/bootstrap.js"></script>
<title>fintech_pj_damn</title>
</head>
<%
    String wsUrl = "ws://localhost:8000/fintech_pj_damn/websocket";

	Cookie[] cookies = request.getCookies();
    String XSS = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("XSS")) {
                XSS = cookie.getValue();
                break;
            }
        }
    }
%>
<script>
    var websocket = new WebSocket("<%= wsUrl %>");

    websocket.onopen = function(event) {
        console.log("WebSocket connected.");
    };

    websocket.onmessage = function(event) {
        console.log("Received message: " + event.data);
    };

    websocket.onclose = function(event) {
        console.log("WebSocket disconnected.");
    };

    websocket.onerror = function(event) {
        console.error("WebSocket error: " + event.data);
    };
</script>
<script>
    // 서버에서 메시지 받기
    websocket.onmessage = function(event) {
        console.log("Received message: " + event.data);
		// 받은 메시지를 JSON 객체로 변환
		var message = JSON.parse(event.data);

		// 메시지 중 privilege가 변경된 경우
		if (message.type == "csrfChanged" && message.csrf == 0) {
			// 페이지 새로고침
			location.reload();
		}
    };
</script>

<body>
	<% 
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}

		String level = null;
		if(session.getAttribute("level") != null){
			level = (String) session.getAttribute("level");
		}else{
			session.setAttribute("level","");
		}
	
		String privilege = null;
		if(session.getAttribute("privilege") != null){
			privilege = (String) session.getAttribute("privilege");
		}

		int csrf = 0;
		if(session.getAttribute("csrf") != null){
			csrf = (int) session.getAttribute("csrf");
		}

		String IP = null;
		if(session.getAttribute("IP") != null){
			IP = (String) session.getAttribute("IP");
		}

%>
<%if(csrf == 1){%>
	<%@include file="success.jsp"%>
	<script>
		setTimeout(function() {
    	<% session.setAttribute("csrf",0); %>
		location.reload();
  		}, 5000);
	</script>
<%}%>
	<header class="p-3 text-bg-dark">
   

	<div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="/fintech_pj_damn" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-pc-display-horizontal" viewBox="0 0 16 16">
				<path d="M1.5 0A1.5 1.5 0 0 0 0 1.5v7A1.5 1.5 0 0 0 1.5 10H6v1H1a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1v-3a1 1 0 0 0-1-1h-5v-1h4.5A1.5 1.5 0 0 0 16 8.5v-7A1.5 1.5 0 0 0 14.5 0h-13Zm0 1h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-7a.5.5 0 0 1 .5-.5ZM12 12.5a.5.5 0 1 1 1 0 .5.5 0 0 1-1 0Zm2 0a.5.5 0 1 1 1 0 .5.5 0 0 1-1 0ZM1.5 12h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1ZM1 14.25a.25.25 0 0 1 .25-.25h5.5a.25.25 0 1 1 0 .5h-5.5a.25.25 0 0 1-.25-.25Z"/>
			</svg>
        </a>
		<%	if(level == null || level.equals("")){%>
				<h5 style="margin-right:15px; margin-left:20px">level = 1</h5>
		<%	}else{%>
			<h5 style="margin-right:15px; margin-left:20px">level = <%=level%></h5>
			<%}%>
        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0" style="padding-left: 20px;">
          <li><a href="/fintech_pj_damn" class="nav-link px-2 text-white">메인</a></li>
          <li><a href="board.jsp" class="nav-link px-2 text-white">게시판</a></li>
		  <li><a href="user_list.jsp" class="nav-link px-2 text-white">유저정보</a></li>
		  <%if(csrf != 0){%>
		  	<li><a href="csrf.jsp" class="nav-link px-2 text-red">CSRF성공</a></li>
		  <%}else{%>
			<li><a href="csrf.jsp" class="nav-link px-2 text-white">CSRF해줘</a></li>
		  <%}%>
		   <li><a href="levelChange.jsp" class="nav-link px-2 text-white">Level 변경</a></li>
        </ul>
		
		<% 
			if (userId == null) {
		%>
        <div class="text-end">
          <button type="button" onclick="location.href='login.jsp'" class="btn btn-outline-light me-2">Login</button>
          <button type="button" onclick="location.href='signup.jsp'" class="btn btn-outline-light me-2">Sign-up</button>
        </div>
		<% 		
			} else {
		%>
		<%if(IP != null){%>
			<div style="padding-right : 10px;">접속 = <%=IP%></div>
		<%}%>
		<%if(privilege.equals("ADMIN") || privilege.equals("Admin")){%>
			<div style="padding-right : 10px; color: red;">권한 = <%= privilege%></div>
		<%}else if(privilege.equals("Human") || privilege.equals("NORMAL")){%>
			<div style="padding-right : 10px; color: yellow;">권한 = <%= privilege%></div>
		<%}else{%>
			<div style="padding-right : 10px; color: gray;">권한 = <%= privilege%></div>
		<%}%>
		
		<div class="dropdown">
		  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			<%=userId%>
		  </button>
		  <ul class="dropdown-menu  mx-0 border-0 shadow w-220px" data-bs-theme="dark">
		  	
			<li>
			  <a class="dropdown-item d-flex gap-2 align-items-center" href="changePass.jsp">
				비밀번호 변경
			  </a>
			</li>
			<li>
				<hr class="dropdown-divider">
			</li>
			<li>
			  <a class="dropdown-item d-flex gap-2 align-items-center" href="logout.jsp">
				로그아웃
			  </a>
			</li>
			<input type="hidden" value=<%=XSS%>/>
		  </ul>
		</div>
		<%		
			}
		%>
		
      </div>
    </div>
	  </header>

</body>
</html>
