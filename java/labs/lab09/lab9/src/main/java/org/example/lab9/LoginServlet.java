package org.example.lab9;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String username = req.getParameter("username");
    String password = req.getParameter("password");

    UserDao dao = new UserDao();

    User user = dao.getUser(username);

    if (user != null && BCrypt.verifyer().verify(password.toCharArray(), user.getPassword()).verified) {
      //authorized
      req.getSession().setAttribute("user", user);
      addCookies(resp, user);
      resp.sendRedirect("welcome.jsp");
    } else {
      // unauthorized
      req.setAttribute("error", "Invalid username or password");
      req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
  }

  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.getRequestDispatcher("login.jsp").forward(req, resp);
  }

  private void addCookies(HttpServletResponse response, User user) {
    LocalDateTime lastVisitTime = LocalDateTime.now();
    int visitCount = 1; // Начальное значение счетчика посещений

    // Создание кук
    Cookie lastVisitCookie = new Cookie("lastVisit", lastVisitTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm:ss")));
    Cookie visitCountCookie = new Cookie("visitCount", String.valueOf(visitCount));
    Cookie roleCookie = new Cookie("role", user.getRole());

    // Установка максимального времени жизни куков (в секундах)
    lastVisitCookie.setMaxAge(60 * 60 * 24); // 1 день
    visitCountCookie.setMaxAge(60 * 60 * 24); // 1 день
    roleCookie.setMaxAge(60 * 60 * 24); // 1 день

    // Добавление куков в ответ
    response.addCookie(lastVisitCookie);
    response.addCookie(visitCountCookie);
    response.addCookie(roleCookie);
}
}
