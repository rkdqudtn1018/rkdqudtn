package util;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

public class Gmail extends Authenticator {

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("mi011018@g.shingu.ac.kr", "rkdqudtn12@");
    }
}
