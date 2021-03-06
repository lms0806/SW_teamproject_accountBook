<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "members.MembersDAO" %>
<%@ page import = "total.TotalDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id = "members" class = "members.Members" scope = "page"/>
<jsp:setProperty name = "members" property = "userID" />
<jsp:setProperty name = "members" property = "userPassword" />
<jsp:setProperty name = "members" property = "userName" />
<jsp:setProperty name = "members" property = "userGender" />
<jsp:setProperty name = "members" property = "userEmail" />
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
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if(members.getUserID() == null || members.getUserPassword() == null || members.getUserName() == null || members.getUserGender() == null || members.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}//입력이 안된 경우
		else{
			MembersDAO membersDAO = new MembersDAO();
			TotalDAO totalDAO = new TotalDAO();
			totalDAO.insert(members.getUserID());
			int result = membersDAO.join(members);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}//겹치는 경우
			else {
				session.setAttribute("userID", members.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}//회원가입 완료
		}
	%>
</body>
</html>