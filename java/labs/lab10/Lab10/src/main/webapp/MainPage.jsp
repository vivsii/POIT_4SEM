<%@ page import="org.example.lab10.University" %>
<%@ page import="java.util.List" %><%--
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
    <style>
        *{
            margin: 5px;
        }
        main{
            display: flex;
            flex-direction: row;
        }
    </style>
</head>
<body>
<jsp:include page="Header.jsp"/>
    <main>
        <div>
            <table border="1">
                <thead>
                <tr>
                    <th>Название</th>
                    <th>Город</th>
                </tr>
                </thead>
                <tbody>
                <%-- В этом примере предполагается, что у вас есть список объектов User --%>
                <% for (University univer : (List<University>)session.getAttribute("univerList")) { %>
                <tr>
                    <td><%= univer.getName() %></td>
                    <td><%= univer.getCity() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <div>
            <form action="MainPageServlet">
                <h3>Добавление университета</h3>
                <input type="text" name="univername" placeholder="Название"/><br>
                <input type="text" name="univercity" placeholder="Город"/><br>
                <input type="submit" value="добавить"/><br>
                <p>${addErrorText}</p>
            </form>
            <form action="DeleteUniverServlet">
                <h3>Удаление университета</h3>
                <label>Название универстета: </label>
                <input type="text" name="deleteUniverName"/><br>
                <input type="submit" value="Удалить"/>
                <p>${deleteErrorText}</p>
            </form>
        </div>
    </main>
<jsp:include page="Footer.jsp"/>
</body>
</html>
