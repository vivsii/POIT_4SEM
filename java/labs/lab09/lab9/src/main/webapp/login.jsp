<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Login</title>
  </head>
  <body>
    <h1>Вход в систему</h1>
    <% if (request.getAttribute("error") != null) { %>
    <p style="color: red"><%= request.getAttribute("error") %></p>
    <% } %>
    <form action="login" method="post">
      <label for="username">Имя пользователя:</label>
      <input type="text" id="username" name="username" required /><br />

      <label for="password">Пароль:</label>
      <input type="password" id="password" name="password" required /><br />

      <input type="submit" value="Войти" />
    </form>
    <a href="register.jsp">Зарегистрироваться</a>
  </body>
</html>
