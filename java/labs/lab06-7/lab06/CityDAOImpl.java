import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CityDAOImpl implements CityDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/City";
    private static final String USER = "root";
    private static final String PASSWORD = "Pikpikapov22";

    @Override
    public List<Inhabitant> getInhabitantsByCityAndLanguage(String cityName, String language) {
        List<Inhabitant> inhabitants = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM Inhabitants i JOIN Cities c ON i.city_id = c.city_id WHERE c.city_name = ? AND i.language_spoken = ?")) {
            statement.setString(1, cityName);
            statement.setString(2, language);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Inhabitant inhabitant = new Inhabitant();
                inhabitant.setInhabitantTypeName(resultSet.getString("inhabitant_type_name"));
                inhabitant.setLanguageSpoken(resultSet.getString("language_spoken"));
                inhabitants.add(inhabitant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inhabitants;
    }

    @Override
    public List<City> getCitiesByInhabitantType(String inhabitantType) {
        List<City> cities = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM Cities c JOIN Inhabitants i ON c.city_id = i.city_id WHERE i.inhabitant_type_name = ?")) {
            statement.setString(1, inhabitantType);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                City city = new City();
                city.setCityId(resultSet.getInt("city_id"));
                city.setCityName(resultSet.getString("city_name"));
                city.setYearFounded(resultSet.getInt("year_founded"));
                city.setArea(resultSet.getDouble("area"));
                city.setTotalPopulation(resultSet.getInt("total_population"));
                cities.add(city);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cities;
    }

    @Override
    public City getCityByPopulationAndInhabitants(int population) {
        City city = null;
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM Cities c WHERE c.total_population >= ?")) {
            statement.setInt(1, population);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                city = new City();
                city.setCityId(resultSet.getInt("city_id"));
                city.setCityName(resultSet.getString("city_name"));
                city.setYearFounded(resultSet.getInt("year_founded"));
                city.setArea(resultSet.getDouble("area"));
                city.setTotalPopulation(resultSet.getInt("total_population"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return city;
    }


    @Override
    public Inhabitant getOldestInhabitantType() {
        Inhabitant oldestInhabitant = null;
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT * FROM Inhabitants ORDER BY inhabitant_id ASC LIMIT 1")) {
            if (resultSet.next()) {
                oldestInhabitant = new Inhabitant();
                oldestInhabitant.setInhabitantId(resultSet.getInt("inhabitant_id"));
                oldestInhabitant.setCityId(resultSet.getInt("city_id"));
                oldestInhabitant.setInhabitantTypeName(resultSet.getString("inhabitant_type_name"));
                oldestInhabitant.setLanguageSpoken(resultSet.getString("language_spoken"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return oldestInhabitant;
    }
}
