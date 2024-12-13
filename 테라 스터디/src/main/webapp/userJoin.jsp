<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>회원 가입</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

	<!-- Header (회원가입 버튼 삭제) -->
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="index.jsp">MyLecture</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="index.jsp">홈</a>
					</li>
					<!-- 회원가입 버튼 제거 -->
					<li class="nav-item"><a class="nav-link" href="userLogin.jsp">로그인</a>
					</li>
				</ul>
			</div>
		</nav>
	</header>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<h2>회원 가입</h2>
				<%
                String userID = null;
                if(session.getAttribute("userID") != null) {
                    userID = (String) session.getAttribute("userID");
                }
                if(userID == null) {
            %>
				<form action="userRegisterAction.jsp" method="post">
					<!-- 이름 입력 -->
					<div class="form-group">
						<label for="userName">이름</label> <input type="text"
							class="form-control" id="userName" name="userName" required>
					</div>

					<!-- 이메일 입력 -->
					<div class="form-group">
						<label for="userEmail">이메일</label> <input type="email"
							class="form-control" id="userEmail" name="userEmail" required>
					</div>

					<!-- 아이디 입력 및 중복 확인 버튼 -->
					<div class="form-group">
						<label for="userID">아이디</label>
						<div class="input-group">
							<input type="text" class="form-control" id="userID" name="userID"
								required>
							<div class="input-group-append">
								<button type="button" class="btn btn-secondary"
									onclick="checkDuplicateID()">중복 확인</button>
							</div>
						</div>
					</div>

					<!-- 비밀번호 입력 -->
					<div class="form-group">
						<label for="userPassword">비밀번호</label> <input type="password"
							class="form-control" id="userPassword" name="userPassword"
							required>
					</div>

					<div class="form-group">
						<label for="job">직업</label><br> <input type="radio"
							id="professor" name="job" value="교수" required> <label
							for="professor">교수</label><br> <input type="radio"
							id="student" name="job" value="학생" required> <label
							for="student">학생</label>
					</div>

					<!-- 가입 버튼 -->
					<button type="submit" class="btn btn-primary">가입</button>
				</form>

				<!-- 중복 확인 스크립트 (AJAX 사용) -->
				<script>
                function checkDuplicateID() {
                    var userID = document.getElementById("userID").value;
                    if(userID == "") {
                        alert("아이디를 입력해주세요.");
                        return;
                    }

                    // AJAX 요청을 통해 서버에 중복 확인 요청 보내기
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "checkDuplicateID.jsp", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            var response = xhr.responseText;
                            if (response.trim() == "YES") {
                                alert("사용할 수 있는 아이디입니다.");
                            } else if (response.trim() == "NO") {
                                alert("이미 사용 중인 아이디입니다.");
                            } else {
                                alert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
                            }
                        }
                    };
                    xhr.send("userID=" + encodeURIComponent(userID));
                }
            </script>

				<%
                } else {
                    out.println("이미 " + userID + "으로 로그인되어 있습니다.");
                }
            %>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="footer mt-auto py-3 bg-light">
		<div class="container">
			<span class="text-muted">푸터 내용이 여기에 들어갑니다.</span>
		</div>
	</footer>

	<!-- Bootstrap JS 및 의존성 -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
