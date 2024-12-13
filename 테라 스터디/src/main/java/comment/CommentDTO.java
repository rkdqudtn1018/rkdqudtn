package comment;

import java.sql.Timestamp;

public class CommentDTO {
    private int commentID;
    private int lectureID;
    private String userID;
    private String commentText;
    private Timestamp commentDate;

    public CommentDTO(int commentID, int lectureID, String userID, String commentText, Timestamp commentDate) {
        this.commentID = commentID;
        this.lectureID = lectureID;
        this.userID = userID;
        this.commentText = commentText;
        this.commentDate = commentDate;
    }

    // Getter & Setter
    public int getCommentID() { return commentID; }
    public void setCommentID(int commentID) { this.commentID = commentID; }

    public int getLectureID() { return lectureID; }
    public void setLectureID(int lectureID) { this.lectureID = lectureID; }

    public String getUserID() { return userID; }
    public void setUserID(String userID) { this.userID = userID; }

    public String getCommentText() { return commentText; }
    public void setCommentText(String commentText) { this.commentText = commentText; }

    public Timestamp getCommentDate() { return commentDate; }
    public void setCommentDate(Timestamp commentDate) { this.commentDate = commentDate; }
}
