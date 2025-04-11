<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Current Time</title>
  </head>
  <body>
    <h1>Click the button to get the current time:</h1>
    <form action="time-servlet" method="get">
      <input type="submit" value="Get Current Time" />
    </form>
    <a href="first?param1=value1&param2=value2">Перейти на первый сервлет</a>
  </body>
</html>
