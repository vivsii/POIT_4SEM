package org.example.cars;

public enum MaxSpeed {
    M150(150), M160(160), M170(170), M180(180), M190(190), M200(200),
    M210(210), M220(220), M230(230), M240(240), M250(250), M260(260),
    M270(270), M280(280), M290(290), M300(300), M310(310), M320(320);

    private final int maxSpeed;

    MaxSpeed(int maxSpeed){
        this.maxSpeed = maxSpeed;
    }

    public int getMaxSpeed(){
        return maxSpeed;
    }
}
