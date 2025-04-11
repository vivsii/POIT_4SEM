package org.example.lab9;

public class User {
  private String username; 
  private String role;
  private String password;

  public User(String username, String role, String password) {
    this.username = username;
    this.role = role;
    this.password = password;
  }

  public String getUsername() {
    return this.username;
  }

  public String getPassword() {
    return this.password;
  }

  public String getRole() {
    return this.role;
  }
}
