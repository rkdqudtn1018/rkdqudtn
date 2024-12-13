package util;

import java.security.MessageDigest;

public class SHA256 {

    public static String getSHA256(String input) {
        StringBuilder result = new StringBuilder();
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256"); // 알고리즘 이름 수정
            byte[] salt = "Hello! This is Salt.".getBytes(); // 고정된 Salt, 필요에 따라 유동적 Salt 고려
            digest.reset();
            digest.update(salt);
            byte[] chars = digest.digest(input.getBytes("UTF-8"));
            for (byte b : chars) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) result.append("0");
                result.append(hex);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.toString();
    }
}
