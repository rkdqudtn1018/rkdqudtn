<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>로그인</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Custom CSS for matching index.jsp design -->
    <link rel="stylesheet" href="css/custom.css">
</head>
<body>

<!-- Header (로그인 버튼 삭제) -->
<header>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="index.jsp">MyLecture</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">홈</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="userJoin.jsp">회원 가입</a>
        </li>
        <!-- 로그인 버튼 제거 -->
      </ul>
    </div>
  </nav>
</header>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="text-center mb-4">로그인</h2>
            <%
                String userID = null;
                if (session.getAttribute("userID") != null) {
                    userID = (String) session.getAttribute("userID");
                }
                if (userID != null) {
                    out.println("<div class='alert alert-info'>이미 로그인되어 있습니다: " + userID + "</div>");
                } else {
            %>
            <form action="userLoginAction.jsp" method="post">
                <!-- 아이디 입력 -->
                <div class="form-group">
                    <label for="userID">아이디</label>
                    <input type="text" class="form-control" id="userID" name="userID" placeholder="아이디를 입력하세요" required>
                </div>

                <!-- 비밀번호 입력 -->
                <div class="form-group">
                    <label for="userPassword">비밀번호</label>
                    <input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="비밀번호를 입력하세요" required>
                </div>

                <!-- 로그인 버튼 -->
                <button type="submit" class="btn btn-primary btn-block mt-3">로그인</button>
            </form>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer mt-auto py-3 bg-light">
  <div class="container text-center">
    <span class="text-muted">푸터 내용이 여기에 들어갑니다.</span>
  </div>
</footer>

<!-- Bootstrap JS 및 의존성 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
