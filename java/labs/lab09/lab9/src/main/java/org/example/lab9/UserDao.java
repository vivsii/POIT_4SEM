package org.example.lab9;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {
  private static final String dsn = "jdbc:sqlite:D:/уник/java/лабораторные/lab09/lab9/store.db";

  public UserDao() {
    try (Connection conn = DriverManager.getConnection(dsn)) {
      String query = "CREATE TABLE IF NOT EXISTS users (username TEXT, password TEXT, role TEXT)";
      conn.createStatement().execute(query);
    } catch (Exception e) {}
  }

  public User getUser(String username) {
    try {
      Class.forName("org.sqlite.JDBC");
      Connection conn = DriverManager.getConnection(dsn);
      String query = "SELECT * FROM users WHERE username = ?";
      PreparedStatement statement = conn.prepareStatement(query);
      statement.setString(1, username);

      ResultSet resultSet = statement.executeQuery();
      if (resultSet.next()) {
          String role = resultSet.getString("role");
          String passwrod = resultSet.getString("password");
          System.out.println("UserDao: Successfully logged in as " + username + " with role " + role);
          return new User(username, role, passwrod);
      }
    } catch (Exception e) {
      System.out.println("UserDao: Failed to log in as " + username);
      System.out.println(e.getMessage());
    }
    return null;
  }

  public boolean registerUser(String username, String password, String role) {
    try {
      Class.forName("org.sqlite.JDBC");
      Connection conn = DriverManager.getConnection(dsn);
      String query = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
      PreparedStatement statement = conn.prepareStatement(query);
      statement.setString(1, username);
      statement.setString(2, password);
      statement.setString(3, role);

      return statement.executeUpdate() == 1;
    } catch (Exception e) {
      System.out.println("UserDao: Failed to register user " + username);
      System.out.println(e.getMessage());
    }

    return false;
  }
}
