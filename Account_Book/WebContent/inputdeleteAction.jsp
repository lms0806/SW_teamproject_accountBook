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
		Input input = new InputDAO().getInput(inputID);
		if(!userID.equals(input.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'inputlist.jsp'");
			script.println("</script>");
		}
		else{
			TotalDAO totalDAO = new TotalDAO();
			totalDAO.updateinput(input.getMoney(), userID, 0);
			InputDAO bbsDAO = new InputDAO();
			int result = bbsDAO.delete(inputID, userID);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
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
	%>
</body>
</html>