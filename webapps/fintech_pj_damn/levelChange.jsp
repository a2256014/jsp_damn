<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import="fintech_pj_damn.*" %>
<jsp:include page="header.jsp" />
<script src="js/bootstrap.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
		<div class="jumbotron">
			<div class="container" style="text-align: center;  margin-top: 100px;">
				<h1>난이도 변경</h1>
            <form method="post" name="cLevel" action="levelChangeAction.jsp" style="display: flex; justify-content: right; ">
				<table style="width: 80%;">
					<tr >
						<td><select class="form-control" name="levelField">
								<option value="">Level-1</option>
								<option value="2">Level-2</option>
                                <option value="3">Level-3</option>
                                <option value="max">Level-max</option>
						</select></td>
						<td><button type="submit" class="btn btn-success">변경</button></td>
					</tr>
				</table>
			</form>
	    </div>
    </div>
</div>
</body>
</html>