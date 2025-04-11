import java.awt.*;
import java.util.ArrayList;

public class Main {

    private final static int Amount_of_operators = 2;
    private final static int Amount_of_clients = 5;
    public static void main(String[] args) {
        ArrayList<Operator> operators = new ArrayList<>();

        for(int i=1;i< Amount_of_operators + 1;i++){
            operators.add(new Operator(i));
        }

        CallCenter callCenter = new CallCenter(operators);
        for(int i=1; i < Amount_of_clients + 1;i++) {
            Thread clientThread = new Thread(new Client(callCenter,i));
            clientThread.start();
        }
        }
    }