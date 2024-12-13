<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.ArrayList"%>
<%@ page import="Lecture.LectureDAO"%>
<%@ page import="Lecture.LectureDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 검색 결과</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-5">
		<h2 class="mb-4">검색 결과</h2>
		<%
		String query = request.getParameter("query"); // 검색어 가져오기
		if (query == null || query.trim().isEmpty()) {
		%>
		<p>검색어를 입력해주세요.</p>
		<%
		} else {
		LectureDAO lectureDAO = new LectureDAO();
		ArrayList<LectureDTO> lectureList = lectureDAO.searchLectures(query); // 검색 메서드 호출

		if (lectureList.isEmpty()) {
		%>
		<p>검색 결과가 없습니다.</p>
		<%
		} else {
		%>
		<table class="table table-bordered text-center">
			<thead>
				<tr>
					<th>강의 번호</th>
					<th>강의명</th>
					<th>강사</th>
					<th>카테고리</th>
					<th>수강 인원</th>
					<th>상세 보기</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (LectureDTO lecture : lectureList) {
				%>
				<tr>
					<td><%=lecture.getLectureID()%></td>
					<td><%=lecture.getLectureName()%></td>
					<td><%=lecture.getInstructor()%></td>
					<td><%=lecture.getCategory()%></td>
					<td><%=lecture.getStudents()%></td>
					<td><a
						href="lectureDetail.jsp?lectureID=<%=lecture.getLectureID()%>"
						class="btn btn-primary btn-sm">상세 보기</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		}
		}
		%>
	</div>


</body>
</html>
