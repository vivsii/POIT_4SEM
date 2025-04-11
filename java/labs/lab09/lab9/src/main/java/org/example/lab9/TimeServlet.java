package org.example.lab9;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "TimeServlet", value = "/time-servlet")
public class TimeServlet extends HttpServlet{
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.setContentType("text/html");
    PrintWriter out = resp.getWriter();

    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
    String currentTime = sdf.format(new Date());

    String protocol = req.getProtocol();
    String clientIP = req.getRemoteAddr();
    String clientName = req.getRemoteHost();
    String method = req.getMethod();
    String url = req.getRequestURL().toString();

    out.println("<html>");
    out.println("<head><title>Current Time</title></head>");
    out.println("<body>");
    out.println("<h1>Current Time: " + currentTime + "</h1>");
    out.println("<p>Protocol: " + protocol + "</p>");
    out.println("<p>Client IP: " + clientIP + "</p>");
    out.println("<p>Client Name: " + clientName + "</p>");
    out.println("<p>Method: " + method + "</p>");
    out.println("<p>URL: " + url + "</p>");

    out.println("<h2>Requst Headers</h2>");
    out.println("<table>");
    Enumeration<String> headerNames = req.getHeaderNames();
    while (headerNames.hasMoreElements()) {
      String headerName = headerNames.nextElement();
      String headerValue = req.getHeader(headerName);
      out.println("<tr><td>" + headerName + "</td><td>" + headerValue + "</td></tr>");
    }
    out.println("</table>");

    out.println("</body>");
    out.println("</html>");
  }
}
