<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Lecture.LectureDAO" %>
<%@ page import="Lecture.LectureDTO" %>

<%
    // lectureID 파라미터 가져오기 및 유효성 검사
    String lectureIDParam = request.getParameter("lectureID");
    if (lectureIDParam == null || lectureIDParam.isEmpty()) {
        out.println("<script>alert('유효하지 않은 강의 ID입니다.'); history.back();</script>");
        return;
    }
    int lectureID = Integer.parseInt(lectureIDParam);

    // 폼에서 전달된 데이터 가져오기
    String lectureName = request.getParameter("lectureName");
    String instructor = request.getParameter("instructor");
    String category = request.getParameter("category");
    String content = request.getParameter("content");

    // 학생 수 숫자 변환 및 유효성 검사
    int students = 0;
    try {
        students = Integer.parseInt(request.getParameter("students"));
    } catch (NumberFormatException e) {
        out.println("<script>alert('학생 수는 숫자여야 합니다.'); history.back();</script>");
        return;
    }

    // 데이터 유효성 검사
    if (lectureName == null || lectureName.isEmpty() || 
        instructor == null || instructor.isEmpty() || 
        category == null || category.isEmpty() || 
        content == null || content.isEmpty()) {
        out.println("<script>alert('모든 필드를 입력해주세요.'); history.back();</script>");
        return;
    }

    // LectureDTO 객체 생성
    LectureDTO lecture = new LectureDTO(lectureID, lectureName, instructor, category, students, content);

    // LectureDAO 객체를 사용하여 강의 정보 업데이트
    LectureDAO lectureDAO = new LectureDAO();
    int rowsAffected = lectureDAO.updateLecture(lecture); // 업데이트된 행의 개수를 반환

    if (rowsAffected > 0) { // 1개 이상의 행이 업데이트된 경우
        // 성공 시 강의 상세 페이지로 리디렉션
        response.sendRedirect("lectureDetail.jsp?lectureID=" + lectureID);
    } else if (rowsAffected == 0) { // 업데이트된 행이 없을 경우
        out.println("<script>alert('업데이트된 내용이 없습니다. 다시 확인해주세요.'); history.back();</script>");
    } else { // -1 등의 오류가 발생한 경우
        out.println("<script>alert('강의 수정 중 오류가 발생했습니다.'); history.back();</script>");
    }
%>
