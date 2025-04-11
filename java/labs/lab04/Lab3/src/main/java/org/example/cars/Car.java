package org.example.cars;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

import java.util.Comparator;

@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, property="type")
@JsonSubTypes({
        @JsonSubTypes.Type(value=Bus.class, name="bus"),
        @JsonSubTypes.Type(value=Truck.class, name="truck"),
        @JsonSubTypes.Type(value=PassengerCar.class, name="passenger_car")
})
public abstract class Car implements ICar{

    private long price;

    private float fuelConsumption;

    private int maxSpeed;

    public Car(){}

    public Car(long price) {
        super();
        this.price = price;
    }

    public Car(float fuelConsumption) {
        super();
        this.fuelConsumption = fuelConsumption;
    }

    public Car(int maxSpeed) {
        super();
        this.maxSpeed = maxSpeed;
    }

    public Car(float fuelConsumption, int maxSpeed) {
        super();
        this.fuelConsumption = fuelConsumption;
        this.maxSpeed = maxSpeed;
    }

    public Car(long price, int maxSpeed) {
        super();
        this.price = price;
        this.maxSpeed = maxSpeed;
    }

    public Car(long price, float fuelConsumption) {
        super();
        this.price = price;
        this.fuelConsumption = fuelConsumption;
    }

    public Car(long price, float fuelConsumption, int maxSpeed) {
        super();
        this.price = price;
        this.fuelConsumption = fuelConsumption;
        this.maxSpeed = maxSpeed;
    }

    public long getPrice() {
        return price;
    }

    public int getMaxSpeed() {
        return maxSpeed;
    }

    public float getFuelConsumption() {
        return fuelConsumption;
    }

    public void setFuelConsumption(float fuelConsumption) {
        this.fuelConsumption = fuelConsumption;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public void setMaxSpeed(int maxSpeed) {
        this.maxSpeed = maxSpeed;
    }

    public int fuelConsumptionToCompare() {
        return (int)(fuelConsumption*1000);
    }

    @Override
    public String toString(){
        return "price: " + this.price +
                "\n   fuel consumption: " + this.fuelConsumption +
                "\n   max speed: " + this.maxSpeed + "\n";
    }

    public static final Comparator<Car> COMPARE_BY_FUEL = Comparator.comparingInt(Car::fuelConsumptionToCompare);
}
