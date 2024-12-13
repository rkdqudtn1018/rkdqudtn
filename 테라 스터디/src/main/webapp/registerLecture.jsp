<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="Lecture.LectureDAO"%>
<%@ page import="Lecture.LectureDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 추가</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-5">
		<h2 class="text-center">강의 추가</h2>

		<%
		// 폼이 제출된 후 데이터베이스에 저장하는 로직
		if (request.getMethod().equalsIgnoreCase("POST")) {
			int lectureID = request.getParameter("lectureID") != null ? Integer.parseInt(request.getParameter("lectureID")) : 0;
			String lectureName = request.getParameter("lectureName") != null ? request.getParameter("lectureName") : "";
			String instructor = request.getParameter("instructor") != null ? request.getParameter("instructor") : "";
			String category = request.getParameter("category") != null ? request.getParameter("category") : "";
			int students = request.getParameter("students") != null ? Integer.parseInt(request.getParameter("students")) : 0;
			String content = request.getParameter("content") != null ? request.getParameter("content") : "";
			
			
			LectureDTO lecture = new LectureDTO(lectureID, lectureName, instructor, category, students, content);
			LectureDAO lectureDAO = new LectureDAO();
			int result = lectureDAO.addLecture(lecture);

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter script = response.getWriter();
			if (result == 1) {
				script.println("<script>alert('강의가 성공적으로 추가되었습니다.'); location.href='lectureList.jsp';</script>");
			} else {
				script.println("<script>alert('강의 추가에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
			}
			script.close();
			return; // 폼이 제출된 후 더 이상 HTML 폼을 렌더링하지 않도록 종료
		}
		%>

		<!-- 강의 추가 폼 -->
		<form action="registerLecture.jsp" method="post">
			<div class="form-group">
				<label for="lectureName">강의명</label> <input type="text"
					class="form-control" id="lectureName" name="lectureName" required>
			</div>

			<div class="form-group">
				<label for="instructor">강사</label> <input type="text"
					class="form-control" id="instructor" name="instructor" required>
			</div>

			<div class="form-group">
				<label for="category">카테고리</label> <input type="text"
					class="form-control" id="category" name="category" required>
			</div>

			<div class="form-group">
				<label for="students">수강 인원</label> <input type="number"
					class="form-control" id="students" name="students" required>
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea class="form-control" id="content" name="content" rows="4"
					required></textarea>
			</div>

			<button type="submit" class="btn btn-primary">강의 추가</button>
		</form>
	</div>

	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
