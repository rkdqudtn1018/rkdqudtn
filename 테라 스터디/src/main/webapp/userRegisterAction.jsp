<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
    // 입력 값 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인 여부 확인 (로그인 상태면 회원가입 불가)
    String userID = (String) session.getAttribute("userID");
    if (userID != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인된 상태입니다. 로그아웃 후 시도해 주세요.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
        return;
    }

    // 사용자 입력 값 수집
    String userName = request.getParameter("userName");
    String userEmail = request.getParameter("userEmail");
    userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String job = request.getParameter("job");  // 추가된 job 필드

    // 필수 값 검증
    if (userName == null || userEmail == null || userID == null || userPassword == null || 
        userName.trim().isEmpty() || userEmail.trim().isEmpty() || 
        userID.trim().isEmpty() || userPassword.trim().isEmpty() || job.trim().isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('모든 필드를 입력해 주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    // DAO 객체 생성
    UserDAO userDAO = new UserDAO();

    // 최종적으로 중복 확인 (DB에서 ID 확인)
    if (userDAO.checkDuplicate(userID)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 존재하는 아이디입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    // 비밀번호 암호화 (SHA-256 사용)
    String encryptedPassword = SHA256.getSHA256(userPassword); // 입력 비밀번호를 암호화

    // 암호화된 비밀번호를 사용하여 UserDTO에 저장하고 데이터베이스에 추가
    int result = userDAO.join(new UserDTO(userName, userEmail, userID, encryptedPassword, job));

    if (result == -1) {
        // 회원가입 실패 시
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입에 실패했습니다. 다시 시도해 주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    } else {
        // 회원가입 성공 시, 세션에 사용자 정보 저장
        session.setAttribute("userID", userID);
        session.setAttribute("userName", userName);
        session.setAttribute("job", job);  // 역할 저장 (교수/학생)

        // 회원가입 성공 시, 성공 메시지를 띄우고 사용자 대시보드 페이지로 이동
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입이 완료되었습니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
    }
%>
