<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="java.util.*"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String userID = null;
	String userPassword = null;
	String job = null;
	
	// 사용자가 입력한 userID와 userPassword 수집
	if(request.getParameter("userID") != null) {
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	
	// 입력된 값이 없을 경우 오류 메시지 출력
	if ( userID == null || userPassword == null) {
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('입력이 안 된 사항이 있습니다.');");
	    script.println("history.back();");
	    script.println("</script>");
	    script.close();
	    return;
	}

	UserDAO userDAO = new UserDAO();
	
	// 사용자의 정보 가져오기
	Map<String, String> userInfo = userDAO.getUserInfo(userID);
	if (userInfo != null) {
	    // 사용자의 역할 정보 (교수/학생) 가져와 세션에 저장
	    job = userInfo.get("job");
	    session.setAttribute("job", job);
	}
	
	// 비밀번호 암호화 후 로그인 처리

	int result = userDAO.login(userID, userPassword);       // 암호화된 비밀번호로 로그인
	
	if (result == 1) { // 로그인 성공
        session.setAttribute("userID", userID);
        session.setAttribute("userName", userDAO.getUserInfo(userID).get("userName"));
	    
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    
	    // 역할에 따른 페이지 리다이렉트
	    if ("professor".equals(job)) {
	        script.println("location.href = 'professorDashboard.jsp';");  // 교수 대시보드로 이동
	    } else if ("student".equals(job)) {
	        script.println("location.href = 'studentDashboard.jsp';");    // 학생 대시보드로 이동
	    } else {
	        script.println("location.href = 'index.jsp';");               // 기본 페이지로 이동
	    }
	    
	    script.println("</script>");
	    script.close();
	    return;
	    
	} else if (result == 0) { // 비밀번호 틀림
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('비밀번호가 틀립니다.');");
	    script.println("history.back();");
	    script.println("</script>");
	    script.close();
	    return;
	    
	} else if (result == -1) { // 아이디 없음
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('존재하지 않는 아이디 입니다.');");
	    script.println("history.back();");
	    script.println("</script>");
	    script.close();
	    return;
	    
	} else if (result == -2) { // 데이터베이스 오류
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('데이터베이스 오류가 발생하였습니다.');");
	    script.println("history.back();");
	    script.println("</script>");
	    script.close();
	    return;
	}
%>
