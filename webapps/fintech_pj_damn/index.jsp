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
				<h1>�� ����Ʈ �Ұ�</h1>
				<p>�� ������Ʈ�� JSP�� ���� ����Ʈ�� ������� �����ϱ� ���� �����߽��ϴ�</p>
        <a href="#su1.png"> ���� ���� 1</a>
        <a href="#su2.png"> ���� ���� 2</a>
        <a href="#su3.png"> ���� ���� 3</a>
			</div>
		</div>
	</div>
	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style="width: 100%; display: flex; justify-content: center; align-items: center;">
    <div class="carousel-inner" style="width: 50%; display: flex; justify-content: center; align-items: center;" id="name"></div>
  </div>
</body>
</html>