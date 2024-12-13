<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
    // 세션 무효화
    if (session != null) {
        session.invalidate();
    }

    // 로그아웃 후 메인 페이지로 리다이렉트
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('로그아웃 되었습니다.');");
    script.println("location.href = 'index.jsp';"); // 로그아웃 후 이동할 페이지 설정
    script.println("</script>");
    script.close();
%>
