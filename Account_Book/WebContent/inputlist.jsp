<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="input.InputDAO"%>
<%@ page import="input.Input"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width initial-scale=1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<title>가계부</title>
<style type = "text/css">
	a, a:hover{
		color = #000000;
		text-decoration : none;<!-- 밑줄삭제 -->
	}
</style>
</head>
<body>
	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<!-- 네비게이션  -->
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
				<li><a href = "outputlist.jsp">지출</a><li>
				<li><a href = "otherchoice.jsp">타 사용자 가계부</a></li>
			</ul>
			<%
				//로그인안된경우
						if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href = "searchinfo.jsp">아이디/비밀번호 찾기</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<!-- 게시판 -->
	<div class="container">
		<div class = "row">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd"> 
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">카테고리</th>
						<th style="background-color: #eeeeee; text-align: center;">내용</th>
						<th style="background-color: #eeeeee; text-align: center;">금액</th>
						<th style="background-color: #eeeeee; text-align: center;">날짜</th>
					</tr>
				</thead>
				<tbody>
					<%
						InputDAO inputDAO = new InputDAO();
						int total = 0;
						ArrayList<Input> list = inputDAO.getList(pageNumber,userID);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><a href = "inputview.jsp?inputID=<%= list.get(i).getInputid()%>"><%= list.get(i).getInputid() %></a></td>				
						<td><%= list.get(i).getCategory() %></td>
						<td><%= list.get(i).getContent()%></td>
						<td><%= list.get(i).getMoney() %></td>
						<td><%= list.get(i).getWebDate() %></td>
					</tr>
					<%
							total += list.get(i).getMoney();
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>	
				<a href = "bbs.jsp?pageNumber=<%=pageNumber - 1%>" class = "btn btn-success btn-arraw-left">이전</a>
			<%
				} if(inputDAO.nextPage(pageNumber + 1, userID)){
			%>
				<a href = "bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class = "btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<h3>수입 통합 : <%= total %></h3>
			<a href = "inputinsert.jsp" class="btn btn-primary pull-right">입력</a>
		</div>
	</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>