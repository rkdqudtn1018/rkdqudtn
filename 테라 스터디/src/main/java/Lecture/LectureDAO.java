package Lecture;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.DatabaseUtil;

public class LectureDAO {

    // 전체 강의 목록을 가져오는 메서드
    public ArrayList<LectureDTO> getLectureList() {
        ArrayList<LectureDTO> lectureList = new ArrayList<>();
        String SQL = "SELECT * FROM lecture"; // 실제 강의 테이블에 맞게 쿼리 수정
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                LectureDTO lecture = new LectureDTO(
                    rs.getInt("lectureID"),
                    rs.getString("lectureName"),
                    rs.getString("instructor"),
                    rs.getString("category"),
                    rs.getInt("students"),
                    rs.getString("content")
                );
                lectureList.add(lecture);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lectureList;
    }

    // 강의 ID로 강의 정보를 가져오는 메서드
    public LectureDTO getLectureById(int lectureID) {
        LectureDTO lecture = null;
        String sql = "SELECT lectureID, lectureName, instructor, category, students, content FROM lecture WHERE lectureID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, lectureID);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 결과가 있으면 LectureDTO 객체 생성하여 데이터 설정
                    lecture = new LectureDTO(
                        rs.getInt("lectureID"),
                        rs.getString("lectureName"),
                        rs.getString("instructor"),
                        rs.getString("category"),
                        rs.getInt("students"),
                        rs.getString("content")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lecture;
    }

    // 새로운 강의를 추가하는 메서드
    public int addLecture(LectureDTO lecture) {
        String SQL = "INSERT INTO lecture (lectureName, instructor, category, students, content) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setString(1, lecture.getLectureName());
            pstmt.setString(2, lecture.getInstructor());
            pstmt.setString(3, lecture.getCategory());
            pstmt.setInt(4, lecture.getStudents());
            pstmt.setString(5, lecture.getContent());

            return pstmt.executeUpdate(); // 성공적으로 추가되면 1 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 오류 발생 시 -1 반환
    }

    // 강의 정보를 업데이트하는 메서드
    public int updateLecture(LectureDTO lecture) {
        String sql = "UPDATE lecture SET lectureName = ?, instructor = ?, category = ?, students = ?, content = ? WHERE lectureID = ?";
        int result = 0;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, lecture.getLectureName());
            pstmt.setString(2, lecture.getInstructor());
            pstmt.setString(3, lecture.getCategory());
            pstmt.setInt(4, lecture.getStudents());
            pstmt.setString(5, lecture.getContent());
            pstmt.setInt(6, lecture.getLectureID());

            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 강의 삭제 메서드
    public int deleteLecture(int lectureID) {
        String sql = "DELETE FROM lecture WHERE lectureID = ?";
        int result = 0;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, lectureID);
            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 강의 검색 메서드 (강의 이름과 내용을 검색)
    public ArrayList<LectureDTO> searchLectures(String keyword) {
        ArrayList<LectureDTO> lectureList = new ArrayList<>();
        String sql = "SELECT * FROM lecture WHERE lectureName LIKE ? OR content LIKE ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 검색어에 와일드카드 추가
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    LectureDTO lecture = new LectureDTO(
                        rs.getInt("lectureID"),
                        rs.getString("lectureName"),
                        rs.getString("instructor"),
                        rs.getString("category"),
                        rs.getInt("students"),
                        rs.getString("content")
                    );
                    lectureList.add(lecture);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lectureList;
    }
}
