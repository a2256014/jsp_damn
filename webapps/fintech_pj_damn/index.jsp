<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<title>fintech_pj</title>
</head>
<script src="js/bootstrap.js"></script>
<script>
  function showImg() {
        var name = decodeURIComponent(document.location.hash.substr(1));
        var el = document.getElementById("name");
        if(name == ""){
          name = "su1.png";
        }
        el.innerHTML = "<img src='images/"+ name +"' />";
      }
  window.addEventListener("hashchange", function() {
    showImg();
  });
</script>
<body onload="showImg()">
	<div class="container">
		<div class="jumbotron">
			<div class="container" style="text-align: center;  margin-top: 100px;">
				<h1>웹 사이트 소개</h1>
				<p>이 웹사이트는 JSP로 만든 사이트로 취약점을 공부하기 위해 개발했습니다</p>
        <a href="#su1.png"> 사진 보기 1</a>
        <a href="#su2.png"> 사진 보기 2</a>
        <a href="#su3.png"> 사진 보기 3</a>
			</div>
		</div>
	</div>
	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style="width: 100%; display: flex; justify-content: center; align-items: center;">
    <div class="carousel-inner" style="width: 50%; display: flex; justify-content: center; align-items: center;" id="name"></div>
  </div>
</body>
</html>