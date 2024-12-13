<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter, user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>강의 플랫폼 메인 페이지</title>
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- 커스텀 CSS -->
<link rel="stylesheet" href="css/custom.css">
<style>
    .navbar {
        padding: 0.5rem 1rem;
        height: auto;
        box-sizing: border-box; /* 크기 계산 방식 고정 */
    }
    .navbar-brand {
        font-size: 1.25rem;
        line-height: 1.5;
    }
    .nav-link {
        font-size: 1rem;
        line-height: 1.5;
    }
    .form-control {
        height: 48px; /* 검색창 높이 고정 */
    }
    .btn-outline-success {
        height: 48px; /* 검색 버튼 높이 고정 */
        line-height: 1.2;
    }
</style>

</head>
<body>
	<!-- 네비게이션 바 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">MyLecture</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto">
				<%
				// 세션에서 사용자 ID와 역할 가져오기
				String userID = (String) session.getAttribute("userID");
				String job = (String) session.getAttribute("job"); // '교수' 또는 '학생'

				if (userID != null) {
				%>
				<li class="nav-item">
					<a class="nav-link"><%= userID %>님 (<%= job != null ? job : "역할 없음" %>)</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="logout.jsp">로그아웃</a></li>
				<%
				} else {
				%>
				<li class="nav-item"><a class="nav-link" href="userLogin.jsp">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="userJoin.jsp">회원가입</a></li>
				<%
				}
				%>
				<li class="nav-item"><a class="nav-link" href="index.jsp">홈</a></li>
				<li class="nav-item active"><a class="nav-link" href="lectureList.jsp">강의 목록</a></li>
			</ul>
			<!-- 검색 폼 -->
			<form class="d-flex ms-3" action="lectureList.jsp" method="get">
				<input class="form-control me-2" type="search" name="query" placeholder="강의 검색" aria-label="Search"
					value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
				<button class="btn btn-outline-success" type="submit">검색</button>
			</form>
		</div>
	</nav>
	
	<!-- 메인 배너 -->
	<section class="main-banner text-center py-5 bg-primary text-white">
		<div class="container">
			<h1>배움을 시작하세요!</h1>
			<p>최고의 강사들과 함께 다양한 분야를 배우세요.</p>
			<%
			// 로그인 여부 확인 (세션에 저장된 사용자 정보가 있는지 확인)
			String redirectURL = (userID != null) ? "lectureList.jsp" : "userLogin.jsp";
			%>
			<!-- 버튼 디자인은 그대로 유지하면서 링크만 동적으로 변경 -->
			<a href="<%=redirectURL%>" class="btn btn-light btn-lg">지금 시작하기</a>
		</div>
	</section>

	<!-- 인기 강의 섹션 -->
	<section class="featured-lectures py-5">
		<div class="container">
			<h2 class="text-center">추천 강의</h2>
			<div class="row mt-4">
				<div class="col-md-4">
					<div class="card">
						<a href="lectureDetail.jsp?lectureID=1"> <img
							src="images/lecture1.jpg" alt="강의 이미지 1" class="card-img-top">
							<div class="card-body">
								<h5 class="card-title">Java 프로그래밍 입문</h5>
								<p class="card-text">초보자를 위한 Java 강의</p>
							</div>
						</a>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card">
						<a href="lectureDetail.jsp?lectureID=2"> <img
							src="images/lecture2.jpg" alt="강의 이미지 2" class="card-img-top">
							<div class="card-body">
								<h5 class="card-title">웹 개발 기초</h5>
								<p class="card-text">HTML, CSS, JavaScript로 시작하는 웹 개발</p>
							</div>
						</a>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card">
						<a href="lectureDetail.jsp?lectureID=3"> <img
							src="images/lecture3.jpg" alt="강의 이미지 3" class="card-img-top">
							<div class="card-body">
								<h5 class="card-title">데이터 사이언스</h5>
								<p class="card-text">데이터 분석 및 머신러닝 개념 익히기</p>
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 푸터 -->
	<footer class="footer mt-5 py-3 bg-dark text-white">
		<div class="container text-center">
			<span class="text-muted">© 2024 MyLecture. All Rights Reserved.</span>
		</div>
	</footer>

	<!-- 부트스트랩 JS -->
	<script src="js/jquery.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
