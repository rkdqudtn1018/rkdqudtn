package user;

public class UserDTO {
    private String userName;
    private String userEmail;
    private String userID;
    private String userPassword;
    private String job; // 새로 추가된 필드

    // 모든 필드를 포함한 생성자
    public UserDTO(String userName, String userEmail, String userID, String userPassword, String job) {
        this.userName = userName;
        this.userEmail = userEmail;
        this.userID = userID;
        this.userPassword = userPassword;
        this.job = job; // job 필드 초기화
    }

    // Getter 및 Setter 추가
    

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }
    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }
}
