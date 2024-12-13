<%@ page import="java.sql.Connection, java.sql.PreparedStatement"%>
<%@ page import="util.DatabaseUtil"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String lectureID = request.getParameter("lectureID");
    String evaluationTitle = request.getParameter("evaluationTitle");
    String totalScore = request.getParameter("totalScore");
    String creditScore = request.getParameter("creditScore");
    String comfortableScore = request.getParameter("comfortableScore");
    String lectureScore = request.getParameter("lectureScore");
    String evaluationContent = request.getParameter("evaluationContent");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DatabaseUtil.getConnection();
        String sql = "INSERT INTO evaluation (lectureID, evaluationTitle, totalScore, creditScore, comfortableScore, lectureScore, evaluationContent) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(lectureID));
        pstmt.setString(2, evaluationTitle);
        pstmt.setString(3, totalScore);
        pstmt.setString(4, creditScore);
        pstmt.setString(5, comfortableScore);
        pstmt.setString(6, lectureScore);
        pstmt.setString(7, evaluationContent);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }

    response.sendRedirect("lectureList.jsp");
%>
