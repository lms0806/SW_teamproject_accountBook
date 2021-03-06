<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel = "stylesheet" href = "css/bootstrap.min.css">
<link rel = "stylesheet" href = "css/custom.css">
<title>가계부</title>
</head>
<body>
	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class = "navbar-toggle collapsed"
				data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
				aria-expended = "false">
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
			</button>
			<a class = "navbar-brand" href="main.jsp">가계부</a>
		</div>
		<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li><a href = "main.jsp">메인</a><li>
				<li><a href = "inputlist.jsp">수입</a><li>
				<li><a href="outputlist.jsp">지출</a><li>
				<li><a href = "otherchoice.jsp">타 사용자 가계부</a></li>
			</ul>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expended = "false">접속하기 <span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li class = "active"><a href = "login.jsp">로그인</a></li><%--불이 들어가있게함(class = "active") --%>
						<li><a href = "searchinfo.jsp">아이디/비밀번호 찾기</a></li>
						<li><a href = "join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	
	<div class = "container">
		<div class = "col-Lg-4"></div>
		<div class = "col-Lg-4">
			<div class = "jumbotron" style = "padding-top : 20px;">
				<form method = "post" action = inputinsertaction.jsp>
					<h3 style = "text-align: center;">수입 입력</h3>
					<div class = "form-group">
						<input type = "text" class = "form-control" placeholder = "카테고리" name = "category" maxlength = "20"> 
					</div>
					<div class = "form-group">
						<input type = "text" class = "form-control" placeholder = "내용" name = "content" maxlength = "20"> 
					</div>
					<div class = "form-group">
						<input type = "number" class = "form-control" placeholder = "금액" name = "money" maxlength = "20"> 
					</div>
					<div class = "form-group">
						<input type = "date" class = "form-control" placeholder = "날짜" name = "webDate" maxlength = "20"> 
					</div>
					<input type = "submit" class = "btn btn-primary form-control" value = "입력">
				</form>
			</div>
		</div>
		<div class = "col-Lg-4"></div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>