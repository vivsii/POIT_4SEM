import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Scanner;

public class DataClient {
    public static void main(String[] args){
        try{
            DatagramSocket socket = new DatagramSocket();
            InetAddress serverAddress = InetAddress.getByName("localhost");
            int serverPort = 3001;

            Scanner scanner = new Scanner(System.in);
            while(true){
                System.out.println("Text to message: ");
                String message = scanner.nextLine();

                if(message.equalsIgnoreCase("exit")){
                    break;
                }

                byte[] data = message.getBytes();
                DatagramPacket packet = new DatagramPacket(data, data.length, serverAddress, serverPort);
                socket.send(packet);

            }
            socket.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
