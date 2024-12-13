<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Lecture.LectureDAO" %>
<%@ page import="Lecture.LectureDTO" %>

<%
    String lectureIDParam = request.getParameter("lectureID");
	
    int lectureID = 0;

    if (lectureIDParam != null && !lectureIDParam.isEmpty()) {
        lectureID = Integer.parseInt(lectureIDParam);
    } else {
        out.println("<script>alert('유효하지 않은 강의 ID입니다.'); history.back();</script>");
        return;
    }
    

    LectureDAO lectureDAO = new LectureDAO();
    LectureDTO lecture = lectureDAO.getLectureById(lectureID);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>강의 수정</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"> <!-- 필요에 따라 경로 수정 -->
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">강의 수정</h2>
        <form action="updateLectureAction.jsp" method="post">
            <!-- 숨겨진 필드로 lectureID 전달 -->
            <input type="hidden" name="lectureID" value="<%= lecture.getLectureID() %>">
            
            <div class="form-group">
                <label for="lectureName">강의명</label>
                <input type="text" class="form-control" id="lectureName" name="lectureName" value="<%= lecture.getLectureName() %>" required>
            </div>
            
            <div class="form-group">
                <label for="instructor">강사</label>
                <input type="text" class="form-control" id="instructor" name="instructor" value="<%= lecture.getInstructor() %>" required>
            </div>
            
            <div class="form-group">
                <label for="category">카테고리</label>
                <input type="text" class="form-control" id="category" name="category" value="<%= lecture.getCategory() %>" required>
            </div>
            
            <div class="form-group">
                <label for="students">수강 인원</label>
                <input type="number" class="form-control" id="students" name="students" value="<%= lecture.getStudents() %>" required>
            </div>
            
            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" name="content" rows="4" required><%= lecture.getContent() %></textarea>
            </div>
            
            <button type="submit" class="btn btn-primary">강의 수정</button>
            <a href="lectureDetail.jsp?lectureID=<%= lecture.getLectureID() %>" class="btn btn-secondary">취소</a>
        </form>
    </div>
</body>
</html>
