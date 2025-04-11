package by.belstu.lab12;


import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class DAO implements IConnection, IQuery {
    private String url;
    private String user;
    private String password;
    private String driver;
    private Connection con;
    private Statement statement;

    public DAO() {

    }

    public ArrayList<String> getProperties() {

        ResourceBundle resourceBundle = ResourceBundle.getBundle("db");
        driver = "org.postgresql.Driver";
        url = "jdbc:postgresql://localhost:5432/lab9";
        user = "postgres";
        password = "12345";
        try {
            Class.forName(driver).getDeclaredConstructor().newInstance();
        } catch (ClassNotFoundException | NoSuchMethodException | InstantiationException | IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException("Driver class is missing in classpath", e);
        }

        ArrayList<String> ret = new ArrayList<>();
        ret.add(url);
        ret.add(user);
        ret.add(password);
        return ret;
    }
    public Boolean getConnection() {
        try {
            getProperties();
            con = DriverManager.getConnection(url, user, password);
            statement = con.createStatement(); // Добавленная строка
            return true;
        }
        catch(Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public ResultSet ExecuteQuery(String sqlQuery) {
        try {
            if (getConnection()) {
                return statement.executeQuery(sqlQuery);
            } else {
                return null;
            }
        }
        catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    public void closeConnection()
    {
        try {
            con.close();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
