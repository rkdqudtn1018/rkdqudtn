<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String commentID = request.getParameter("commentID");
    String lectureID = request.getParameter("lectureID");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lectureevaluation", "root", "user123");

        // 댓글 삭제 SQL
        String sql = "DELETE FROM comments WHERE commentID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(commentID));
        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>alert('댓글이 삭제되었습니다.'); location.href='lectureDetail.jsp?lectureID=" + lectureID + "';</script>");
        } else {
            out.println("<script>alert('댓글 삭제에 실패했습니다.'); history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
