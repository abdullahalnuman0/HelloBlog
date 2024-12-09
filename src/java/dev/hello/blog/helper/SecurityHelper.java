package dev.hello.blog.helper;

import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;

public class SecurityHelper {

    public static String encodeData(String data) {

        try {

            byte[] bytes = data.getBytes(StandardCharsets.UTF_8);

            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, getSecretKey());
            byte[] encryptBytes = cipher.doFinal(bytes);
            return Base64.getUrlEncoder().encodeToString(encryptBytes);

        } catch (InvalidKeyException | NoSuchAlgorithmException | BadPaddingException | IllegalBlockSizeException | NoSuchPaddingException ex) {
            ex.printStackTrace();
        }

        return null;
    }

    public static String encodeData(int data) {

        return encodeData(String.valueOf(data));
    }

    public static String decodeData(String data) {

        try {

            byte[] decodedBytes = Base64.getUrlDecoder().decode(data);

            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, getSecretKey());
            byte[] decryptByte = cipher.doFinal(decodedBytes);

            return new String(decryptByte, StandardCharsets.UTF_8);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public static String decodeData(int data) {

        return decodeData(String.valueOf(data));

    }

    public static SecretKeySpec getSecretKey() {

        String pass = "G!mA$C*X#n-Q=/W|";
        byte[] passBytes = pass.getBytes(StandardCharsets.UTF_8);

//        SecretKeySpec secretKey = new SecretKeySpec(passBytes, "AES");
//        return secretKey;
        return new SecretKeySpec(passBytes, "AES");

    }

}
