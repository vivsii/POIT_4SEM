package org.example.lab9;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

@WebFilter("/*")
public class LoggerFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        // Получаем информацию о запросе
        String method = httpRequest.getMethod();
        String servletName = httpRequest.getRequestURI();
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Логгируем информацию о запросе
        System.out.println("Request: method=" + method + ", servletName=" + servletName + ", timestamp=" + timestamp);

        // Передаем управление дальше по цепочке фильтров
        chain.doFilter(request, response);
    }
}
