package com.example.edms.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utility class for password hashing and validation.
 * Uses MD5 hashing as specified in the requirements for legacy compatibility.
 */
public class PasswordUtil {

    /**
     * Hash a password using MD5.
     * Note: MD5 is used for legacy compatibility. For new systems, use bcrypt or similar.
     * 
     * @param password the plain text password
     * @return the MD5 hashed password in uppercase hexadecimal
     */
    public static String hashPassword(String password) {
        if (password == null) {
            return null;
        }
        
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(password.getBytes());
            
            // Convert byte array to hexadecimal string
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String hex = Integer.toHexString(0xff & messageDigest[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            return hexString.toString().toUpperCase();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    /**
     * Verify a password against a hash.
     * 
     * @param password the plain text password to verify
     * @param hashedPassword the hashed password to compare against
     * @return true if the password matches the hash
     */
    public static boolean verifyPassword(String password, String hashedPassword) {
        if (password == null || hashedPassword == null) {
            return false;
        }
        
        String hashOfInput = hashPassword(password);
        return hashOfInput.equals(hashedPassword);
    }

    /**
     * Validate password complexity.
     * Requirements: minimum 8 characters, at least one uppercase, one number, one special character.
     * 
     * @param password the password to validate
     * @return true if password meets complexity requirements
     */
    public static boolean isPasswordComplex(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUppercase = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;
        
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUppercase = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (!Character.isLetterOrDigit(c)) {
                hasSpecial = true;
            }
        }
        
        return hasUppercase && hasDigit && hasSpecial;
    }

    /**
     * Generate a simple random password.
     * 
     * @return a randomly generated password
     */
    public static String generateRandomPassword() {
        String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lower = "abcdefghijklmnopqrstuvwxyz";
        String digits = "0123456789";
        String special = "!@#$%^&*";
        String all = upper + lower + digits + special;
        
        StringBuffer password = new StringBuffer();
        
        // Ensure at least one of each required character type
        password.append(upper.charAt((int)(Math.random() * upper.length())));
        password.append(digits.charAt((int)(Math.random() * digits.length())));
        password.append(special.charAt((int)(Math.random() * special.length())));
        
        // Fill the rest with random characters
        for (int i = 3; i < 12; i++) {
            password.append(all.charAt((int)(Math.random() * all.length())));
        }
        
        return password.toString();
    }
}
