import java.util.List;

public interface CityDAO {
    List<Inhabitant> getInhabitantsByCityAndLanguage(String cityName, String language);
    List<City> getCitiesByInhabitantType(String inhabitantType);
    City getCityByPopulationAndInhabitants(int population);
    Inhabitant getOldestInhabitantType();
}