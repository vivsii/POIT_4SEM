package org.example.lab10;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.lab10.DataBase.DataBaseConnector;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "DeleteUniverServlet", value = "/DeleteUniverServlet")
public class DeleteUniverServlet extends HttpServlet {
    public void init() { }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        try {
            String deleteName = request.getParameter("deleteUniverName");

            if (deleteName == "" || deleteName == null) {
                request.setAttribute("deleteErrorText", Error.EmptyField);
                request.getRequestDispatcher("MainPage.jsp").forward(request, response);
                return;
            }
            if(IsMatchData(deleteName)){
                request.setAttribute("deleteErrorText", "Такого университета не существует!");
                request.getRequestDispatcher("MainPage.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            List<University> list = (List<University>) session.getAttribute("univerList");
            if (deleteUniver(deleteName)) {
                Iterator<University> listIterator = list.iterator();
                while (listIterator.hasNext()) {
                    University obj = listIterator.next();
                    if (obj.getName().equals(deleteName)) {
                        listIterator.remove();
                    }
                }
                session.setAttribute("univerList", list);
                response.sendRedirect("MainPage.jsp");
            } else {
                request.setAttribute("deleteErrorText", "университет не был удален!");
                request.getRequestDispatcher("MainPage.jsp").forward(request, response);
            }
        }catch(Exception e){
            request.setAttribute("exception", e);
            request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);
        }
    }

    public void destroy() {
    }

    private boolean deleteUniver(String name){
        boolean exists = false;
        String url = "jdbc:mysql://localhost/users_db?useSSL=false";
        String username = "root";
        String password = "123qweasdzxc";
        try{
            DataBaseConnector dbConnector = new DataBaseConnector(url,username,password);
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
            dbConnector.OpenConnection();
            if(dbConnector.deleteUniver(name)){
                exists = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
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

    private boolean IsMatchData(String univerName){
        boolean exists = false;
        String url = "jdbc:mysql://localhost/users_db?useSSL=false";
        String username = "root";
        String password = "123qweasdzxc";
        try {
            DataBaseConnector dbConnector = new DataBaseConnector(url,username,password);
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
            dbConnector.OpenConnection();
            exists = dbConnector.IsUniverInDB(univerName);
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
}