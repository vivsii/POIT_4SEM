package org.example.cars;

public interface ICar {

    long getPrice();

    int getMaxSpeed();

    float getFuelConsumption();

    void setFuelConsumption(float fuelConsumption);

    void setPrice(long price);

    void setMaxSpeed(int maxSpeed);

    int fuelConsumptionToCompare();

}
