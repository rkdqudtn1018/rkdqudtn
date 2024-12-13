<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");

    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String userEmail = request.getParameter("userEmail");

    if (userID == null || userPassword == null || userEmail == null) {
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다.');");
            script.println("history.back();");
            script.println("</script>");
        }
        return;
    }

    System.out.println("Attempting to join user: " + userID);

    UserDAO userDAO = new UserDAO();
    int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));

    System.out.println("Join result: " + result);

    if (result == -2) {  // 이미 존재하는 아이디일 경우
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다.');");
            script.println("history.back();");
            script.println("</script>");
        }
    } else if (result == -1) {  // 회원가입 실패일 경우
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('회원가입에 실패했습니다.');");
            script.println("history.back();");
            script.println("</script>");
        }
    } else {  // 회원가입 성공일 경우
        session.setAttribute("userID", userID);
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("location.href = 'emailSendAction.jsp'");
            script.println("</script>");
        }
    }
%>
