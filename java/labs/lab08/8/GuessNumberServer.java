import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Random;

public class GuessNumberServer {
    public static void main(String args[]) throws IOException {
        ServerSocket serverSocket = null;
        BufferedReader inbound = null;
        OutputStream outbound = null;

        serverSocket = new ServerSocket(8888);
        System.out.println();
        while(true){
            Socket clientSocket = serverSocket.accept();
            System.out.println("Client connected: " + clientSocket.getInetAddress());

            Random random = new Random();
            int secretNumber = random.nextInt(100) + 1;

            BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);

            out.println("1-100:");
            while(true){
                String guess = in.readLine();
                if(guess == null){
                    break;
                }

                int userGuess = Integer.parseInt(guess);
                if(userGuess == secretNumber){
                    out.println("Win!");
                    break;
                }
                else if(userGuess < secretNumber){
                    out.println(">");
                }
                else{
                    out.println("<");
                }
            }

            clientSocket.close();
            System.out.println("disconnect");
        }
    }
}
