<%@ page import="comment.CommentDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String lectureID = request.getParameter("lectureID");
    String commentText = request.getParameter("commentText");
    String userID = (String) session.getAttribute("userID");

    // 댓글 DAO를 통해 댓글 추가
    CommentDAO commentDAO = new CommentDAO();
    boolean success = commentDAO.addComment(Integer.parseInt(lectureID), userID, commentText);

    if (success) {
        response.sendRedirect("lectureDetail.jsp?lectureID=" + lectureID);
    } else {
        out.println("댓글 등록에 실패했습니다.");
    }
%>