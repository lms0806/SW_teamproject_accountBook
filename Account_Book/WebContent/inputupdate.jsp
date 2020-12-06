<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "input.InputDAO" %>
<%@ page import = "input.Input" %>
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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int inputID = 0;
		if(request.getParameter("inputID") != null){
			inputID = Integer.parseInt(request.getParameter("inputID"));
		}
		if(inputID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'inputlist.jsp'");
			script.println("</script>");
		}
		Input input = new InputDAO().getInput(inputID);
		if(!userID.equals(input.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'inputlist.jsp'");
			script.println("</script>");
		}
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
				<li class = "active"><a href = "inputlist.jsp">수입</a><li>
				<li><a href = "output.jsp">지출</a><li>
				<li><a href = "otherchoice.jsp">타 사용자 가계부</a></li>
			</ul>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expended = "false">회원관리 <span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "logout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class = "container">
		<div class = "col-Lg-4"></div>
		<div class = "col-Lg-4">
			<div class = "jumbotron" style = "padding-top : 20px;">
				<form method = "post" action = inputupdateAction.jsp?inputID=<%= inputID %>>
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