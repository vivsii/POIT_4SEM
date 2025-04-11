package org.example.lab9;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "FirstServlet", value = "/first")
public class FirstServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String param1 = request.getParameter("param1");
    String param2 = request.getParameter("param2");

    response.sendRedirect(request.getContextPath() + "/second?param1=" + param1 + "&param2=" + param2);
  }
}
