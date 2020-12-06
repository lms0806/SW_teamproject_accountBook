<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="input.InputDAO"%>
<%@ page import="total.TotalDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="input" class="input.Input" scope="page" />
<jsp:setProperty name="input" property="category" />
<jsp:setProperty name="input" property="content" />
<jsp:setProperty name="input" property="money" />
<jsp:setProperty name="input" property="webDate" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>가계부</title>
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
		else{
			if(input.getCategory() == null || input.getContent() == null || input.getMoney() == 0 || input.getWebDate() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}//입력이 안된 경우
			else{
				TotalDAO totalDAO = new TotalDAO();
				totalDAO.updateinput(input.getMoney(), userID, 1);
				InputDAO inputDAO = new InputDAO();
				int result = inputDAO.inputinsert(userID, input.getCategory(), input.getContent(), input.getMoney(), input.getWebDate());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력에 실패했습니다.')");
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