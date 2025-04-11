import java.util.List;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

import junit.framework.TestSuite;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

public class Main {

    private static final Logger logger = Logger.getLogger(Main.class.getName());

    public static void main(String[] args) {

        try {
            FileHandler fileHandler = new FileHandler("logfile.log");
            SimpleFormatter formatter = new SimpleFormatter();
            fileHandler.setFormatter(formatter);
            logger.addHandler(fileHandler);
        } catch (Exception e) {
            e.printStackTrace();
        }

        CityDAO cityDAO = new CityDAOImpl();


        logger.info("Получение жителей определенного города, говорящих на определенном языке:");
        List<Inhabitant> inhabitants = cityDAO.getInhabitantsByCityAndLanguage("Москва", "Русский");
        for (Inhabitant inhabitant : inhabitants) {
            logger.info("Тип жителя: " + inhabitant.getInhabitantTypeName() + ", Язык: " + inhabitant.getLanguageSpoken());
        }

        logger.info("Получение городов, в которых проживают жители определенного типа:");
        List<City> cities = cityDAO.getCitiesByInhabitantType("Рабочий");
        for (City city : cities) {
            logger.info("Город: " + city.getCityName() + ", Площадь: " + city.getArea());
        }

        logger.info("Получение информации о городе с населением, которое превышает 1 миллион человек:");
        City city = cityDAO.getCityByPopulationAndInhabitants(1000000);
        if (city != null) {
            logger.info("Город с населением более 1 миллиона человек: " + city.getCityName() + ", Население: " + city.getTotalPopulation());
        } else {
            logger.info("Город с населением более 1 миллиона человек не найден.");
        }

        logger.info("Получение информации о самом древнем типе жителя:");
        Inhabitant oldestInhabitant = cityDAO.getOldestInhabitantType();
        if (oldestInhabitant != null) {
            logger.info("Самый древний тип жителя: " + oldestInhabitant.getInhabitantTypeName());
        } else {
            logger.info("Информация о самом древнем типе жителя не найдена.");
        }

        // Запуск тестов
        Result result = JUnitCore.runClasses(TestSuite.class);

        //Вывод результатов тестирования
        for (Failure failure : result.getFailures()) {
            System.out.println(failure.toString());
        }

        if (result.wasSuccessful()) {
            System.out.println("Все тесты успешно пройдены");
        }


    }
}

