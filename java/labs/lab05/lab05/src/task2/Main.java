package task2;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Semaphore;

public class Main {
    public static void main(String args[]){
        Parking first = new Parking(1,4);
        Parking second = new Parking(2,2);
        Semaphore sem1 = new Semaphore(first.getCapacity(),true);
        Semaphore sem2 = new Semaphore(second.getCapacity(), true);
        ExecutorService executor = Executors.newCachedThreadPool();

        int i = 1;

        while(i <= 7){
                executor.execute(new Car(sem1,first,i++));
                executor.execute(new Car(sem2,second,i++));
        }
        executor.shutdown();
    }
}
