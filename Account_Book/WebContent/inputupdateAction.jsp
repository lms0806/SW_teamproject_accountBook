<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "input.Input" %>
<%@ page import = "input.InputDAO" %>
<%@ page import = "total.TotalDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>서원대학교 컴퓨터공학과 게시판</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
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
		Input bbs = new InputDAO().getInput(inputID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'inputlist.jsp'");
			script.println("</script>");
		}
		else{
			if(request.getParameter("category") == null || request.getParameter("content") == null || Integer.parseInt(request.getParameter("money")) == 0 || request.getParameter("webDate") == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}//입력이 안된 경우
			else{
				TotalDAO totalDAO = new TotalDAO();
				InputDAO inputDAO = new InputDAO();
				int money = inputDAO.getmoney(inputID);
				totalDAO.changeinput(userID, money, Integer.parseInt(request.getParameter("money")));
				int result = inputDAO.update(inputID, request.getParameter("category"), request.getParameter("content"), Integer.parseInt(request.getParameter("money")), request.getParameter("webDate"));
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}//겹치는 경우
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'inputlist.jsp'");
					script.println("</script>");
				}//회원가입 완료
			}
		}
	%>
</body>
</html>