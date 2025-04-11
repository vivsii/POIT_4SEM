

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import static org.junit.Assert.assertEquals;

@RunWith(Suite.class)
@Suite.SuiteClasses({Testing.class})
public class Testing2 {
    @Test
    public void testInteraction() {
        City testCity = new City();
        testCity.setCityName("TestCity");
        assertEquals("TestCity", testCity.getCityName());
    }
}
