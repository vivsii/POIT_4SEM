<%--
  Created by IntelliJ IDEA.
  User: Ваня
  Date: 13.04.2024
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>Регистрация</h3>
<form action="RegisterUserServlet">
    <label>Логин </label><br>
    <input type="text" name="login_register" placeholder="Логин"/><br>
    <label>Пароль </label><br>
    <input type="password" name="passworn_register" placeholder="Пароль"/><br>
    <input type="submit" value="Зарегестрироваться"/>
    <p>${errorText}</p>
</form>
<a href="SignInPage.jsp">Вход</a>
</body>
</html>
