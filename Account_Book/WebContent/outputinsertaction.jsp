<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="output.OutputDAO"%>
<%@ page import="total.TotalDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="output" class="output.Output" scope="page" />
<jsp:setProperty name="output" property="category" />
<jsp:setProperty name="output" property="content" />
<jsp:setProperty name="output" property="money" />
<jsp:setProperty name="output" property="webDate" />
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
		else{
			if(output.getCategory() == null || output.getContent() == null || output.getMoney() == 0 || output.getWebDate() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}//입력이 안된 경우
			else{
				TotalDAO totalDAO = new TotalDAO();
				totalDAO.updateoutput(output.getMoney(), userID, 1);
				OutputDAO outputDAO = new OutputDAO();
				int result = outputDAO.outputinsert(userID, output.getCategory(), output.getContent(), output.getMoney(), output.getWebDate());
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
					script.println("location.href = 'outputlist.jsp'");
					script.println("</script>");
				}//회원가입 완료
			}
		}
	%>
</body>
</html>