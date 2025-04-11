package org.example.lab10.DataBase;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordHasher {
    public static String hashPassword(String password) {
        try {
            // Получение экземпляра объекта MessageDigest с указанным алгоритмом хеширования
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            // Хеширование пароля
            byte[] hash = digest.digest(password.getBytes());

            // Преобразование хеша в строку шестнадцатеричного представления
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            // Обработка исключения, если алгоритм хеширования не найден
            e.printStackTrace();
            return null;
        }
    }
}
