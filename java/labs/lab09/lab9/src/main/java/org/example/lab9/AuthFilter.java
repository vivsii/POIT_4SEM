package org.example.lab9;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class AuthFilter implements Filter{
  @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        User user = (User) httpRequest.getSession().getAttribute("user");

        if (user == null && !httpRequest.getRequestURI().endsWith("register.jsp") && !httpRequest.getRequestURI().endsWith("register") && !httpRequest.getRequestURI().endsWith("login.jsp") && !httpRequest.getRequestURI().endsWith("login")){
            httpResponse.sendRedirect("register.jsp");
            return;
        }

        chain.doFilter(request, response);
    } 
}
