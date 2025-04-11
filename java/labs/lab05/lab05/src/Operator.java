public class Operator {
    private int id;
    private Client client;


    public void talk(){
        try {
            Thread.sleep(800);
        }
        catch (InterruptedException e){
            e.printStackTrace();
        }
    }

    public Operator(int id){
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }
}
