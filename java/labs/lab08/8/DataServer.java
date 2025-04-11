import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class DataServer {
    public static void main(String[] args) {
        try {
            DatagramSocket socket = new DatagramSocket(3001);

            Thread receiveThread = new Thread(() -> {
                try {
                    while (true) {
                        byte[] buffer = new byte[1024];
                        DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
                        socket.receive(packet);

                        String receivedMessage = new String(packet.getData(), 0, packet.getLength());
                        System.out.println("Keep: " + receivedMessage);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });

            receiveThread.start();
            receiveThread.join();

            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
