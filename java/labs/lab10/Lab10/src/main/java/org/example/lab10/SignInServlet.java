package org.example.lab10;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.lab10.DataBase.DataBaseConnector;
import org.example.lab10.DataBase.PasswordHasher;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SignInServlet", value = "/SignInServlet")
public class SignInServlet extends HttpServlet {
    public void init() { }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");

            String login = request.getParameter("login_signin");
            String password = request.getParameter("passworn_signin");

            if (login == "" || login == null || password == "" || password == null) {
                request.setAttribute("errorText", Error.EmptyField);
                request.getRequestDispatcher("RegisterPage.jsp").forward(request, response);
            }

            if (IsMatchData(PasswordHasher.hashPassword(password), login)) {
                List<University> univerList = new ArrayList<>();
                univerList = getUniversities();

                HttpSession session = request.getSession();
                session.setAttribute("login", login);
                session.setAttribute("univerList", univerList);
                response.sendRedirect("MainPage.jsp");
            } else {
                request.setAttribute("errorText", Error.UserNotFound);
                request.getRequestDispatcher("SignInPage.jsp").forward(request, response);
            }
        }catch(Exception e){
            request.setAttribute("exception", e);
            request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);
        }
    }

    public void destroy() {
    }

    private boolean IsMatchData(String hashPassword, String login){
        boolean exists = false;
        String url = "jdbc:mysql://localhost/users_db?useSSL=false";
        String username = "root";
        String password = "123qweasdzxc";
        try {
            DataBaseConnector dbConnector = new DataBaseConnector(url,username,password);
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
            dbConnector.OpenConnection();
            exists = dbConnector.IsUserInDB(login,hashPassword);
            dbConnector.CloseConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (InvocationTargetException e) {
            throw new RuntimeException(e);
        } catch (InstantiationException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        } catch (NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
        return exists;
    }

    private List<University> getUniversities(){
        String url = "jdbc:mysql://localhost/users_db?useSSL=false";
        String username = "root";
        String password = "123qweasdzxc";
        try{
            DataBaseConnector dbConnector = new DataBaseConnector(url,username,password);
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
            dbConnector.OpenConnection();
            return dbConnector.getAllUnivers();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (InvocationTargetException e) {
            throw new RuntimeException(e);
        } catch (InstantiationException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        } catch (NoSuchMethodException e) {
            throw new RuntimeException(e);
        }

    }

}
