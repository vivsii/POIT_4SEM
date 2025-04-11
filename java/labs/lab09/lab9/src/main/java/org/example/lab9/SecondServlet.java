package org.example.lab9;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SecondServlet", value = "/second")
public class SecondServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String param1 = request.getParameter("param1");
    String param2 = request.getParameter("param2");

    request.setAttribute("param1", param1);
    request.setAttribute("param2", param2);
    request.getRequestDispatcher("/result.jsp").forward(request, response);
  }
}
