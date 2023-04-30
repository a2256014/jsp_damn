package fintech_pj_damn;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Base64;
import java.util.regex.*;

public class AESUtil {
    private static final String SECRET_KEY = "MySecretKey";
    private static final String HASH_ALGORITHM = "SHA-256";

    private static SecretKeySpec generateKey(String secretKey) throws Exception {
        MessageDigest sha = MessageDigest.getInstance(HASH_ALGORITHM);
        byte[] key = sha.digest(secretKey.getBytes("UTF-8"));
        key = Arrays.copyOf(key, 16);
        return new SecretKeySpec(key, "AES");
    }

    public static String encrypt(String input, int BoardId) throws Exception {
        SecretKeySpec key = generateKey(SECRET_KEY + String.valueOf(BoardId));
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] encrypted = cipher.doFinal(input.getBytes());

        String result = Base64.getEncoder().encodeToString(encrypted);
        final Pattern SpecialChars = Pattern.compile("/");
        result = SpecialChars.matcher(result).replaceAll("_");
        System.out.println("암호화 명 : " + result);

        return result;
    }

    public static String decrypt(String encrypted, int BoardId) throws Exception {
        SecretKeySpec key = new SecretKeySpec((SECRET_KEY + String.valueOf(BoardId)).getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, key);

        final Pattern SpecialChars = Pattern.compile("_");
        encrypted = SpecialChars.matcher(encrypted).replaceAll("/");

        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(encrypted));
        String result = new String(decrypted);

        System.out.println("복호화 명 : " + result);

        return result;
    }
}
