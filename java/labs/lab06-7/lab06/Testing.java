import org.junit.*;
import static org.junit.Assert.assertEquals;
public class Testing {
    static City city;

    @BeforeClass
    public static void setUp() {
        city = new City();
        city.setCityName("Москва");
        city.setYearFounded(1147);
        city.setArea(2511.0);
        city.setTotalPopulation(12655000);
        System.out.println("Подготовка объекта города перед запуском всех тестов");
    }

    @Before
    public void initTest() {
        System.out.println("Инициализация метода тестирования");
    }


    //проверка взаимодействия классов
    @Test
    public void testSetCityName() {
        City city = new City();
        city.setCityName("Москва");
        assertEquals("Москва", city.getCityName());
    }

    @Test
    public void testGetCityName() {
        System.out.println("Тестирование метода getCityName()");
        Assert.assertEquals("Москва", city.getCityName());
    }

    @Test
    public void testGetYearFounded() {
        System.out.println("Тестирование метода getYearFounded()");
        Assert.assertEquals(1147, city.getYearFounded());
    }

    @Test
    public void testGetArea() {
        System.out.println("Тестирование метода getArea()");
        Assert.assertEquals(2511.0, city.getArea(), 0.001);
    }

    @Test
    public void testGetTotalPopulation() {
        System.out.println("Тестирование метода getTotalPopulation()");
        Assert.assertEquals(12655000, city.getTotalPopulation());
    }

    @After
    public void tearDown() {
        System.out.println("Очистка после выполнения метода тестирования");
    }

    @AfterClass
    public static void tearDownClass() {
        System.out.println("Очистка объекта города после выполнения всех тестов");
    }

    @Ignore
    @Test
    public void testIgnoredMethod() {
        System.out.println("Этот метод тестирования игнорируется");
    }

    @Test(timeout = 10000) // Увеличиваем время тайм-аута до 10 секунд
    public void testMethodWithTimeout() {
        System.out.println("Тестирование метода с тайм-аутом");

        // Выполняем какую-то длительную операцию, которая превысит установленное время тайм-аута
        try {
            Thread.sleep(7000); // Спим на 7 секунд (эмулируем долгую операцию)
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
