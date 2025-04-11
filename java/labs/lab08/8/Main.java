import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

public class Main {
    public static void main(String[] args) {
        try {

            URL url = new URL("https://www.google.com");


            URLConnection connection = url.openConnection();


            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();


            System.out.println(content.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
