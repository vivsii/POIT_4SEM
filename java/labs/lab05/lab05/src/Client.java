public class Client implements Runnable {
    public int id;

    private static int waiting_time = 300;
    public CallCenter callCenter;

    public Client(CallCenter callCenter,int id){
        this.id = id;
        this.callCenter = callCenter;
    }

    @Override
    public void run(){
        Operator operator = null;

        try {
            while(operator == null){
                System.out.println("Клиент " + id + " пытается дозвониться");
                operator = callCenter.tryCall(this, waiting_time);
            }
            System.out.println("Клиент " + id + " позвонил оператору " + operator.getId());
            operator.talk();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
            if(operator != null){
                System.out.println("Клиент " + id + " завершил разговор с оператором " + operator.getId());
                callCenter.endCall(operator);
            }
        }
    }
}
