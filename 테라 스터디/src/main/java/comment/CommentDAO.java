package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;

public class CommentDAO {

    // 댓글 등록 메서드
    public boolean addComment(int lectureID, String userID, String commentText) {
        String sql = "INSERT INTO comments (lectureID, userID, commentText) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, lectureID);
            pstmt.setString(2, userID);
            pstmt.setString(3, commentText);

            int result = pstmt.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 댓글 목록 조회 메서드
    public ArrayList<CommentDTO> getCommentsByLectureID(int lectureID) {
        String sql = "SELECT * FROM comments WHERE lectureID = ? ORDER BY commentDate DESC";
        ArrayList<CommentDTO> comments = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, lectureID);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CommentDTO comment = new CommentDTO(
                        rs.getInt("commentID"),
                        rs.getInt("lectureID"),
                        rs.getString("userID"),
                        rs.getString("commentText"),
                        rs.getTimestamp("commentDate")
                    );
                    comments.add(comment);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return comments;
    }
}
