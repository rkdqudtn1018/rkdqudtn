<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbarNav" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link"
					href="index.jsp">메인</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="dropdownMenuLink"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						회원관리 </a>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item" href="userLogin.jsp">로그인</a> 
						<a class="dropdown-item active"href="userJoin.jsp">회원가입</a> 
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
					</div></li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
    <section class="container mt-3" style="max-width: 560px; margin-top: 20px;">
        <form method="post" action="./userRegisterAction.jsp">
            <div class="form-group">
                <label>아이디</label> <input type="text" name="userID"
                    class="form-control">
            </div>
            <div class="form-group">
                <label>비밀번호</label> 
                <input type="password" name="userPassword"
                    class="form-control">
            </div>
            <div class="form-group">
                <label>이메일</label> 
                <input type="email" name="userEmail"
                    class="form-control">
            </div>
            <button type="submit" class="btn btn-primary">회원가입</button>
        </form>
    </section>
    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
        Copyright &copy; 2024 윤혜영 All Rights Reserved 
    </footer>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
