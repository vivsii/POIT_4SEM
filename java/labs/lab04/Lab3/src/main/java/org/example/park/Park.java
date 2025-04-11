package org.example.park;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import org.example.cars.Car;

import javax.xml.bind.annotation.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;
import java.util.stream.Stream;


@XmlType(name = "Park")
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class Park {

    @XmlElementWrapper(name = "cars")
    @XmlElementRef
    @JsonDeserialize(as = ArrayList.class)
    private ArrayList<Car> cars = new ArrayList<>();

    public Park(){}

    public Park(ArrayList<Car> cars) {
        this.cars = cars;
    }

    public ArrayList<Car> getCars() {
        return cars;
    }

    public void setCars(ArrayList<Car> cars) {
        this.cars = cars;
    }

    @Override
    public String toString(){
        StringBuilder carsStr = new StringBuilder();
        int iterator = 1;
        for (Object car : cars){
            carsStr.append(iterator++).append(": ").append(car);
        }
        return carsStr.toString();
    }

    public class Manager{
        public Manager(){}

        public long getParkPrice(){
            AtomicLong price = new AtomicLong();
            Stream<Car> stream = cars.stream();
            stream.forEach((car -> price.addAndGet(car.getPrice())));
            return price.get();
        }

        public Park getSortedPark(){
            ArrayList<Car> sortedCars = new ArrayList<>(getCars());
            sortedCars.sort(Car.COMPARE_BY_FUEL);
            return new Park(sortedCars);
        }


        public Park getCarsWithMaxSpeedRange(int bottomLimit, int upperLimit){
            Stream<Car> stream = cars.stream();
            stream = stream.filter((car -> car.getMaxSpeed() <- upperLimit && car.getMaxSpeed() >= bottomLimit));
            return new Park(new ArrayList<>(stream.collect(Collectors.toList())));
        }


    }

}
