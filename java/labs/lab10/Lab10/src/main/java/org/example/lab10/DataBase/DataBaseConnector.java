package org.example.lab10.DataBase;

import org.example.lab10.University;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DataBaseConnector {

    Connection connection;
    String url;
    String user;
    String pass;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
    private final static String SQL_SELECT = "SELECT COUNT(*) as row_count FROM users WHERE login = ? AND hashPassword = ?";
    private final static String SQL_INSERT = "INSERT INTO users values (?, ?)";
    public DataBaseConnector(String url, String user, String pass) {
        this.url = url;
        this.user = user;
        this.pass = pass;
    }

    public void OpenConnection() throws SQLException {
        connection  = DriverManager.getConnection(url, user, pass);
        if(!connection.isClosed()){
            System.out.println("Подключение прошло успешно!");
        }
        else{
            System.out.println("Ошибка подключения!");
        }
    }

    public boolean IsUserInDB(String login, String hashPassword) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT);
        preparedStatement.setString(1, String.valueOf(login));
        preparedStatement.setString(2, String.valueOf(hashPassword));
        ResultSet res = preparedStatement.executeQuery();
        if(res.next()){
            int rowCount = res.getInt("row_count");
            return rowCount != 0;
        }
        return false;
    }
    public boolean RegisterUser(String login, String hashPassword) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(SQL_INSERT);
        preparedStatement.setString(1, String.valueOf(login));
        preparedStatement.setString(2, String.valueOf(hashPassword));
        int res = preparedStatement.executeUpdate();
        return res > 0;
    }

    public List<University> getAllUnivers() {
        List<University> userList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM univer");
            ResultSet res = preparedStatement.executeQuery();

            while (res.next()) {
                String name = res.getString("name");
                String city = res.getString("city");
                userList.add(new University(name, city));
            }
            res.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean addUniver(String name, String city) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO univer values (?, ?)");
        preparedStatement.setString(1, String.valueOf(name));
        preparedStatement.setString(2, String.valueOf(city));
        int res = preparedStatement.executeUpdate();
        return res > 0;
    }

    public boolean deleteUniver(String name) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("DELETE from univer WHERE name = ?");
        preparedStatement.setString(1, String.valueOf(name));
        int res = preparedStatement.executeUpdate();
        return res > 0;
    }

    public boolean IsUniverInDB(String univerName) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT COUNT(*) WHERE name = ?");
        preparedStatement.setString(1, String.valueOf(univerName));
        ResultSet res = preparedStatement.executeQuery();
        if(res.next()){
            int rowCount = res.getInt("row_count");
            return rowCount != 0;
        }
        return false;
    }

    public void CloseConnection() throws SQLException {
        connection.close();
        System.out.println("Подключение удалено!");
    }
    public void CloseStatement(Statement statement) throws SQLException {
        statement.close();
    }
}