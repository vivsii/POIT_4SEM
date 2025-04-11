package org.example.cars;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlType(name = "PassengerCar")
@XmlRootElement
public class PassengerCar extends Car{

    public PassengerCar(){super();}

    public PassengerCar(long price) {
        super(price);
    }

    public PassengerCar(float fuelConsumption) {
        super(fuelConsumption);
    }

    public PassengerCar(int maxSpeed) {
        super(maxSpeed);
    }

    public PassengerCar(float fuelConsumption, int maxSpeed) {
        super(fuelConsumption, maxSpeed);
    }

    public PassengerCar(long price, int maxSpeed) {
        super(price, maxSpeed);
    }

    public PassengerCar(long price, float fuelConsumption) {
        super(price, fuelConsumption);
    }

    public PassengerCar(long price, float fuelConsumption, int maxSpeed) {
        super(price, fuelConsumption, maxSpeed);
    }

    @Override
    public String toString(){
        return  "Passenger car: " +
                "\n   price: " + this.getPrice() +
                "\n   fuel consumption: " + this.getFuelConsumption() +
                "\n   max speed: " + this.getMaxSpeed() + "\n";
    }
}
