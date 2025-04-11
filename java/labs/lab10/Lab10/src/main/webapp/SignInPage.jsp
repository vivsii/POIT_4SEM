<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
</head>
<body>
<h3>Вход</h3>
<form action="SignInServlet">
  <label>Логин </label><br>
  <input type="text" name="login_signin" placeholder="Логин"/><br>
  <label>Пароль </label><br>
  <input type="password" name="passworn_signin" placeholder="Пароль"/><br>
  <input type="submit" value="Войти"/>
  <p>${errorText}</p>
</form>
<a href="RegisterPage.jsp">Регистрация</a>
</body>
</html>