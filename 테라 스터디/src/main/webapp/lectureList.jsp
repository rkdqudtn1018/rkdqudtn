<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
    import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList"%>
<%@ page import="util.DatabaseUtil"%>
<%@ page import="Lecture.LectureDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
    content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>강의 목록</title>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
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
    font-size: 1rem; /* 텍스트 크기 */
    padding: 0.375rem 0.75rem; /* 버튼 내부 여백 */
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    writing-mode: horizontal-tb; /* 텍스트 방향을 가로로 설정 */
}
</style>

</head>

<body>
    <!-- 네비게이션 바 -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">MyLecture</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarNav" aria-controls="navbarNav"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <%
                String userID = (String) session.getAttribute("userID");
                String job = (String) session.getAttribute("job");

                if (userID != null) {
                %>
                <li class="nav-item"><a class="nav-link"><%= userID %>님 (<%= job != null ? job : "역할 없음" %>)</a>
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
                <li class="nav-item active"><a class="nav-link"
                    href="lectureList.jsp">강의 목록</a></li>
            </ul>
            <form class="d-flex ms-3" action="lectureList.jsp" method="get">
                <input class="form-control me-2" type="search" name="query"
                    placeholder="강의 검색" aria-label="Search"
                    value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
                <button class="btn btn-outline-success" type="submit">검색</button>
            </form>
        </div>
    </nav>


    <!-- 강의 목록 섹션 -->
    <section class="lecture-list py-5">
        <div class="container">
            <h2 class="text-center">강의 목록</h2>

            <%
            if (userID != null && "교수".equals(job)) {
            %>
            <div class="d-flex justify-content-between mb-4">
                <div></div>
                <a href="registerLecture.jsp" class="btn btn-primary">강의 추가</a>
            </div>
            <%
            }
            %>

            <div class="table-responsive mt-4">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th width="10%">강의 번호</th>
                            <th width="10%">강의명</th>
                            <th width="10%">강사</th>
                            <th width="10%">카테고리</th>
                            <th width="10%">수강 인원</th>
                            <th width="10%">상세 보기</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        ArrayList<LectureDTO> lectureList = new ArrayList<LectureDTO>();
                        String query = request.getParameter("query");

                        try (Connection conn = DatabaseUtil.getConnection()) {
                            String sql;
                            PreparedStatement pstmt;

                            if (query != null && !query.trim().isEmpty()) {
                                sql = "SELECT * FROM lecture WHERE lectureName LIKE ? OR instructor LIKE ?";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, "%" + query + "%");
                                pstmt.setString(2, "%" + query + "%");
                            } else {
                                sql = "SELECT * FROM lecture";
                                pstmt = conn.prepareStatement(sql);
                            }

                            try (ResultSet rs = pstmt.executeQuery()) {
                                while (rs.next()) {
                                    LectureDTO lecture = new LectureDTO(rs.getInt("lectureID"), rs.getString("lectureName"),
                                            rs.getString("instructor"), rs.getString("category"), rs.getInt("students"),
                                            rs.getString("content"));
                                    lectureList.add(lecture);
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

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
                                class="btn btn-sm" style="background-color: pink; color: white;">상세 보기</a></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <footer class="footer mt-5 py-3 bg-dark text-white">
        <div class="container text-center">
            <span class="text-muted">© 2024 MyLecture. All Rights Reserved.</span>
        </div>
    </footer>
</body>
</html>
