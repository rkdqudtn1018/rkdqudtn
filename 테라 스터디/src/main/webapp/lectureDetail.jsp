<%@ page import="comment.CommentDAO, comment.CommentDTO"%>
<%@ page import="Lecture.LectureDAO, Lecture.LectureDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
String lectureID = request.getParameter("lectureID");

// 댓글 DAO를 통해 댓글 목록 가져오기
CommentDAO commentDAO = new CommentDAO();
ArrayList<CommentDTO> comments = commentDAO.getCommentsByLectureID(Integer.parseInt(lectureID));

// LectureDAO를 사용하여 강의 정보 가져오기
LectureDAO lectureDAO = new LectureDAO();
LectureDTO lecture = lectureDAO.getLectureById(Integer.parseInt(lectureID));

// 가져온 강의 정보에서 변수 설정
String lectureName = lecture.getLectureName();
String instructor = lecture.getInstructor();
String category = lecture.getCategory();
int students = lecture.getStudents();
String content = lecture.getContent();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=lectureName%> 상세 설명</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h2><%=lectureName%>
			강의 상세 설명
		</h2>
		<p>
			<strong>강사:</strong>
			<%=instructor%></p>
		<p>
			<strong>카테고리:</strong>
			<%=category%></p>
		<p>
			<strong>수강 인원:</strong>
			<%=students%>명
		</p>
		<p>
			<strong>내용:</strong>
			<%=content%></p>

		<!-- 버튼들을 수평으로 정렬 -->
		<div class="d-flex justify-content-between mb-3">
			<a href="lectureList.jsp" class="btn btn-primary">강의 목록으로 돌아가기</a>

			<div class="btn-group" role="group">
				<a href="evaluation.jsp?lectureID=<%= lecture.getLectureID() %>"
					class="btn btn-secondary">강의 평가하기</a> 
				<a href="updateLecture.jsp?lectureID=<%= lecture.getLectureID() %>"
					class="btn btn-primary">강의 수정</a>
			</div>
		</div>

		<!-- 댓글 작성 폼 -->
		<h3>댓글 작성</h3>
		<form action="submitComment.jsp" method="post">
			<input type="hidden" name="lectureID" value="<%=lectureID%>">
			<div class="form-group">
				<label for="commentText">댓글:</label>
				<textarea class="form-control" id="commentText" name="commentText"
					rows="3" required></textarea>
			</div>
			<button type="submit" class="btn btn-primary">댓글 등록</button>
		</form>

		<!-- 댓글 목록 표시 -->
		<h3>댓글 목록</h3>
		<div class="comments">
			<%
			for (CommentDTO comment : comments) {
				int commentID = comment.getCommentID();
			%>
			<div class="comment">
				<p>
					<strong><%=comment.getUserID()%>:</strong>
					<%=comment.getCommentText()%></p>
				<p>
					<small><%=comment.getCommentDate()%></small>
				</p>

				<!-- 댓글 삭제 버튼 -->
				<form action="deleteComment.jsp" method="POST"
					style="display: inline;">
					<input type="hidden" name="commentID" value="<%=commentID%>">
					<input type="hidden" name="lectureID" value="<%=lectureID%>">
					<button type="submit" class="btn btn-danger btn-sm">댓글 삭제</button>
				</form>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>
