package org.example.lab9;

import java.io.IOException;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "registerServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    System.out.println("RegisterServlet: doPost() called");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String hashedPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());
    String role = request.getParameter("role");

    UserDao userDao = new UserDao();
    boolean success = userDao.registerUser(username, hashedPassword, role);

    if (success) {
        // Пользователь успешно зарегистрирован
        System.out.println("RegisterServlet: User registered successfully");
        response.sendRedirect("login.jsp");
    } else {
        // Ошибка при регистрации
        System.out.println("RegisterServlet: User registration failed");
        request.setAttribute("error", "Ошибка при регистрации. Пожалуйста, попробуйте еще раз.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.getRequestDispatcher("register.jsp").forward(request, response);
  }
}
