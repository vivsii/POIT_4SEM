package org.example.lab9;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/fourth")
public class FourthServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Получаем параметры из запроса
        String param1 = request.getParameter("param1");
        String param2 = request.getParameter("param2");

        // Формируем ответ, содержащий значения параметров
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("Параметр 1: " + param1 + "<br>");
        out.println("Параметр 2: " + param2 + "<br>");
        out.println("</body></html>");
    }
}