<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="java.time.LocalDateTime" %> <%@ page
import="java.time.format.DateTimeFormatter" %> <%@ page
import="org.example.lab9.User" %>
<html>
  <head>
    <title>Welcome</title>
  </head>
  <body>
    <%  User user = (User) session.getAttribute("user"); 
          if (user != null) {
            Cookie[] cookies = request.getCookies();
            String lastVisit = null; 
            int visitCount = 0; 
            String role = null; 
            for (Cookie cookie : cookies) { 
              if (cookie.getName().equals("lastVisit")) { 
                lastVisit = cookie.getValue(); 
              } else if (cookie.getName().equals("visitCount")) {
                visitCount = Integer.parseInt(cookie.getValue()); 
              } else if (cookie.getName().equals("role")) { 
                role = cookie.getValue(); 
              } 
            } 
      %>
    <h1>Добро пожаловать, <%= user.getUsername() %>!</h1>
    <p>Ваша роль: <%= role %></p>
    <p>Последний визит: <%= lastVisit %></p>
    <p>Количество визитов: <%= visitCount %></p>
    <p>
      Текущая дата: <%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %>
    </p>
    <% } else { %>
    <p>
      Вы не авторизованы. Пожалуйста, <a href="login.jsp">войдите в систему</a>.
    </p>
    <% } %>
  </body>
</html>
