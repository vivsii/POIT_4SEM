package org.example.cars;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlType(name = "Bus")
@XmlRootElement
public class Bus extends Car{

    public Bus(){super();}

    public Bus(long price) {
        super(price);
    }

    public Bus(float fuelConsumption) {
        super(fuelConsumption);
    }

    public Bus(int maxSpeed) {
        super(maxSpeed);
    }

    public Bus(float fuelConsumption, int maxSpeed) {
        super(fuelConsumption, maxSpeed);
    }

    public Bus(long price, int maxSpeed) {
        super(price, maxSpeed);
    }

    public Bus(long price, float fuelConsumption) {
        super(price, fuelConsumption);
    }

    public Bus(long price, float fuelConsumption, int maxSpeed) {
        super(price, fuelConsumption, maxSpeed);
    }

    @Override
    public String toString(){
        return  "Bus: " +
                "\n   price: " + this.getPrice() +
                "\n   fuel consumption: " + this.getFuelConsumption() +
                "\n   max speed: " + this.getMaxSpeed() + "\n";
    }
}
