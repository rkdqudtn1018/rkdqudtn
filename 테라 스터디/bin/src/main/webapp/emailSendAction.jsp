<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.mail.Transport"%>
<%@ page import="jakarta.mail.Message"%>
<%@ page import="jakarta.mail.Address"%>
<%@ page import="jakarta.mail.internet.InternetAddress"%>
<%@ page import="jakarta.mail.internet.MimeMessage"%>
<%@ page import="jakarta.mail.Session"%>
<%@ page import="jakarta.mail.Authenticator"%>
<%@ page import="java.util.Properties"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail"%>
<%@ page import="java.io.PrintWriter"%>
<%
    UserDAO userDAO = new UserDAO();
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.');");
        script.println("location.href = 'userLogin.jsp';");
        script.println("</script>");
        script.close();
        return;
    }
    boolean emailChecked = userDAO.getUserEmailChecked(userID); 
    if (emailChecked) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 인증 된 회원입니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
        return;
    }
    
    String host = "http://localhost:8080/Lecture_Evaluation/";
    String from = "mi011018@g.shingu.ac.kr";
    String to = userDAO.getUserEmail(userID);
    String subject = "강의평가를 위한 이메일 인증 메일입니다.";
    String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." +
        "<a href='" + host + "emailCheckedAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
    
    Properties p = new Properties();
    p.put("mail.smtp.user", from);
    p.put("mail.smtp.host", "smtp.gmail.com");  
    p.put("mail.smtp.port", "465");
    p.put("mail.smtp.starttls.enable", "true"); 
    p.put("mail.smtp.auth", "true"); 
    p.put("mail.smtp.debug", "true"); 
    p.put("mail.smtp.socketFactory.port", "465"); 
    p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    p.put("mail.smtp.socketFactory.fallback", "false");

    // Gmail 이메일과 비밀번호 설정
    String email = "mi011018@g.shingu.ac.kr"; // 자신의 이메일 주소
    String password = "rkdqudtn12@"; // 자신의 이메일 비밀번호
    
    try {
        Authenticator auth = new Gmail();
        Session ses = Session.getInstance(p, auth);
        ses.setDebug(true);
        MimeMessage msg = new MimeMessage(ses);
        msg.setSubject(subject);
        Address fromAddr = new InternetAddress(from);
        msg.setFrom(fromAddr);
        Address toAddr = new InternetAddress(to);
        msg.addRecipient(Message.RecipientType.TO, toAddr);
        msg.setContent(content, "text/html;charset=UTF-8");
        Transport.send(msg);
    } catch (Exception e) {
        e.printStackTrace();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생했습니다. 오류 메시지: " + e.getMessage() + "');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
                <li class="nav-item active"><a class="nav-link"
                    href="index.jsp">메인</a></li>
                <li class="nav-item dropdown"><a
                    class="nav-link dropdown-toggle" id="dropdownMenuLink"
                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        회원관리 </a>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
              
                        <a class="dropdown-item" href="userLogin.jsp">로그인</a> 
                        <a class="dropdown-item" href="userJoin.jsp">회원가입</a> 
  
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
        <div class="alert alert-success mt-4" role="alert">
        	이메일 주소 인증  메일이 전송되었습니다. 회원가입시 입력했던 이메일에 들어가셔서 인증해주세요. (^~^)
        </div>
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

