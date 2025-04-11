import javax.management.openmbean.OpenMBeanAttributeInfo;
import java.util.ArrayList;

public class CallCenter {
    private final static int MaxAttemptsAmount = 5;
    private ArrayList<Operator> operators;

    public CallCenter(ArrayList<Operator> operators){
        this.operators = operators;
    }
    public synchronized Operator tryCall(Client client, int waiting_time){

        int attempts = 0;
        boolean success = false;

        while (!success){
            for(var operator: operators){
                if(searchForOperator(operator,client)){
                    return operator;
                }
            }

            if(!success){
                try {
                    attempts++;
                    if (checkAttempts(attempts, MaxAttemptsAmount, waiting_time, client)) {
                        return null;
                    }
                }
                catch (InterruptedException e){
                    e.printStackTrace();
                }
            }
        }

        return null;
    }

    public synchronized  void endCall(Operator operator){
        operator.setClient(null);
        operators.add(operator);
        notify();
    }
    public synchronized boolean checkAttempts(int attempts,int max_attempts,int waiting_time, Client client) throws InterruptedException{
        if(attempts == max_attempts){
            System.out.println("Клиент " + client.id + " не дождался свободного оператора");
            wait(waiting_time);
            return true;
        }
        else{
            System.out.println("Клиент " + client.id + " ждёт свободного оператора");
            wait(waiting_time);
        }
        return false;
    }

    public boolean searchForOperator(Operator operator, Client client){
        if(operator.getClient()==null){
            operator.setClient(client);
            operators.remove(operator);
            return true;
        }
        return false;
    }
}
