import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Scanner;

public class GuessNumberClient {
    public static void main(String[] args) {
        try {

            Socket socket = new Socket("localhost", 8888);


            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);


            String welcomeMessage = in.readLine();
            System.out.println(welcomeMessage);


            Scanner scanner = new Scanner(System.in);
            while (true) {
                System.out.print("your guess: ");
                String userGuess = scanner.nextLine();


                out.println(userGuess);


                String response = in.readLine();
                System.out.println(response);

                if (response.contains("Win!")) {
                    break;
                }
            }

            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
