package org.example.lab9;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/third")
public class ThirdServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Получаем параметры из запроса
        String param1 = request.getParameter("param1");
        String param2 = request.getParameter("param2");

        // Формируем GET-запрос ко второму сервлету и передаем параметры
        String url = "/fourth?param1=" + param1 + "&param2=" + param2;
        request.getRequestDispatcher(url).forward(request, response);
    }
}