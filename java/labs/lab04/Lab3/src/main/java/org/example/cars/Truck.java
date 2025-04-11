package org.example.cars;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlType(name = "Truck")
@XmlRootElement
public class Truck extends Car{

    public Truck(){super();}

    public Truck(long price) {
        super(price);
    }

    public Truck(float fuelConsumption) {
        super(fuelConsumption);
    }

    public Truck(int maxSpeed) {
        super(maxSpeed);
    }

    public Truck(float fuelConsumption, int maxSpeed) {
        super(fuelConsumption, maxSpeed);
    }

    public Truck(long price, int maxSpeed) {
        super(price, maxSpeed);
    }

    public Truck(long price, float fuelConsumption) {
        super(price, fuelConsumption);
    }

    public Truck(long price, float fuelConsumption, int maxSpeed) {
        super(price, fuelConsumption, maxSpeed);
    }

    @Override
    public String toString(){
        return  "Truck: " +
                "\n   price: " + this.getPrice() +
                "\n   fuel consumption: " + this.getFuelConsumption() +
                "\n   max speed: " + this.getMaxSpeed() + "\n";
    }

}
