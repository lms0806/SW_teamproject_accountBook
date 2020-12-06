<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
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
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}//로그인한사람은 userID에 값 추가
	%>
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
				<li><a href = "outputlist.jsp">지출</a><li>
				<li class = "active"><a href = "otherchoice.jsp">타 사용자 가계부</a></li>
			</ul>
			<%
				if(userID == null){
					
			%>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expended = "false">접속하기 <span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "login.jsp">로그인</a></li>
						<li><a href = "join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else{
			%>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expended = "false">회원관리 <span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}//로그아웃
			%>
		</div>
	</nav>
	<div class="container">
		<h1>원하는 수입의 다른사람 가계부를 볼 수 있습니다.</h1>
		<div class="container">
			<p><a class="btn btn-primary btn-pull" href="otherlist.jsp?min=0&max=1000000" role="button">0 ~ 1,000,000(백만)</a></p>
		</div>
		<div class="container">
			<p><a class="btn btn-primary btn-pull" href="otherlist.jsp?min=1000001&max=3000000" role="button">1,000,001 ~ 3,000,000(천만)</a></p>
		</div>
		<div class="container">
			<p><a class="btn btn-primary btn-pull" href="otherlist.jsp?min=3000001&max=50000000" role="button">3,000,001 ~ 5,000,000(오백만)</a></p>
		</div>
		<div class="container">
			<p><a class="btn btn-primary btn-pull" href="otherlist.jsp?min=5000001&max=70000000" role="button">5,000,001 ~ 7,000,000(칠백만)</a></p>
		</div>
		<div class="container">
			<p><a class="btn btn-primary btn-pull" href="otherlist.jsp?min=7000001&max=90000000" role="button">7,000,001 ~ 9,000,000(구백만)</a></p>
		</div>
		<div class="container">
			<p><a class="btn btn-primary btn-pull" href="otherlist.jsp?min=10000000" role="button">그 외</a></p>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>