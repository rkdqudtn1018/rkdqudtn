<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    UserDAO userDAO = new UserDAO();
    String userID = null;
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.');");
        script.println("location.href = 'userLogin.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
    
    request.setCharacterEncoding("UTF-8");
    String evaluationID = null;
    if(request.getParameter("evaluationID") != null) {
    	evaluationID = request.getParameter("evaluationID");
    }
    EvaluationDAO evaluationDAO = new EvaluationDAO();
    if(userID.equals(evaluationDAO.getUserID(evaluationID))) {
    	int result = new EvaluationDAO().delete(evaluationID);
    	if (result == 1) { 
    		//데이터베이스에서의 삭제 작업이 성공적으로 수행되었음을 나타내는 조건, 
    		//EvaluationDAO 클래스의 delete 메서드를 호출하여 반환된 값
    		PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('삭제가 완료되었습니다.');");
            script.println("location.href = 'index.jsp';");
            script.println("</script>");
            script.close();
            return;
    	} else {
    		PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 발생했습니다.');");
            script.println("location.href = 'index.jsp';");
            script.println("</script>");
            script.close();
            return;
    	}
    } else {
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('자신이 쓴 글만 삭제 가능합니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
        return;
    }
%>