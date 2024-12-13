package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import util.SHA256;

import util.DatabaseUtil;


public class UserDAO {


	public int login(String userID, String userPassword) {
	    String SQL = "SELECT userPassword FROM user WHERE userID = ?";
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        conn = DatabaseUtil.getConnection();
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID); 
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            // 데이터베이스에 저장된 암호화된 비밀번호 가져오기
	            String storedPassword = rs.getString("userPassword");  
	            // 사용자가 입력한 비밀번호 암호화
	            String encryptedPassword = SHA256.getSHA256(userPassword); 
	            
	            System.out.println("Database Password: " + storedPassword);  // 데이터베이스의 암호화된 비밀번호
	            System.out.println("Encrypted Input Password: " + encryptedPassword);  // 사용자가 입력한 비밀번호의 암호화된 값

	            
	            // 저장된 암호화된 비밀번호와 입력된 암호화된 비밀번호 비교
	            if (storedPassword.equals(encryptedPassword)) {
	                return 1; // 로그인 성공
	            } else {
	                return 0; // 비밀번호 틀림
	            }
	        }
	        return -1; // 아이디 없음
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
	        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
	        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
	    }
	    return -2; // 데이터베이스 오류
	}

    
    public Map<String, String> getUserInfo(String userID) {
        String SQL = "SELECT userName, userEmail, userID, userPassword, job FROM user WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); 
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	Map<String, String> userInfo = new HashMap<>();
            	userInfo.put("userName", rs.getString(1));
            	userInfo.put("userEmail", rs.getString(2));
            	userInfo.put("userID", rs.getString(3));
            	userInfo.put("userPassword", rs.getString(4));
            	userInfo.put("job", rs.getString(5));
            	
            	return userInfo;
            }
            return null; // 아이디 없음
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return null; // 데이터베이스 오류
    }

    public int join(UserDTO user) {
        String SQL = "INSERT INTO user (userName, userEmail, userID, userPassword, job) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, user.getUserEmail());
            pstmt.setString(3, user.getUserID());
            pstmt.setString(4, user.getUserPassword());
            pstmt.setString(5, user.getJob()); // job 필드 추가
            return pstmt.executeUpdate(); // 성공 시 1 반환
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -1; // 회원가입 실패 시 -1 반환
    }

    public boolean checkDuplicate(String userID) {
        String SQL = "SELECT userID FROM user WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return true; // 중복됨
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return false; // 중복되지 않음
    }
}
