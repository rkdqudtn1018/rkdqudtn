<%@ page import="java.sql.Connection, java.sql.PreparedStatement"%>
<%@ page import="util.DatabaseUtil"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String lectureID = request.getParameter("lectureID");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>강의 평가하기</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>강의 평가하기</h2>

        <form action="submitEvaluation.jsp" method="post">
            <input type="hidden" name="lectureID" value="<%= lectureID %>">
            <div class="form-group">
                <label for="evaluationTitle">평가 제목:</label>
                <input type="text" class="form-control" id="evaluationTitle" name="evaluationTitle" required>
            </div>
            <div class="form-group">
                <label for="totalScore">총 평점:</label>
                <input type="number" class="form-control" id="totalScore" name="totalScore" max="5" min="1" required>
            </div>
            <div class="form-group">
                <label for="creditScore">학점 만족도:</label>
                <input type="number" class="form-control" id="creditScore" name="creditScore" max="5" min="1" required>
            </div>
            <div class="form-group">
                <label for="comfortableScore">편리성 만족도:</label>
                <input type="number" class="form-control" id="comfortableScore" name="comfortableScore" max="5" min="1" required>
            </div>
            <div class="form-group">
                <label for="lectureScore">강의 만족도:</label>
                <input type="number" class="form-control" id="lectureScore" name="lectureScore" max="5" min="1" required>
            </div>
            <div class="form-group">
                <label for="evaluationContent">평가 내용:</label>
                <textarea class="form-control" id="evaluationContent" name="evaluationContent" rows="4" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">평가 제출</button>
        </form>
    </div>
</body>
</html>
