<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Register</title>
  </head>
  <body>
    <h1>Регистрация нового пользователя</h1>
    <form action="register" method="post">
      <label for="username">Имя пользователя:</label>
      <input type="text" id="username" name="username" required /><br />

      <label for="password">Пароль:</label>
      <input type="password" id="password" name="password" required /><br />

      <label for="role">Роль:</label>
      <select id="role" name="role" required>
        <option value="user">Пользователь</option>
        <option value="admin">Администратор</option></select
      ><br />

      <input type="submit" value="Зарегистрироваться" />
    </form>
  </body>
</html>
