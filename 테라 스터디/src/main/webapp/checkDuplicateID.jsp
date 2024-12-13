<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>

<%
    String userID = request.getParameter("userID");

    if (userID == null || userID.trim().isEmpty()) {
        out.print("ERROR");
        return;
    }

    UserDAO userDAO = new UserDAO();
    boolean isDuplicate = userDAO.checkDuplicate(userID);

    if (!isDuplicate) {
        out.print("YES");
    } else {
        out.print("NO");
    }
%>
