import org.junit.*;

public class CityTest {
    static City city;

    @BeforeClass
    public static void setUp() {
        city = new City();
        city.setCityName("Moscow");
        city.setYearFounded(1147);
        city.setArea(2511.0);
        city.setTotalPopulation(12655000);
        System.out.println("Before Class: Setting up the city object");
    }

    @Before
    public void initTest() {
        System.out.println("Before Test: Initializing test method");
    }

    @Test
    public void testGetCityName() {
        System.out.println("Testing getCityName()");
        Assert.assertEquals("Moscow", city.getCityName());
    }

    @Test
    public void testGetYearFounded() {
        System.out.println("Testing getYearFounded()");
        Assert.assertEquals(1147, city.getYearFounded());
    }

    // Другие методы тестирования

    @After
    public void tearDown() {
        System.out.println("After Test: Cleaning up after test method");
    }

    @AfterClass
    public static void tearDownClass() {
        System.out.println("After Class: Cleaning up the city object");
    }

    @Ignore
    @Test
    public void testIgnoredMethod() {
        System.out.println("This test method is ignored");
    }

    @Test(timeout = 100)
    public void testMethodWithTimeout() {
        System.out.println("Testing method with timeout");
        while (true) {
            // Бесконечный цикл для демонстрации timeout
        }
    }
}
