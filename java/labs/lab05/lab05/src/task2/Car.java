package task2;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Car implements Runnable{
    private final Semaphore token;
    private final Parking parking;
    private final int id;

    public Car(Semaphore token, Parking parking, int id){
        this.token = token;
        this.parking = parking;
        this.id = id;
    }

    public void parking(){
        System.out.println("Машина "+ this.id + " припарковалась на парковке под номером №" + this.parking.getId());
    }
    public void unParking(){
        System.out.println("Машина " +this.id + " покинула пароквку под номером №" + this.parking.getId());
    }

    public void run(){
        try{
            this.token.acquire();
            this.parking();
            Thread.sleep((long)(new Random()).nextInt(500));
            this.token.release();
            this.unParking();
        }
        catch (InterruptedException e){
                e.printStackTrace();
        }



    }

}
